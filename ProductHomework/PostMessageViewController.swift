//
//  PostMessageViewController.swift
//  ProductHomework
//
//  Created by 諸星水晶 on 2020/09/26.
//

import UIKit
import Firebase

class PostMessageViewController: UIViewController {
    
    @IBOutlet var messageTextField: UITextField!
    
    var messageArray = [String]()
    
    var message = ""
    
    
    @IBAction func didTapPostButton(){
        message = messageTextField.text!
        messageArray.append(message)
        let db = Firestore.firestore()
            db.collection("users").document("message").setData([
                "message": messageArray
            ]) { error in
                if error != nil {
                    print("エラー")
                    return
                }
                // 成功したときの処理
                self.dismiss(animated: true, completion: nil)
            }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        messageTextField.placeholder = "Content"
        
    }
    
    
    
}
