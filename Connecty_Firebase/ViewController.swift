//
//  ViewController.swift
//  Connecty_Firebase
//
//  Created by 공대생 on 2021/01/25.
//

import UIKit
import SnapKit
import Firebase

class ViewController: UIViewController {

    var box = UIImageView()
    var remoteConfig: RemoteConfig!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
        
        remoteConfig.fetch() { (status, error) -> Void in
          if status == .success {
            print("Config fetched!")
            self.remoteConfig.activate() { (changed, error) in
              // ...
            }
          } else {
            print("Config not fetched")
            print("Error: \(error?.localizedDescription ?? "No error available.")")
          }
          self.displayWelcome()
        }
        
        self.view.addSubview(box)
        box.snp.makeConstraints{ (make) in
            make.center.equalTo(self.view)
        }
        box.image = #imageLiteral(resourceName: "FirebaseTestIcon")
        //self.view.backgroundColor = UIColor(hex : "#000000")
    }

    func displayWelcome(){
        
        let color = remoteConfig["splash_background"].stringValue
        let caps = remoteConfig["splash_message_caps"].boolValue
        let message = remoteConfig["splash_message"].stringValue
        
        if(caps){ //caps값이 true면 경고창을 띄워서 앱 종료하도록
            let alert = UIAlertController(title: "공지사항", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action)in
                exit(0) //0을 넣어주면 꺼지게 됨
            }))
            self.present(alert, animated: true, completion: nil)
        }
        self.view.backgroundColor = UIColor(hex: color!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        
        scanner.scanLocation = 1
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}
