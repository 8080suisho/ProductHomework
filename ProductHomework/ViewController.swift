//
//  ViewController.swift
//  ProductHomework
//
//  Created by 諸星水晶 on 2020/09/25.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var mailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    func showErrorIfNeeded(_ errorOrNil: Error?) {
        
        guard errorOrNil != nil else { return }
        
        let message = "エラーが起きました"
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.placeholder = "Name"
        mailTextField.placeholder = "Mail"
        passwordTextField.placeholder = "Password"
    }
    
    @IBAction func didTapLoginButton(){
        
        let email = mailTextField.text ?? ""
            let password = passwordTextField.text ?? ""
            let name = nameTextField.text ?? ""
            
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
                guard let self = self else { return }
                if let user = result?.user {
                    let req = user.createProfileChangeRequest()
                    req.displayName = name
                    req.commitChanges() { [weak self] error in
                        guard let self = self else { return }
                        if error == nil {
                            user.sendEmailVerification() { [weak self] error in
                                guard let self = self else { return }
                                if error == nil {
                                    // 仮登録完了画面へ遷移する処理
                                    let db = Firestore.firestore()
                                        db.collection("users").document(user.uid).setData([
                                            "userName": name
                                        ]) { error in
                                            if error != nil {
                                                // エラー処理
                                                return
                                            }
                                            // 成功したときの処理
                                            self.performSegue(withIdentifier: "toChat", sender: nil)
                                        }
                                    
                                }
                                self.showErrorIfNeeded(error)
                            }
                        }
                        self.showErrorIfNeeded(error)
                    }
                }
                self.showErrorIfNeeded(error)
            }
        }


}

