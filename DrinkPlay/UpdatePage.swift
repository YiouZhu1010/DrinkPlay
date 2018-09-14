//
//  UpdatePage.swift
//  DrinkPlay
//
//  Created by EO on 31/03/2018.
//  Copyright © 2018 EO. All rights reserved.
//

import UIKit
import Alamofire
import UserNotifications
import Firebase



class UpdatePage: UIViewController {

    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var profile1: UIImageView!
    @IBOutlet weak var profile3: UIImageView!
    @IBOutlet weak var profile2: UIImageView!

    @IBOutlet weak var number1: UILabel!
    @IBOutlet weak var number2: UILabel!
    @IBOutlet weak var number3: UILabel!
    @IBOutlet weak var plus1: UIButton!
    @IBOutlet weak var minus1: UIButton!
    @IBOutlet weak var plus2: UIButton!
    @IBOutlet weak var minus2: UIButton!
    @IBOutlet weak var plus3: UIButton!
    @IBOutlet weak var minus3: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBAction func updateQuantity(_ sender: UIButton) {
        if sender.tag/2 == 0 {
            if sender.tag == 1 {
                quantity1 = quantity1+1
            } else if sender.tag == 0 {
                if quantity1 != 0 {
                    quantity1 = quantity1-1
                }
            }
            number1.text = String(quantity1)
            Alamofire.request(url+"/user/\(userID)/group/\(groupID)/cheers", method: .post, parameters: ["drinkName":"Beer"], encoding:URLEncoding.default, headers:nil).responseJSON{ response in switch response.result {
            case .success(let jsonData):
                print(jsonData)
            case .failure(let error):
                print(error)
                }
            }
        } else if sender.tag/2 == 1 {
            if sender.tag == 3 {
                quantity2 = quantity2+1
            } else if sender.tag == 2 {
                if quantity2 != 0 {
                    quantity2 = quantity2-1
                }
            }
            number2.text = String(quantity2)
            Alamofire.request(url+"/user/\(userID)/group/\(groupID)/cheers", method: .post, parameters: ["drinkName":"Wine"], encoding:URLEncoding.default, headers:nil).responseJSON{ response in switch response.result {
            case .success(let jsonData):
                print(jsonData)
            case .failure(let error):
                print(error)
                }
            }
        } else if sender.tag/2 == 2 {
            if sender.tag == 5 {
                quantity3 = quantity3+1
            } else if sender.tag == 4 {
                if quantity3 != 0 {
                    quantity3 = quantity3-1
                }
            }
            number3.text = String(quantity3)
            Alamofire.request(url+"/user/\(userID)/group/\(groupID)/cheers", method: .post, parameters: ["drinkName":"Liqour"], encoding:URLEncoding.default, headers:nil).responseJSON{ response in switch response.result {
            case .success(let jsonData):
                print(jsonData)
            case .failure(let error):
                print(error)
                }
            }
        }
       
    }
    
    @IBAction func goToGame(_ sender: Any) {
        performSegue(withIdentifier: "goToGame", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        minus1.tag = 0
        plus1.tag = 1
        minus2.tag = 2
        plus2.tag = 3
        minus3.tag = 4
        plus3.tag = 5
        number1.text = String(quantity1)
        number2.text = String(quantity2)
        number3.text = String(quantity3)
        profilePic.layer.cornerRadius = profilePic.frame.size.width/2
        profilePic.clipsToBounds = true
        profile1.layer.cornerRadius = profile1.frame.size.width/2
        profile1.clipsToBounds = true
        profile2.layer.cornerRadius = profile2.frame.size.width/2
        profile2.clipsToBounds = true
        profile3.layer.cornerRadius = profile3.frame.size.width/2
        profile3.clipsToBounds = true
        let swipeToGame = UISwipeGestureRecognizer(target:self, action: #selector(swipeAction(swipe:)))
        swipeToGame.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeToGame)
        nameLabel.text = userName
        profilePic.image = profilePicture
        if wine1 == 0 {
            plus1.isEnabled = false
//            minus1.isEnabled = false
        }
        if wine2 == 0 {
            plus2.isEnabled = false
//            minus2.isEnabled = false
        }
        if wine3 == 0 {
            plus3.isEnabled = false
//            minus3.isEnabled = false
        }
        minus1.isEnabled = false
        minus2.isEnabled = false
        minus3.isEnabled = false
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UIViewController {
    @objc func swipeAction(swipe:UISwipeGestureRecognizer) {
        switch swipe.direction.rawValue {
        case 1:
            performSegue(withIdentifier: "viewStatus", sender: self)
        case 2:
            performSegue(withIdentifier: "goToGame", sender: self)
        default:
            break
        }
    }
}
