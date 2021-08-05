//
//  PicturesViewController.swift
//  VKAuth
//
//  Created by Nikita Entin on 05.08.2021.
//

import UIKit

class PicturesViewController: UIViewController {

    private var auth: Authentication?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        auth = Authentication()
        // Do any additional setup after loading the view.
    }

    @IBAction func exitFromAccount(_ sender: UIBarButtonItem) {
        auth?.logOut()
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! ViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
}
