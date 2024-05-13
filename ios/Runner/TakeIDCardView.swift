//
//  TakeIDCardView.swift
//  Runner
//
//  Created by Tim on 2024/4/26.
//

import UIKit
import AVFoundation

class TakeIDCardView : UIViewController {
    
    var cardType : String?
    var didTakePictureAction: ((_ selectedImage: String?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(videoPreview)
        view.addSubview(leftCover)
        leftCover.addSubview(backBtn)
        view.addSubview(rightCover)
        rightCover.addSubview(shutterBtn)
        view.addSubview(indicatorLabel)
        
        setupCamera()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        videoPreview.frame = view.bounds
        previewLayer.backgroundColor = UIColor.black.cgColor
        videoPreview.layer.addSublayer(previewLayer)
        previewLayer.frame = videoPreview.bounds
        
        leftCover.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 116)
        rightCover.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 116, width: UIScreen.main.bounds.width, height: 116)
        backBtn.frame = CGRect(x: UIScreen.main.bounds.width - 44 - 12, y: 60, width: 44, height: 44)
        shutterBtn.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 30, y: (rightCover.bounds.height - 60) / 2, width: 60, height: 60)
        indicatorLabel.sizeToFit()
        indicatorLabel.center = CGPoint(x: UIScreen.main.bounds.width - 26, y: UIScreen.main.bounds.height / 2)
        indicatorLabel.transform = CGAffineTransformMakeRotation(Double.pi / 2)
    }
    
    private lazy var videoPreview = {
        let preview = UIView()
        preview.backgroundColor = .black
        return preview
    }()
    
    private lazy var indicatorLabel : UILabel = {
        let lb = UILabel()
        lb.text = "Please put your \(cardType ?? "") card into the box"
        lb.textColor = UIColor.white
        lb.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return lb
    }()
    
    private lazy var leftCover : UIView = {
        let cover = UIView()
        cover.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return cover
    }()
    
    private lazy var rightCover : UIView = {
        let cover = UIView()
        cover.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return cover
    }()
    
    private lazy var backBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "back_btn"), for: .normal)
        btn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return btn
    }()
    
    private lazy var shutterBtn : UIButton  = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "shutter_icon"), for: .normal)
        btn.addTarget(self, action: #selector(takePictureAction), for: .touchUpInside)
        return btn
    }()
    
    private var session : AVCaptureSession?
    private let output : AVCapturePhotoOutput = AVCapturePhotoOutput()
    private let previewLayer : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer()
    private var currentTakenImage : String?
    
    
    
}

extension TakeIDCardView {
    private func setupCamera() {
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                
                if session.canAddOutput(output) {
                    session.addOutput(output)
                }
                
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                DispatchQueue.global().async {
                    session.startRunning()
                }
                
                self.session = session
            } catch {
                ErrorAlertView.showAlert(with: "Take photo error") {
                    self.dismiss(animated: true)
                } confirmAction: {
                    self.dismiss(animated: true)
                }
            }
        }
    }
    
    @objc  func backAction() {
        self.dismiss(animated: true)
    }
    
    @objc func takePictureAction() {
        output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
}

extension TakeIDCardView : AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: (any Error)?) {
        guard let data = photo.fileDataRepresentation(),
              let image = UIImage(data: data) else {
            ErrorAlertView.showAlert(with: error?.localizedDescription ?? "", cancelAction: backAction) {
                self.session?.startRunning()
            }
            
            return
        }
        session?.stopRunning()
        
        
        let rotaedImage = UIImage(cgImage: image.cgImage!, scale: image.scale, orientation: .up)
        guard let imgPath = saveImage(image: rotaedImage) else {
            ErrorAlertView.showAlert(with: "Photo save failed, please take one again!", cancelAction: backAction) {
                self.session?.startRunning()
            }
            return
        }
        
        didTakePictureAction?(imgPath)
        backAction()
    }
    
    func saveImage(image: UIImage?) -> String? {
        if let data = image?.jpegData(compressionQuality: 1) {
            let imgPath = NSTemporaryDirectory() + "temp.jpg"
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: imgPath) {
                // 删除文件
                guard (try? fileManager.removeItem(atPath: imgPath)) != nil else {
                    return nil
                }
            }
            
            // write it to sandbox as file
            let isSuccess = FileManager.default.createFile(atPath: imgPath, contents: data)
            
            if(isSuccess) {
                return imgPath
            }
        }
        return nil
    }
}
