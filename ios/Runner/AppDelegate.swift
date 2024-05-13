import UIKit
import Flutter
import CryptoSwift

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        currentController = window.rootViewController as? FlutterViewController
        methodChannel = FlutterMethodChannel(name: "paghiram.method.channel", binaryMessenger: currentController as! FlutterBinaryMessenger)
        
        methodChannel.setMethodCallHandler { call, resut in
            if call.method == "cryptoAES" {
                let map = call.arguments as! [String : String]
                let cryptedText = (map["plaintText"] ?? "").aes(_with: map["secretKey"] ?? "").base64String
                resut(["cryptedText" : cryptedText])
            }
            
            if call.method == "takeIDCardPicture" {
                let map = call.arguments as! [String : String]
                let cardType = map["type"] ?? ""
                self.go2takeIDCard(type: cardType)
            }
        }
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private var currentController : FlutterViewController!
    private var methodChannel : FlutterMethodChannel!
}

extension AppDelegate {
    func go2takeIDCard(type: String) {
        let cameraView = TakeIDCardView()
        cameraView.cardType = type
        cameraView.didTakePictureAction = { imgPath in
            self.methodChannel.invokeMethod("takePhotoCompleted", arguments: imgPath)
        }
        cameraView.modalPresentationStyle = .fullScreen
        currentController.present(cameraView, animated: true)
    }
}


extension String {
    func aes(_with secretKey: String) -> String {
        guard let plainTextData = data(using: .utf8) else { return self }
        let keyData = secretKey.data(using: .utf8)?.sha256()
        do {
            //let iv = AES.randomIV(AES.blockSize)
            let iv:[UInt8] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
            let aes = try AES(key:keyData!.bytes , blockMode: CBC(iv: iv), padding: .pkcs5)
            let data = Data(try aes.encrypt(plainTextData.bytes))
            return data.base64EncodedString()
        } catch  {
            return ""
        }
    }
    
    var base64String : String {
        self.data(using: .utf8)!.base64EncodedString()
    }
    
    
}
