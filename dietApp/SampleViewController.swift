//
//  SampleViewController.swift
//  dietApp
//
//  Created by 伴地慶介 on 2021/11/23.
//

import UIKit
import AuthenticationServices
import Alamofire
import SwiftyJSON
import KeychainAccess

class SampleViewController: UIViewController {

    var charenges:[Charenge] = []
    
    @IBOutlet weak var charengeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        charengeTableView.dataSource = self
        charengeTableView.delegate = self
        
        let url = "http://localhost/api/charenges"
        
        AF.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value).arrayValue
                print(json)
                self.charenges = []
                for charenges in json {
                    let charenge = Charenge(
                        id: charenges["id"].int!,
                        title: charenges["title"].string!,
                        body: charenges["body"].string!
                    )
                    self.charenges.append(charenge)
                }
                self.charengeTableView.reloadData()
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SampleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charenges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = charenges[indexPath.row].title + " : " + charenges[indexPath.row].body
        return cell
    }
    
}

extension SampleViewController: UITableViewDelegate {
    
    //セルの編集許可
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    //スワイプしたセルを削除　※arrayNameは変数名に変更してください
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            charenges.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
    }
}
