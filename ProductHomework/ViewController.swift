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
    
    @IBAction func didTapLoginButton(){
        self.performSegue(withIdentifier: "toChat", sender: nil)
    }
    
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
    
    


}

