//
//  BiometricIdAuth.swift
//  BookTableViewApp
//
//  Created by Paolo Cifuentes on 10/5/21.
//

import LocalAuthentication
import UIKit

enum BiometricType {
  case none
  case touchID
  case faceID
}

class BiometricIdAuth {
    let context = LAContext()
    var loginReason = "Login with "
    var biometric = ""
    
    func authenticateUser(completion: @escaping (String?) -> Void) {
        guard canEvaluatePolicy() else {
            completion(biometric + " not available")
            return
          }
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: loginReason + biometric) { success, error in
            if success {
                DispatchQueue.main.async {
                    completion(nil)
                }
            } else {
                let message: String
                
                switch error {
                default:
                    message = "Identity verification Failed"
                }
                DispatchQueue.main.async {
                    completion(message)
                }
            }
        }
    }
    
    func biometricType() -> BiometricType {
        _ = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        switch context.biometryType {
        case .none:
        return .none

        case .touchID:
            biometric = "TouchID"
            return .touchID

        case .faceID:
            biometric = "FaceID"
            return .faceID

        default:
          return .none
        }
    }
    
    func canEvaluatePolicy() -> Bool {
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
}
