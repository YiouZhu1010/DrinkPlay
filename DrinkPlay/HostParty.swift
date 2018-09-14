//
//  HostParty.swift
//  DrinkPlay
//
//  Created by EO on 03/04/2018.
//  Copyright © 2018 EO. All rights reserved.
//

import UIKit
import Alamofire
var wine1 = 0
var wine2 = 0
var wine3 = 0
var partyCode = ""

class HostParty: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = userName
        profilePic.image = profilePicture
        profilePic.layer.cornerRadius = profilePic.frame.size.width/2
        profilePic.clipsToBounds = true
        quantity1 = 0
        quantity2 = 0
        quantity3 = 0
    }

    @IBOutlet weak var checkbox1: UIButton!
    @IBOutlet weak var checkbox2: UIButton!
    @IBOutlet weak var checkbox3: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var warningText: UILabel!
    @IBAction func checkBox1(_ sender: Any) {
        if wine1 == 0 {
        checkbox1.setImage(UIImage(named:"selected.png"),for:UIControlState.normal)
            wine1 = 1
        } else {
            checkbox1.setImage(UIImage(named:"checkbox.png"),for:UIControlState.normal)
            wine1 = 0
        }
    }
    @IBAction func checkBox2(_ sender: Any) {
        if wine2 == 0 {
            checkbox2.setImage(UIImage(named:"selected.png"),for:UIControlState.normal)
            wine2 = 1
        } else {
            checkbox2.setImage(UIImage(named:"checkbox.png"),for:UIControlState.normal)
            wine2 = 0
        }
    }
    @IBAction func checkBox3(_ sender: Any) {
        if wine3 == 0 {
            checkbox3.setImage(UIImage(named:"selected.png"),for:UIControlState.normal)
            wine3 = 1
        } else {
            checkbox3.setImage(UIImage(named:"checkbox.png"),for:UIControlState.normal)
            wine3 = 0
        }
    }
    @IBAction func getCode(_ sender: Any) {
        //submit the choice and get the code of the party
        if wine1 == 0 && wine2 == 0 && wine3 == 0 {
            warningText.text = "Please select at least one alcohol."
            return
        }
        Alamofire.request(url+"/user/\(userID)/createGroup", method: .post, parameters: ["userId":userID], encoding:URLEncoding.default, headers:nil).responseJSON{ response in switch response.result {
        case .success(let jsonData):
            print(jsonData)
            let json:[String:Any] = jsonData as! [String : Any]
            partyCode = json["password"] as! String
            groupID = json["id"] as! String
            leaderID = json["leaderId"] as! String
            self.performSegue(withIdentifier: "showPartyCode", sender: self)
        case .failure(let error):
            print(error)
            }
        }
        
    }
    
}
