import UIKit
import RyukieSwifty
import Flutter
import CryptoSwift

var isGlobalSecureScreen = false

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .white
        let vc = PLFViewController()
        window.rootViewController = vc
        
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
            
            if call.method == "changeSecureScreenStatus" {
                let arguments = call.arguments as! [String : Any]
                isGlobalSecureScreen = arguments["isSecureScreen"] as! Bool
                let rootController = self.window.rootViewController as? PLFViewController
                rootController?.switchViewStatus()
                resut([:])
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

class PLFViewController : FlutterViewController {
    
    var isSecureScreen : Bool {
        return isGlobalSecureScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let v = view
        v?.backgroundColor = UIColor.white
        v?.frame = .zero
        view = makeSecureView();
        view.addSubview(v!)
    }
    
    
    func switchViewStatus() {
        let v = view.subviews[0]
        view = makeSecureView()
        view.addSubview(v)
    }
    
    private func makeSecureView() -> UIView? {
        let tf = UITextField()
        tf.isSecureTextEntry = isSecureScreen
        let fv = tf.subviews.first
        fv?.subviews.forEach{ $0.removeFromSuperview() }
        fv?.isUserInteractionEnabled = true
        return fv
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
