import Flutter
import UIKit
import SAMKeychain

public class FlutterUdidPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_udid", binaryMessenger: registrar.messenger)
        let instance = FlutterUdidPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getUDID":
            getUDID(result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func getUDID(result: @escaping FlutterResult) {
        let serviceName = "flutter_udid"
        let accountName = "udid"
        
        if let udid = SAMKeychain.password(forService: serviceName, account: accountName) {
            result(udid)
            return
        }
        
        // Generate a new UUID if we don't have one yet
        let udid = UUID().uuidString
        
        do {
            try SAMKeychain.setPassword(udid, forService: serviceName, account: accountName)
            result(udid)
        } catch {
            result(FlutterError(code: "KEYCHAIN_ERROR", 
                               message: "Failed to store UDID in keychain", 
                               details: error.localizedDescription))
        }
    }
}
