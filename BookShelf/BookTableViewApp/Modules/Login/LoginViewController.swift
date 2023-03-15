//
//  LoginViewController.swift
//  BookTableViewApp
//
//  Created by Paolo Cifuentes on 9/23/21.
//

import LocalAuthentication
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var biometricButton: UIButton!

    let biometric = BiometricIdAuth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIForBiometric()
    }
    
    @IBAction private func biometricID(_ sender: Any) {
        biometric.authenticateUser { [weak self] message in
            if let message = message {
                  let alertView = UIAlertController(title: "Error",
                                                    message: message,
                                                    preferredStyle: .alert)
                  let okAction = UIAlertAction(title: "Okay", style: .default)
                  alertView.addAction(okAction)
                  self?.present(alertView, animated: true)
                } else {
                    if LocalNotification.shared.isAuthorized {
                        let content = LocalNotification.shared.configure(title: "Login Successful", subtitle: "Welcome in", body: "You are currently logged in", badge: 1)
                        LocalNotification.shared.configureRequest(content: content, time: 1, repeats: false)
                        LocalNotification.shared.configureActions(.action(title: "Read", identifier: "Read", option: .foreground),
                                                                  .action(title: "Ignore", identifier: "Ignore", option: [.destructive, .authenticationRequired]))
                    }
                  self?.performSegue(withIdentifier: "NextPage", sender: self)
                }
        }
    }
    
    func setupUIForBiometric() {
        switch biometric.biometricType() {
        case .faceID:
            biometricButton.setImage(UIImage(systemName: "faceid"), for: .normal)
            biometricButton.setTitle("Login with FaceID", for: .normal)

        case .touchID:
            biometricButton.setImage(UIImage(systemName: "touchid"), for: .normal)
            biometricButton.setTitle("Login with TouchID", for: .normal)

        default:
            break
        }
    }
}
