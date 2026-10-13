import UIKit
import Flutter
// import flutter_downloader

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
//     FlutterDownloaderPlugin.setPluginRegistrantCallback(registerPlugins)
    let launched = super.application(application, didFinishLaunchingWithOptions: launchOptions)
    if let controller = window?.rootViewController as? FlutterViewController {
      PixivQuicBridge.register(messenger: controller.binaryMessenger)
    } else {
      DispatchQueue.main.async { [weak self] in
        guard let controller = self?.window?.rootViewController as? FlutterViewController else {
          return
        }
        PixivQuicBridge.register(messenger: controller.binaryMessenger)
      }
    }
    return launched
  }
}

// private func registerPlugins(registry: FlutterPluginRegistry) {
//     if (!registry.hasPlugin("FlutterDownloaderPlugin")) {
//        FlutterDownloaderPlugin.register(with: registry.registrar(forPlugin: "FlutterDownloaderPlugin")!)
//     }
// }
