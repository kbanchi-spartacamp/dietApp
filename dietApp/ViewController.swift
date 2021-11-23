//
//  ViewController.swift
//  dietApp
//
//  Created by 伴地慶介 on 2021/11/23.
//

import UIKit
import AuthenticationServices
import Alamofire
import SwiftyJSON
import KeychainAccess

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTexiField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapLoginButton(_ sender: Any) {
        
        let email = emailTextField.text
        let password = passwordTexiField.text
        
        let url = "http://localhost/api/login"
        let parameters: Parameters = [
            "email": email,
            "password": password
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("#####")
                print(json)
                print("#####")
                self.nextView()
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func nextView() {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "sampleVC") as! SampleViewController
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true, completion: nil)
    }
    
}

