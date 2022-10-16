// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:pixgem/model_store/account_profile.dart';
import 'package:pixgem/api_app/api_base.dart';
import 'package:pixgem/store/account_store.dart';
import 'package:pixgem/store/global.dart';

class OAuth {
  static const String BASE_OAUTH_URL_HOST = "oauth.secure.pixiv.net";

  static const String HASH_SALT = "28c1fdd170a5204386cb1313c7077b34f83e4aaf4aa829ce78c231e05b0bae2c"; // 哈希盐值
  static const String GRANT_TYPE_AUTHORIZATION = "authorization_code"; // 初次校验获取token
  static const String GRANT_TYPE_REFRESH = "refresh_token"; // 刷新token

  /* 登录链接参数client=pixiv-ios专用: */
  static const String CLIENT_ID = "KzEZED7aC0vird8jWyHM38mXjNTY";
  static const String CLIENT_SECRET = "W9JZoJe00qPvJsiyCGT3CCtC6ZUtdpKpzMbNlUGP";
  static const String REFRESH_CLIENT_ID = "KzEZED7aC0vird8jWyHM38mXjNTY";
  static const String REFRESH_CLIENT_SECRET = "W9JZoJe00qPvJsiyCGT3CCtC6ZUtdpKpzMbNlUGP";

  /* 登录链接参数client=pixiv-android专用: */
  // static const String CLIENT_ID = "MOBrBDS8blbauoSck0ZfDbtuzpyT";
  // static const String CLIENT_SECRET = "lsACyCD94FhDUtGTXi3QzcFE2uU1hqtDaKeqrdwj";
  // static const String REFRESH_CLIENT_ID = "KzEZED7aC0vird8jWyHM38mXjNTY";
  // static const String REFRESH_CLIENT_SECRET = "W9JZoJe00qPvJsiyCGT3CCtC6ZUtdpKpzMbNlUGP";

  static late int requestTime; // 发起请求的时间戳，(用于标记token过期时间)

  static Dio dio = Dio(BaseOptions(
    baseUrl: 'https://$BASE_OAUTH_URL_HOST',
    connectTimeout: 10000,
    receiveTimeout: 10000,
    sendTimeout: 10000,
    contentType: Headers.jsonContentType,
    headers: {},
  ));

  OAuth() {
    var now = DateTime.now();
    requestTime = now.millisecondsSinceEpoch; // 发起请求的时间戳
    String time = getXClientTime(now);
    String timeHash = getXClientHash(xClientTime: time);
    dio = Dio(BaseOptions(
      baseUrl: 'https://$BASE_OAUTH_URL_HOST',
      connectTimeout: 10000,
      receiveTimeout: 10000,
      sendTimeout: 10000,
      contentType: Headers.jsonContentType,
      headers: {
        "x-client-time": time,
        "x-client-hash": timeHash,
      },
    ));
  }

  // 获取登录链接（会同时自动生成code_verifier并保存全局常量）
  static String getLoginWebViewUrl() {
    String codeVerifier = createCodeVerifier();
    String codeChallenge = codeVerifierToChallenge(codeVerifier: codeVerifier);
    GlobalStore.codeChallenge = codeChallenge;
    GlobalStore.codeVerifier = codeVerifier;
    return "https://app-api.pixiv.net/web/v1/login?code_challenge=$codeChallenge&code_challenge_method=S256&client=pixiv-ios";
  }

  // 请求token（含用户数据），需要code
  Future<AccountProfile> requestToken({required String code}) async {
    // print("code_ver=${CONSTANTS.code_verifier}");
    // print("code_cha=${CONSTANTS.code_challenge}");
    Response res = await dio.post<String>(
      "/auth/token",
      data: {
        "code": code,
        "code_verifier": GlobalStore.codeVerifier,
        "client_id": CLIENT_ID,
        "client_secret": CLIENT_SECRET,
        "include_policy": "true",
        "grant_type": GRANT_TYPE_AUTHORIZATION,
        "redirect_uri": "https://app-api.pixiv.net/web/v1/users/auth/pixiv/callback",
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        responseType: ResponseType.json,
      ),
    );
    return AccountProfile.fromJson(json.decode(res.data));
  }

  // 刷新token
  Future<AccountProfile> refreshToken(String refreshToken) async {
    Response res = await dio.post<String>(
      "/auth/token",
      data: {
        "refresh_token": refreshToken,
        "client_id": REFRESH_CLIENT_ID,
        "client_secret": REFRESH_CLIENT_SECRET,
        "include_policy": "true",
        "grant_type": GRANT_TYPE_REFRESH,
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        responseType: ResponseType.json,
      ),
    );
    return AccountProfile.fromJson(json.decode(res.data));
  }

  // 保存token到当前帐号
  Future saveTokenToCurrent(AccountProfile profile) async {
    profile.expiredTimestamp = requestTime + profile.expiresIn*1000; // 添加token的过期时间戳
    await AccountStore.updateAccountProfile(profile); // 存储或更新账号信息
    await AccountStore.setCurrentAccountId(id: profile.user.id); // 存储当前账号id
    GlobalStore.globalProvider.setCurrentAccount(profile); // 设置全局账号配置并通知更新UI；
    ApiBase().updateToken(); // dio更新请求头token
  }

  // 生成code_verifier，即生成随机字符串并进行base64Url处理
  static String createCodeVerifier({length = 32}) {
    var random = Random();
    var text = "";
    String possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    for (var i = 0; i < length; i++) {
      text += possible[random.nextInt(possible.length)]; // 0 ~ length-1
    }
    return base64UrlEncode(utf8.encode(text));
  }

  // 将code_verifier转换成code_challenge
  static String codeVerifierToChallenge({required String codeVerifier}) {
    var str = sha256.convert(utf8.encode(codeVerifier)).bytes;
    return base64UrlEncode(str).replaceAll('=', '').replaceAll('+', '-').replaceAll('/', '_');
  }

  // x-client-time
  static String getXClientTime(DateTime dateTime) {
    // yyyy-MM-ddTHH:mm:ss+00:00
    // 2021-06-27T12:08:15+08:00
    return formatDate(dateTime, [yyyy, '-', mm, '-', dd, 'T', HH, ':', mm, ':', ss, '+08:00']);
  }

  // x-client-hash
  static String getXClientHash({required xClientTime}) {
    var content = const Utf8Encoder().convert(xClientTime + HASH_SALT);
    return md5.convert(content).toString();
  }
}
