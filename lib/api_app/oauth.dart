// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/global/provider/current_account_provider.dart';
import 'package:pixgem/global/provider/shared_preferences_provider.dart';
import 'package:pixgem/storage/model/account_profile.dart';
import 'package:pixgem/request/http_requester.dart';
import 'package:pixgem/storage/account_storage.dart';

typedef Read = T Function<T>(ProviderListenable<T> provider);

/// 鉴权专用的Http请求工具
final oAuthHttpRequesterProvider = Provider.autoDispose(((ref) => HttpRequester(ref, baseOptions: OAuth.baseOptions)));

/// 在无法创建OAuth时，使用该Provider代替
final oAuthProvider = Provider.autoDispose(((ref) => OAuth(ref)));

class OAuth {
  OAuth(this.ref) {
    DateTime now = DateTime.now();

    requestTime = now.millisecondsSinceEpoch; // 发起请求的时间戳
    String time = getXClientTime(now);
    String timeHash = getXClientHash(xClientTime: time);

    // 携带时间戳校验
    requester.replaceBaseOption(
      OAuth.baseOptions.copyWith(headers: {
        "x-client-time": time,
        "x-client-hash": timeHash,
      }),
    );
  }

  final Ref ref;
  // final Read read;

  HttpRequester get requester => ref.read(oAuthHttpRequesterProvider);

  // BaseUrl
  static const String baseOauthUrlHost = "oauth.secure.pixiv.net";
  // 哈希盐值
  static const String hashSalt = "28c1fdd170a5204386cb1313c7077b34f83e4aaf4aa829ce78c231e05b0bae2c";
  // 初次校验获取token
  static const String grantTypeAuthorization = "authorization_code";
  // 刷新token
  static const String grantTypeRefresh = "refresh_token";

  // 登录链接参数 client=pixiv-ios 专用:
  static const String clientId = "KzEZED7aC0vird8jWyHM38mXjNTY";
  static const String clientSecret = "W9JZoJe00qPvJsiyCGT3CCtC6ZUtdpKpzMbNlUGP";
  static const String refreshClientId = "KzEZED7aC0vird8jWyHM38mXjNTY";
  static const String refreshClientSecret = "W9JZoJe00qPvJsiyCGT3CCtC6ZUtdpKpzMbNlUGP";

  // 登录链接参数 client=pixiv-android 专用:
  // static const String CLIENT_ID = "MOBrBDS8blbauoSck0ZfDbtuzpyT";
  // static const String CLIENT_SECRET = "lsACyCD94FhDUtGTXi3QzcFE2uU1hqtDaKeqrdwj";
  // static const String REFRESH_CLIENT_ID = "KzEZED7aC0vird8jWyHM38mXjNTY";
  // static const String REFRESH_CLIENT_SECRET = "W9JZoJe00qPvJsiyCGT3CCtC6ZUtdpKpzMbNlUGP";

  static late int requestTime; // 发起请求的时间戳，(用于标记token过期时间？)

  static BaseOptions get baseOptions => BaseOptions(
        baseUrl: 'https://$baseOauthUrlHost',
        connectTimeout: 10000,
        receiveTimeout: 10000,
        sendTimeout: 10000,
        contentType: Headers.jsonContentType,
        headers: {},
      );

  // 获取登录链接
  static String getLoginWebViewUrl(String codeVerifier) {
    String codeChallenge = codeVerifierToChallenge(codeVerifier: codeVerifier);
    return "https://app-api.pixiv.net/web/v1/login?code_challenge=$codeChallenge&code_challenge_method=S256&client=pixiv-ios";
  }

  /// 请求token（含用户数据）
  ///
  /// [codeVerifier] 需要使用 [createCodeVerifier] 函数创建
  Future<AccountProfile> requestToken(String code, String codeVerifier) async {
    // print("code_ver=${CONSTANTS.code_verifier}");
    // print("code_cha=${CONSTANTS.code_challenge}");
    Response res = await requester.post<String>(
      "/auth/token",
      data: {
        "code": code,
        "code_verifier": codeVerifier,
        "client_id": clientId,
        "client_secret": clientSecret,
        "include_policy": "true",
        "grant_type": grantTypeAuthorization,
        "redirect_uri": "https://app-api.pixiv.net/web/v1/users/auth/pixiv/callback",
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        responseType: ResponseType.json,
      ),
    );
    var profile = AccountProfile.fromJson(json.decode(res.data));
    profile.expiredTimestamp = requestTime + profile.expiresIn * 1000; // 添加token的过期时间戳
    return profile;
  }

  /// 刷新token
  Future<AccountProfile> refreshToken(String refreshToken) async {
    Response res = await requester.post<String>(
      "/auth/token",
      data: {
        "refresh_token": refreshToken,
        "client_id": refreshClientId,
        "client_secret": refreshClientSecret,
        "include_policy": "true",
        "grant_type": grantTypeRefresh,
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        responseType: ResponseType.json,
      ),
    );
    var profile = AccountProfile.fromJson(json.decode(res.data));
    profile.expiredTimestamp = requestTime + profile.expiresIn * 1000; // 添加token的过期时间戳
    return profile;
  }

  /// 保存token到本地
  Future<void> saveTokenToLocalStorage(AccountProfile profile) async {
    // 存储或更新账号信息
    await AccountStorage(ref.read(globalSharedPreferencesProvider)).updateAccountProfile(profile);
  }

  /// 保存token到本地，并登录到该帐号
  Future<void> saveAndLoginToken(AccountProfile profile) async {
    // 存储或更新账号信息
    await saveTokenToLocalStorage(profile);
    await AccountStorage(ref.read(globalSharedPreferencesProvider)).setCurrentAccountId(profile.user.id.toString());

    // 更新全局登录状态
    ref.invalidate(globalCurrentAccountProvider);
  }

  /// 生成code_verifier，即生成随机字符串并进行base64Url处理
  static String createCodeVerifier({length = 32}) {
    var random = Random();
    var text = "";
    String possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    for (var i = 0; i < length; i++) {
      text += possible[random.nextInt(possible.length)]; // 0 ~ length-1
    }
    return base64UrlEncode(utf8.encode(text));
  }

  //// 将code_verifier转换成code_challenge
  static String codeVerifierToChallenge({required String codeVerifier}) {
    var str = sha256.convert(utf8.encode(codeVerifier)).bytes;
    return base64UrlEncode(str).replaceAll('=', '').replaceAll('+', '-').replaceAll('/', '_');
  }

  /// x-client-time
  static String getXClientTime(DateTime dateTime) {
    // yyyy-MM-ddTHH:mm:ss+00:00
    // 2021-06-27T12:08:15+08:00
    return formatDate(dateTime, [yyyy, '-', mm, '-', dd, 'T', HH, ':', mm, ':', ss, '+08:00']);
  }

  /// x-client-hash
  static String getXClientHash({required xClientTime}) {
    var content = const Utf8Encoder().convert(xClientTime + hashSalt);
    return md5.convert(content).toString();
  }
}
