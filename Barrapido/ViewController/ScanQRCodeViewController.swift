//
//  ViewController.swift
//  Barrapido
//
//  Created by Mohammed Wasimuddin on 19/11/18.
//  Copyright © 2018 Wasim. All rights reserved.
//

import UIKit
import AVFoundation


class ScanQRCodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet weak var scanPreview: UIView!
    
    /* QRCode variables */
    var captureSession: AVCaptureSession!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    public var qrParseResult: ((String) -> ())?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        captureSession = AVCaptureSession()
        
        setAVSession()
        addVideoPreviewLayer()
        self.startScanning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(captureSession.isRunning == false) {
            
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(captureSession.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func startScanning() {
        
        captureSession.startRunning()
    }
    
    func addVideoPreviewLayer() {
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = CGRect(origin: CGPoint.zero, size: scanPreview.frame.size)
        scanPreview.layer.addSublayer(videoPreviewLayer!)
        
    }
    
    func setAVSession() {
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            
            print("Failed to get Camera device")
            return
        }
        
        let videoInput:AVCaptureDeviceInput
        
        do {
            
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            
        }catch {
            
            return
        }
        
        if(captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        }else {
            
            failed()
            return
        }
        
        let metaDataOutput = AVCaptureMetadataOutput()
        
        if(captureSession.canAddOutput(metaDataOutput)) {
            captureSession.addOutput(metaDataOutput)
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metaDataOutput.metadataObjectTypes = metaDataOutput.availableMetadataObjectTypes
            print(metaDataOutput.availableMetadataObjectTypes)
            
        }else {
            
            failed()
            
            return
        }
    }
    
    func failed() {
        
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac,animated: true)
        captureSession = nil
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            gotCQCode(code: stringValue)
        }
    }
    
    func gotCQCode(code:String) {
        
        print("gotCQCode:", code)
        
        guard let qrCode = parseQRCode(urlString: code) else {
            
            showAlertMessage(self, "Invalid QRCode.")
            dismissVC()
            return
        }
        
        print(qrCode)
        
        guard let qrParseResult = qrParseResult else {
            
            print("Parse result is nil.")
            dismissVC()
            return
        }
        
        qrParseResult(qrCode)
        dismissVC()
    }
    
    func dismissVC() {
        
        DispatchQueue.main.async {
            
            self.navigationController?.popViewController(animated: true)
        }
    }
}

