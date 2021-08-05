//
//  ViewController.swift
//  VKAuth
//
//  Created by Nikita Entin on 04.08.2021.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    private let auth = Authentication()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterButton.layer.cornerRadius = 8
        titleLabel.text = "Mobile Up \nGallery"
        auth.delegate = self
        
    }
    
    @IBAction func enterbuttonTapped(_ sender: UIButton) {
        auth.wakeUpSession()
    }
    
}

extension ViewController: AuthenticationDelegate {
    
    func showVC(_ viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
    
    func signIn() {
        print(#function)
        let nc = UIStoryboard(name: "Pictures", bundle: nil).instantiateInitialViewController() as! UINavigationController
        nc.modalPresentationStyle = .fullScreen
        let window = UIApplication.shared.windows.first
        window?.rootViewController = nc
    }
    
    func signInFailed() {
        print(#function)
    }
    
}

