//
//  EnterCode.swift
//  DrinkPlay
//
//  Created by EO on 04/04/2018.
//  Copyright © 2018 EO. All rights reserved.
//

import UIKit
import Alamofire

class EnterCode: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var code: UITextField!
    
    @IBOutlet weak var warningText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        code.delegate = self
        quantity1 = 0
        quantity2 = 0
        quantity3 = 0
        let swipeToMain = UISwipeGestureRecognizer(target:self, action: #selector(swipeMain(swipe:)))
        swipeToMain.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeToMain)
    }
    @objc func swipeMain(swipe:UISwipeGestureRecognizer) {
        switch swipe.direction.rawValue {
        case 1:
            performSegue(withIdentifier: "swipeToMain", sender: self)
        default:
            break
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        Alamofire.request(url+"/user/\(userID)/joinGroup", method: .post, parameters: ["password": code.text ?? ""], encoding:URLEncoding.default, headers:nil).responseJSON{ response in switch response.result {
        case .success(let jsonData):
            groupID = self.code.text!
            print(jsonData)
            self.performSegue(withIdentifier: "joinParty", sender: self)
        case .failure(let error):
            self.warningText.text = "The party does not exist."
            print(error)
            }
        }
        return false
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
