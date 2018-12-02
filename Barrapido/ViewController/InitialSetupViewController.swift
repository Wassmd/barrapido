//
//  InitialSetupViewController.swift
//  Barrapido
//
//  Created by Mohammed Wasimuddin on 21/11/18.
//  Copyright © 2018 Wasim. All rights reserved.
//

import UIKit

class InitialSetupViewController: UIViewController {
    
    
    @IBOutlet weak var welcomeDownloadLabel: UILabel!
    
    @IBOutlet weak var welcomeView: UIView!
    
    @IBOutlet weak var scanView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configure UI
        configureUI()
        
        //check if the Auth_key is present
        let auth_key = UserDefaults.standard.value(forKey: "auth_key") as? String
        
        //if auth_key is oresent go for session key
        if let _ = auth_key {
          
             getSessionKey()
            
        }else{
            
            register_device()
        }
    }
    
    private func configureUI() {
        
        //set Welcome layer boarder and corner
        welcomeDownloadLabel.layer.borderColor = UIColor(red: 71/255, green: 59/255, blue: 141/255, alpha: 1).cgColor
        welcomeDownloadLabel.layer.borderWidth = 2.0
        welcomeDownloadLabel.layer.cornerRadius = 8
        welcomeDownloadLabel.text = NSLocalizedString("To download the menu and to place an order just scan a QR-code provided by the bar, cafe, or restaurant. \n\nTo scan the code click on the \'QR-code\' button in the lower righthand corner which activates the camera on your device for the purpose. \n\nOnce the menu has been loaded you can select items in it, and then review and send the order.\n\nTo dismiss this message as well as others shown in this screen, just swipe it to the right.", comment: "Nothing")
        
        applyShadowOnView(welcomeView)
        applyShadowOnView(scanView)
        
        //setup scroll View
//        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 100 )
    }
    
    /* Applies shadow over the View */
   private func applyShadowOnView(_ view:UIView) {
        
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 5
        
    }
    
    /* Register the devices */
    func register_device() {
        
        RegisterDeviceService.shared.registerDevice { (result) in
            
            switch result {
                
            case .success( let auth_key):
                
                print(auth_key)
                
                /* save it */
                self.saveAuthKey(auth_key)
                
                //Now that we have Auth_key, request for session_key
                self.getSessionKey()
                
                break
                
            case .failure(let error):
                
                print(error)
                print("Failed to get AUTH_KEY")
                switch error {
                case .network( let message),.parser( let message),.custom( let message):
                    showAlertMessage(self, message+"\n"+" Failed to get AUTH Key.")
                }
            
                break
            }
        }
       
    }
    
    func getSessionKey() {
        
        //check if the Auth_key is present
        let auth_key = UserDefaults.standard.value(forKey: "auth_key") as? String
        
        guard let auth_key_stored = auth_key else{
            
            print("No Auth_key")
            return
        }
        
        SessionKeyService.shared.getSessionkey(auth_key: auth_key_stored) { (result) in
    
            DispatchQueue.main.async {
                
                switch result {
                    
                case .success( let session_key):
                    
                    print(session_key)
                    self.saveSessionKey(session_key)
                    break
                    
                case .failure(let error):
                    
                    print(error)
                    print("Failed to get session key")
                    switch error {
                    
                    case .network( let message),.parser( let message),.custom( let message):
                         showAlertMessage(self, message+"\n"+" Failed to get session key.")
                    }
                    
                    break
                }
            }
            
        }
    }
    
    private func saveAuthKey(_ auth_key: String) {
        
        UserDefaults.standard.set(auth_key, forKey: "auth_key")
        UserDefaults.standard.synchronize()
    }
    
    private func saveSessionKey(_ sessionKey: String) {
        
        UserDefaults.standard.set(sessionKey, forKey: "session_key")
        UserDefaults.standard.synchronize()
    }

    
    //MARK: ACTIONS
    func scanQRCodeAction()  {
        
        
    }
    
    
     // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if segue.identifier == "showQRScan" {
            
            let scanQRVC = segue.destination as! ScanQRCodeViewController
            
            scanQRVC.qrParseResult = { qrCode in
                
                print("inside a closure:",qrCode as Any)
                
                //Now we received qrCode. Go ahead with get_location_data
                self.getLocationData(with: qrCode)
            }
        }
     }
    
    func getLocationData(with qrCode:String) {
        
        //TODO: Verifying of Session to be done
        //TODO: get the location info and lat and lon
        if let sessionKey = UserDefaults.standard.value(forKey: "session_key") as? String {
        
            LocationDataService.shared.getLocationData(session_key: sessionKey, qrCode: qrCode, islocation: 0, lat: 0, lon: 0) { (result) in
                
                DispatchQueue.main.async {
                    
                    switch result {
                        
                    case .success( let locationData):
                        
                        print(locationData)
                        
                        break
                        
                    case .failure(let error):
                        
                        print(error)
                        print("Failed to get location Data")
                        switch error {
                            
                        case .network( let message),.parser( let message),.custom( let message):
                            showAlertMessage(self, message+"\n"+" Failed to get location data.")
                        }
                        
                        break
                    }
                }
                
            }
            
        }
    }
}
