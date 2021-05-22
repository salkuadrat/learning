import Flutter
import UIKit

public class SwiftLearningBarcodeScanningPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "learning_barcode_scanning", binaryMessenger: registrar.messenger())
    let instance = SwiftLearningBarcodeScanningPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
