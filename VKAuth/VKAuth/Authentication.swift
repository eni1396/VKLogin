//
//  Authentication.swift
//  VKAuth
//
//  Created by Nikita Entin on 04.08.2021.
//

import Foundation
import VK_ios_sdk

protocol AuthenticationDelegate: AnyObject {
    func showVC(_ viewController: UIViewController)
    func signIn()
    func signInFailed()
}

final class Authentication: NSObject {
    
    private let appID = "7919666"
    private let sdk: VKSdk
    
    weak var delegate: AuthenticationDelegate?
    static let shared = Authentication()
    
    override init() {
        sdk = VKSdk.initialize(withAppId: appID)
        super.init()
        sdk.register(self)
        sdk.uiDelegate = self
        print(#function)
    }
    
    func wakeUpSession() {
        let scope = ["offline"]
        VKSdk.wakeUpSession(scope) { [delegate] state, error in
            if state == .authorized {
                delegate?.signIn()
                print("authorized")
            } else if state == .initialized {
                print("initialized")
                VKSdk.authorize(scope)
            } else if let error = error {
                delegate?.signInFailed()
                print(error.localizedDescription)
            }
        }
    }
    
    func logOut() {
        VKSdk.forceLogout()
    }
    
}

extension Authentication: VKSdkDelegate, VKSdkUIDelegate {
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil {
            delegate?.signIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        delegate?.signInFailed()
        print(#function)
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        delegate?.showVC(controller)
        print(#function)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
    
}
