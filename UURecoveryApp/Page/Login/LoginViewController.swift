//
//  LoginViewController.swift
//  MXDataRecovery
//
//  Created by 嵇明新 on 2025/2/23.
//

import UIKit

class LoginViewController: BaseViewController {

    
    fileprivate var mainView: LoginView {
        return self.view as! LoginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.target = self
        view.backgroundColor = .white
        cx.navigationBar?.title = ""
        cx.navigationBar?.allBackgroundColor = .white
    }

    

    override func loadView() {
        view = LoginView()
    }
}
