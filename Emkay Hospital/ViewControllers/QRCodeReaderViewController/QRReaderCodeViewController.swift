//
//  QRReaderCodeViewController.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/2/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import AVFoundation
import UIKit
import PMAlertController

class QRCodeReaderViewController: BaseViewController {
    @IBOutlet weak var closeButton: UIButton!
    private let service = Service.sharedInstance
    
    private var video = AVCaptureVideoPreviewLayer()
    private var session = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let captureDevice = AVCaptureDevice.default(for: .video)!
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
        } catch let error {
            print(error)
            self.showAlert(title: Strings.alertTitle, message: error.localizedDescription)
        }
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [.qr]
        self.video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = self.view.layer.bounds
        self.view.layer.addSublayer(video)
        self.view.bringSubviewToFront(self.closeButton)
        session.startRunning()
    }
    
    @IBAction func didTapCloseButton(_ sender: Any) {
        self.session.stopRunning()
        self.dismiss(animated: true, completion: nil)
    }
}

extension QRCodeReaderViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject else {
            return
        }
        guard let QRCode = metadataObject.stringValue else {
            return
        }
        self.session.stopRunning()
        self.beginLoading()
        self.service.checkQRCode(QRCode: QRCode, failure: { (message) in
            self.endLoading()
            self.showAlert(title: Strings.alertTitle, message: message)
        }) { [weak self] (userName) in
            print(QRCode)
            self?.endLoading()
            let passwordTextFiled = UITextField()
            passwordTextFiled.isSecureTextEntry = true
            let title = String(format: Strings.account, userName)
            let alertController = PMAlertController(title: title, description: Strings.enterPassword, image: nil, style: .alert)
            alertController.addTextField(textField: passwordTextFiled, { (textField) in
            })
            let enterPasswordAction = PMAlertAction(title: Strings.enter, style: .default, action: {
                self?.beginLoading()
                self?.service.updatePasswordByQRCode(QRCode: QRCode, newPassword: passwordTextFiled.text ?? "", failure: { (message) in
                    self?.endLoading()
                    self?.showAlert(title: Strings.alertTitle, message: message)
                }, success: { (message) in
                    self?.endLoading()
                    self?.showAlert(title: Strings.alertTitle, message: message)
                })
            })
            alertController.addAction(enterPasswordAction)
            self?.present(alertController, animated: true, completion: nil)
        }
    }
}
