# Pixiv Artvier
[![GitHub stars](https://img.shields.io/github/stars/kerrinz/pixiv-artvier)](https://github.com/kerrinz/pixiv-artvier/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/kerrinz/pixiv-artvier)](https://github.com/kerrinz/pixiv-artvier/network)
[![GitHub release](https://img.shields.io/github/v/release/kerrinz/pixiv-artvier?include_prereleases)](https://github.com/kerrinz/pixiv-artvier/releases)
[![GitHub downloads](https://img.shields.io/github/downloads/kerrinz/pixiv-artvier/total.svg?label=downloads)](https://github.com/kerrinz/pixiv-artvier/releases)
[![GitHub license](https://img.shields.io/github/license/kerrinz/pixiv-artvier)](https://github.com/kerrinz/pixiv-artvier/blob/master/LICENSE)

## 技术栈

基于[`Flutter`](https://flutter.dev)构建。使用[`riverpod`](https://github.com/rrousselGit/riverpod)作为状态管理，[`intl`](https://pub.flutter-io.cn/packages/intl)适配国际化多语言。

## 简介

一个 pixiv 第三方 app，同时支持Android、IOS系统，仅用于学习交流使用。

预期将逐步支持插画、漫画、小说的各个功能。

## 安装方式
前往[`Release`](https://github.com/kerrinz/pixiv-artvier/releases)页面下载对应系统的安装包。

注：
1. 目前仅为预览版，存在不少问题且部分功能未完成；
2. 登录不支持使用 APP 自带的代理和直连功能，请自行外部代理；

## 完成度
### 交互功能
- [x] 多账号切换
- [X] 图片保存（目前仅支持保存到系统相册）
- [X] HTTP网络代理（登录除外）
- [x] 直连（登录除外）
- [x] 深色模式
- [x] 下载管理
- [ ] 主题配色
- [ ] 语言切换（目前仅支持中英双语跟随系统）

### 作品或页面功能

| 功能 | 已完成 | 未完成 |
|---|---|---|
| 推荐作品 | 插画 | 漫画 小说 |
| 排行榜 | 每日、每周排行等作品浏览 | 指定日期的历史排行 |
| Pixivision | 插画 | 漫画 |
| 搜索 | 插画漫画用户的搜索，部分筛选功能 | 部分筛选功能 |
| 热门标签 | ✓ | - |
| 关注新作、追更列表 | ✓ | - |
| 作品详情页 | 自定义收藏、浏览评论、相关推荐、动图加载 | 小说阅读、批量下载等 |
| 用户详情 | 用户的作品、收藏、详细资料、关注 | 修改个人资料 |
| 评论页 | 查看评论 | 发布和回复评论 |

## 部分截图展示

| 首页（IOS） | 个人页（IOS） |
|:---:|:---:|
|![](https://kerrinz.com/files/images/artvier/home_230227.jpg)|![](https://yleen.cc/files/images/artvier/profile_230227.jpg)

| 用户详情页（IOS） | 作品详情页（IOS） |
|:---:|:---:|
|![](https://kerrinz.com/files/images/artvier/user_detail_230227.jpg)|![](https://yleen.cc/files/images/artvier/illust_detail_230227.jpg)

## 开发环境
- Flutter 3.19.5 • channel stable • https://github.com/flutter/flutter.git
- Tools • Dart 3.3.3 • DevTools 2.31.1
- Xcode - develop for iOS and macOS (Xcode 16.2)
- Java SE 17.0.3
- macOS 15.2 (ARM)

## 辅助命令
### 切换 gradle 版本
```sh
cd android
./gradlew wrapper --gradle-version=7.3
```
### flutter 切换 jdk
```sh
flutter config --jdk-dir=你的JDK安装路径
```

### 构建l10n翻译
```sh
sh intl.sh
```

## 免责声明

1. 本软件不收取任何费用，且仅供学习和交流使用，不得用于其他任何用途（尤其是不得用于商业用途），如作它用所承受的法律责任一概与本人无关。
2. 本软件只在当前 Github 仓库发布，不会在其他任何地方开放下载。请您遵守当地法律法规，下载和传播本软件的法律责任请您自行承担。
3. 如果您当前所在的国家或地区不支持访问 Pixiv 官方网站，那么您可能无法直接使用使用本软件。
4. 本软件未架设服务器且未提供资源和服务，软件内的所有网络数据均来自Pixiv官方接口，所有作品（包括插画、漫画、小说等）的版权归属于Pixiv或原作者所有。
 