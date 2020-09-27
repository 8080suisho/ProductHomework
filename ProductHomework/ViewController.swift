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
    
    var name = ""
    
    func showErrorIfNeeded(_ errorOrNil: Error?) {
        // エラーがなければ何もしません
        guard errorOrNil != nil else { return }
        
        let message = "エラーが起きました" // ここは後述しますが、とりあえず固定文字列
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.placeholder = "Name"
    }
    
    @IBAction func didTapLoginButton(){
        name = nameTextField.text!
        let db = Firestore.firestore()
        db.collection("users").addDocument(data: [
                    "username": name
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
        
        
        self.performSegue(withIdentifier: "toChat", sender: nil)
    }
    
    


}

