//
//  DrunkTest.swift
//  DrinkPlay
//
//  Created by EO on 03/04/2018.
//  Copyright © 2018 EO. All rights reserved.
//

import UIKit
import Alamofire

var firstAnswer = 0
var secondAnswer = 0
var thirdAnswer = 0
var fourthAnswer = 0
var fifthAnswer = 0
class DrunkTest: UIViewController {
    
    
    @IBAction func buttonQ1A1(_ sender: Any) {
        firstQuestion(ans: 0)
    }
    @IBAction func buttonQ1A2(_ sender: Any) {
        firstQuestion(ans: 1)
    }
    @IBAction func buttonQ1A3(_ sender: Any) {
        firstQuestion(ans: 2)
    }
    @IBAction func buttonQ1A4(_ sender: Any) {
        firstQuestion(ans: 3)
    }
    @IBAction func buttonQ1A5(_ sender: Any) {
        firstQuestion(ans: 4)
    }
    @IBAction func buttonQ1A6(_ sender: Any) {
        firstQuestion(ans: 5)
    }
    @IBAction func buttonQ1A7(_ sender: Any) {
        firstQuestion(ans: 6)
    }
    @IBAction func buttonQ1A8(_ sender: Any) {
        firstQuestion(ans: 7)
    }
    @IBAction func buttonQ1A9(_ sender: Any) {
        firstQuestion(ans: 8)
    }
    @IBAction func buttonQ2A1(_ sender: Any) {
        secondQuestion(ans: 0)
    }
    @IBAction func buttonQ2A2(_ sender: Any) {
        secondQuestion(ans: 1)
    }
    @IBAction func buttonQ2A3(_ sender: Any) {
        secondQuestion(ans: 2)
    }
    @IBAction func buttonQ2A4(_ sender: Any) {
        secondQuestion(ans: 3)
    }
    @IBAction func buttonQ3A1(_ sender: Any) {
        thirdQuestion(ans: 0)
    }
    @IBAction func buttonQ3A2(_ sender: Any) {
        thirdQuestion(ans: 1)
    }
    @IBAction func buttonQ3A3(_ sender: Any) {
        thirdQuestion(ans: 2)
    }
    @IBAction func buttonQ3A4(_ sender: Any) {
        thirdQuestion(ans: 3)
    }
    @IBAction func buttonQ4A1(_ sender: Any) {
        fourthQuestion(ans: 0)
    }
    @IBAction func buttonQ4A2(_ sender: Any) {
        fourthQuestion(ans: 1)
    }
    @IBAction func buttonQ4A3(_ sender: Any) {
        fourthQuestion(ans: 2)
    }
    @IBAction func buttonQ4A4(_ sender: Any) {
        fourthQuestion(ans: 3)
    }
    @IBAction func buttonQ5A1(_ sender: Any) {
        fifthQuestion(ans: 0)
    }
    @IBAction func buttonQ5A2(_ sender: Any) {
        fifthQuestion(ans: 1)
    }
    @IBAction func buttonQ5A3(_ sender: Any) {
        fifthQuestion(ans: 2)
    }
    @IBAction func buttonQ5A4(_ sender: Any) {
        fifthQuestion(ans: 3)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func firstQuestion(ans: Int){
        firstAnswer = ans
        beginTime = Date()
        performSegue(withIdentifier: "nextQuestion1", sender: self)
    }
    func secondQuestion(ans: Int){
        secondAnswer = ans
        performSegue(withIdentifier: "nextQuestion2", sender: self)
    }
    func thirdQuestion(ans: Int){
        thirdAnswer = ans
        performSegue(withIdentifier: "nextQuestion3", sender: self)
    }
    func fourthQuestion(ans: Int){
        fourthAnswer = ans
        performSegue(withIdentifier: "nextQuestion4", sender: self)
    }
    func fifthQuestion(ans: Int){
        fifthAnswer = ans
        endTime = Date()
        let parameter = [
                "duration": (endTime.timeIntervalSince(beginTime)),
                "choices": [firstAnswer, secondAnswer, thirdAnswer, fourthAnswer,fifthAnswer]
            ] as [String : Any]
        let headers = [
            "content-type": "application/json",
            "cache-control": "no-cache"
        ]
        if count_login == 0 {
            count_login = count_login+1
            Alamofire.request(url+"/user/\(userID)/test", method: .put, parameters: parameter, encoding:JSONEncoding.default, headers:headers).responseJSON{ response in switch response.result {
            case .success(let jsonData):
                print(jsonData)
                self.performSegue(withIdentifier: "resultSober", sender: self)
                
            case .failure(let error):
                print(error)
                }
            }
        } else {
            Alamofire.request(url+"/user/\(userID)/group/\(groupID)/test", method: .post, parameters: parameter, encoding:JSONEncoding.default, headers:headers).responseJSON{ response in switch response.result {
            case .success(let jsonData):
                print(jsonData)
                self.performSegue(withIdentifier: "endDrunkTest", sender: self)
            case .failure(let error):
                print(error)
                }
            }
        }
        
//        var duration = Double(endTime.timeIntervalSince(beginTime))
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
