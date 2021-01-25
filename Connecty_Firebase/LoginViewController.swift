//
//  LoginViewController.swift
//  Connecty_Firebase
//
//  Created by 공대생 on 2021/01/25.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var signup: UIButton!
    let remoteConfig = RemoteConfig.remoteConfig()
    var color : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let statusBar = UIView()
        self.view.addSubview(statusBar)
        statusBar.snp.makeConstraints{(m) in
            m.right.top.left.equalTo(self.view)
            m.height.equalTo(20)
        }
        color = remoteConfig["splash_background"].stringValue
        
        login.backgroundColor = UIColor(hex : color)
        signup.backgroundColor = UIColor(hex : color)
        
        statusBar.backgroundColor = UIColor(hex: color)
        
        signup.addTarget(self, action: #selector(presentSignup), for: .touchUpInside)
    }
    
    @objc func presentSignup(){
        let view = self.storyboard?.instantiateViewController(identifier: "SignupViewController") as! SignupViewController
        // ㄴ해당 뷰컬트롤러의 Storyboard ID 로 동일하게 입력 !
        self.present(view, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
