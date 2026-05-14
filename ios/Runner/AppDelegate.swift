import Flutter
import UIKit
import flutter_sharing_intent

@main @objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

    func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
        GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    }

    override func application(_ app: UIApplication, openurl: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        let sharingIntent = SwiftFlutterSharingIntentPlugin.instance
        /// if the url is made from SwiftFlutterSharingIntentPlugin then handle it with plugin [SwiftFlutterSharingIntentPlugin]
        if sharingIntent.hasSameSchemePrefix(url: url) {
            return sharingIntent.application(app, open: url, options: options)
        }

        // Proceed url handling for other Flutter libraries like uni_links
        return super.application(app, open: url, options: options)
    }
}
