//
//  ViewController.swift
//  LoginApp
//
//  Created by Mário Sérgio Candian on 29/09/21.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (UserDefaults.standard.isLoggedIn()) {
            guard UserDefaults.standard.string(forKey: "userID") != nil else { return }
            performSegue(withIdentifier: "loginSegue", sender: self)
        }
        
        isLogout()
        // Do any additional setup after loading the view.

        //Map
//        let data = [1, 99, 20, 44, 67, 100]
//        let resultMap = data.map({ String($0) })
//        print(resultMap)
        
        //Filter
//        let data = [1, 99, 20, 44, 67, 100]
//        let resultFilter = data.filter({ $0 % 2 == 0 })
//        print(resultFilter)
        
        //Reduce
//        let data = [1, 2, 3, 4, 5]
//        let resultReduce = data.reduce(0, {$0 + $1})
//        print (resultReduce)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let _ : SecondScreen = segue.destination as! SecondScreen
     }
    
    @IBOutlet weak var loginEditTxt: UITextField!
    
    @IBOutlet weak var pwdEditTxt: UITextField!

    var logout: Bool = false
    func isLogout() {
        if (logout) {
            let alert = UIAlertController(title: "Logout", message: "User logout", preferredStyle: .actionSheet)
                  Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                      alert.dismiss(animated: true) }
                  self.present(alert, animated: true, completion: nil)
        }
    }

    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
                  return result
              }
    
    @IBAction func doLogin(_ sender: Any) {
        let checkEmail = isValidEmail(email: loginEditTxt.text!)
        if checkEmail == false {
        let alert = UIAlertController(title: "Erro", message: "E-mail não é válido", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        } else {
            UserDefaults.standard.setLoggedIn(value: true)          // String
            UserDefaults.standard.setUserID(value: loginEditTxt.text!) // String
            performSegue(withIdentifier: "loginSegue", sender: self)
        }
    }
}

enum UserDefaultsKeys : String {
    case isLoggedIn
    case userID
}

extension UserDefaults{

    //MARK: Check Login
    func setLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        //synchronize()
    }

    //MARK: Save User Data
    func setUserID(value: String){
        set(value, forKey: UserDefaultsKeys.userID.rawValue)
        //synchronize()
    }

    //MARK: Retrieve User Data
    func getUserID() -> String{
        return string(forKey: UserDefaultsKeys.userID.self.rawValue)!
    }
}
