//
//  ViewController.swift
//  BiometricAuthenticationIOS
//
//  Created by Rohan Manjunath Ashlesh on 14/01/22.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(frame: CGRect(x:0,y:0,width:200,height:50))
        view.addSubview(button)
        button.center = view.center
        button.setTitle("Authorize", for: .normal)
        button.backgroundColor = .systemGreen
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
    }
    
    @objc func didTapButton() {
        let context = LAContext()
        var error: NSError? = nil
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authorize with touch ID!"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, error in
                DispatchQueue.main.async {
                    guard success, error == nil else {
                        let alert = UIAlertController(title: "Failed to Authenticate", message: "Please Try Again", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                        self?.present(alert, animated: true)
                        return
                        
                    }
                    
                    let vc = UIViewController()
                    vc.title = "Welcome! Succesfully Authenticated."
                    vc.view.backgroundColor = .systemTeal
                    self?.present(UINavigationController(rootViewController: vc),animated: true,completion: nil)
                }
            }
        }
        else {
            //Not registered
            let alert = UIAlertController(title: "Biometric is Unavailable", message: "Please register Biometric if your iPhone has Biometric Feature.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
            
        }
        
    }
    
    
}

