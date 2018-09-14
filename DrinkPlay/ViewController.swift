//
//  ViewController.swift
//  DrinkPlay
//
//  Created by EO on 30/03/2018.
//  Copyright © 2018 EO. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import Alamofire

var userName = ""
var fbID = ""
var userID = ""
var lastDrinkTime = ""
var profilePicture = UIImage()
let loginManager = LoginManager()
var beginTime = Date()
var endTime = Date()
var count_login = 0
var groupID = ""
var leaderID = ""
var quantity1 = 0
var quantity2 = 0
var quantity3 = 0
let url = "http://13.59.78.50:8080/api"
//let url = "http://localhost:8080/api"
class ViewController: UIViewController {

    @IBAction func fbLogin(_ sender: UIButton) {
        loginManager.logIn(readPermissions:[ .publicProfile ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error.localizedDescription)
            case .cancelled:
                print("User cancelled login.")
            case .success(_,_,_):
                self.getUserInfo { userInfo, error in
                    if let error = error {print(error.localizedDescription)}
                    if let userInfo = userInfo, let id = userInfo["id"], let name = userInfo["name"],let _ = userInfo["picture"] {
                        userName = String(describing: name)
                        fbID = String(describing: id)
                        let picture = "https://graph.facebook.com/\(fbID)/picture?type=large"
                        let imageData = NSData(contentsOf: NSURL(string: picture)! as URL)
                        profilePicture = UIImage(data: imageData! as Data)!
                        Alamofire.request(url+"/user/login", method: .post, parameters: ["fbId": fbID, "name": userName], encoding:URLEncoding.default, headers:nil).responseJSON{ response in switch response.result {
                        case .success(let jsonData):
                            print(jsonData)
                            let json:[String:Any] = jsonData as! [String : Any]
                            userID = json["id"] as! String
                            lastDrinkTime = json["lastDrinkTime"] as! String
                            self.login()
                        case .failure(let error):
                            print(error)
                            }
                        }
                    }
                }
            }
        }
    }
    func getUserInfo(completion: @escaping (_:[String: Any]?,_:Error?) -> Void) {
        let request = GraphRequest(graphPath:"me", parameters:["fields": "id,name,picture"])
        request.start {response, result in
            switch result {
            case .failed(let error):
                completion(nil, error)
            case .success(let graphResponse):
                completion(graphResponse.dictionaryValue,nil)
            }
        }
    }
    func login() {
        
        if count_login == 0 {
            performSegue(withIdentifier: "login", sender: self)
        } else {
            performSegue(withIdentifier: "loginToMain", sender: self)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        if AccessToken.current != nil {
//            performSegue(withIdentifier: "login", sender: self)
//        }
    }
}

