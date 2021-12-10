//
//  SecondScreen.swift
//  LoginApp
//
//  Created by Mário Sérgio Candian on 05/10/21.
//

import UIKit

struct Logged {
    var logout: Bool = false
}

class SecondScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        print("ID : \(UserDefaults.standard.getUserID())")
//        UserDefaults.standard.getUserID()
        if (UserDefaults.standard.isLoggedIn()) {
            userLogged.text = UserDefaults.standard.getUserID()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ViewController {
            let vc = segue.destination as? ViewController
            vc?.logout = true
        }
    }
    
    @IBOutlet weak var userLogged: UILabel!


    @IBAction func doLogout(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.userID.rawValue)
        UserDefaults.standard.setLoggedIn(value: false)
        performSegue(withIdentifier: "logoutSegue", sender: self)
    }
}

extension UserDefaults {
    
    func isLoggedIn()-> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
    
}

