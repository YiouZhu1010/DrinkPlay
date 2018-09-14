//
//  GamePage.swift
//  DrinkPlay
//
//  Created by EO on 31/03/2018.
//  Copyright © 2018 EO. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

var cardNumber = 0
var suitNumber = 0
class GamePage: UIViewController {
    var game_count = 0
    func testing(){
        print("here")
    }
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var profile1: UIImageView!
    @IBOutlet weak var profile2: UIImageView!
    @IBOutlet weak var profile3: UIImageView!
    @IBOutlet weak var number1: UILabel!
    @IBOutlet weak var number2: UILabel!
    @IBOutlet weak var number3: UILabel!
    @IBOutlet weak var plus1: UIButton!
    @IBOutlet weak var minus1: UIButton!
    @IBOutlet weak var plus2: UIButton!
    @IBOutlet weak var minus2: UIButton!
    @IBOutlet weak var plus3: UIButton!
    @IBOutlet weak var minus3: UIButton!
    
    @IBOutlet weak var card: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var resumeButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var currentCardNumber: UILabel!
    @IBOutlet weak var currentCard: UILabel!
    @IBOutlet weak var ruleDetail: UILabel!
    let titles = [
    "Waterfall","You","Me","Ladies","Bust a jive","Guys","Heaven","Mate","Bust a Rhyme","Categories","Never Have I Ever","Questions","Make a rule"
    ]
    let numbers = [
        "A","2","3","4","5","6","7","8","9","10","J","Q","K"
    ]
    let rules = [
    "Everyone drinks! The person picked the card can stop whenever he/she wants.",
    "\"You\" decide who to drink!",
    "\"You\" have to drink!",
    "It's women's time! All ladies drink.",
    "You start a dance move. The next person dance the same move and add another to it. Continue until someone screws up",
    "It's guys' time! All guys drink.",
    "Everyone reaches for the sky. Last person drink!",
    "Choose another player as your mate. If one of you drink you both need to drink.",
    "You pick a word and everyone has to say a word that rhymes with it. The one that cannot think of a word that rhymes drinks.",
    "Pick a category and everyone goes around has to say something fits it. One cannot think of one drinks.",
    "The player with all fingers loses has to drink.",
    "Ask anyone a question. Then this player asks another one a question. Continue until someone fails to ask a question. Drink!",
    "Now you can make a rule of drinking!"
    ]
    let card_collection = [
        #imageLiteral(resourceName: "club"),#imageLiteral(resourceName: "diamond"),#imageLiteral(resourceName: "heart"),#imageLiteral(resourceName: "spade")
    ]
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var warning: UILabel!
    @IBAction func pauseGame(_ sender: UIButton) {
        Alamofire.request(url+"/user/\(userID)/group/\(groupID)/pauseGame", method: .post, parameters: nil, encoding:URLEncoding.default, headers:nil).responseJSON{ response in switch response.result {
        case .success(let jsonData):
            print(jsonData)
        case .failure(let error):
            print(error)
            }
        }
    }
    
    @IBAction func resumeGame(_ sender: Any) {
        Alamofire.request(url+"/user/\(userID)/group/\(groupID)/resumeGame", method: .post, parameters: nil, encoding:URLEncoding.default, headers:nil).responseJSON{ response in switch response.result {
        case .success(let jsonData):
            print(jsonData)
        case .failure(let error):
            print(error)
            }
        }
    }
    @IBAction func exitGame(_ sender: UIButton) {
        Alamofire.request(url+"/user/\(userID)/group/\(groupID)/stopGame", method: .post, parameters: nil, encoding:URLEncoding.default, headers:nil).responseJSON{ response in switch response.result {
        case .success(let jsonData):
            print(jsonData)
        case .failure(let error):
            print(error)
            }
        }
        performSegue(withIdentifier: "exitGame", sender: self)
    }
    
    @IBAction func restartGame(_ sender: UIButton) {
        Alamofire.request(url+"/user/\(userID)/group/\(groupID)/startGame", method: .post, parameters: nil, encoding:URLEncoding.default, headers:nil).responseJSON{ response in switch response.result {
        case .success(let jsonData):
            print(jsonData)
        case .failure(let error):
            print(error)
            }
        }
    }
    @IBAction func next(_ sender: UIButton) {
        Alamofire.request(url+"/user/\(userID)/group/\(groupID)/drawCard", method: .post, parameters: nil, encoding:URLEncoding.default, headers:nil).responseJSON{ response in switch response.result {
        case .success(let jsonData):
            let json:[String:Any] = jsonData as! [String : Any]
            cardNumber = json["rank"] as! Int
            cardNumber = cardNumber - 1
            suitNumber = json["suit"] as! Int
            print(jsonData)
        case .failure(let error):
            print(error)
            }
        }
    }
    @IBAction func startGame(_ sender: Any) {
        if game_count == 0 {
            Alamofire.request(url+"/user/\(userID)/group/\(groupID)/startGame", method: .post, parameters: nil, encoding:URLEncoding.default, headers:nil).responseJSON{ response in switch response.result {
            case .success(let jsonData):
                print(jsonData)
            case .failure(let error):
                print(error)
                }
            }
        } else {
            startButton.isHidden = true
            startButton.isEnabled = false
            nextButton.isHidden = false
            nextButton.isEnabled = true
            Alamofire.request(url+"/user/\(userID)/group/\(groupID)/drawCard", method: .post, parameters: nil, encoding:URLEncoding.default, headers:nil).responseJSON{ response in switch response.result {
            case .success(let jsonData):
                let json:[String:Any] = jsonData as! [String : Any]
                cardNumber = json["rank"] as! Int
                cardNumber = cardNumber-1
                suitNumber = json["suit"] as! Int
                print(jsonData)
            case .failure(let error):
                print(error)
                }
            }
//            card.image = card_collection[suitNumber]
//            textLabel.font = textLabel.font.withSize(18)
//            textLabel.text = titles[cardNumber]
//            currentCard.text = numbers[cardNumber]
//            currentCardNumber.text = numbers[cardNumber]
//            ruleDetail.text = rules[cardNumber]
//            if suitNumber == 0 || suitNumber == 3 {
//                currentCardNumber.textColor = UIColor.black
//                currentCard.textColor = UIColor.black
//            } else {
//                currentCardNumber.textColor = UIColor.red
//                currentCard.textColor = UIColor.red
//            }
        }
        
    }
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
            if quantity2 > 3 {
                performSegue(withIdentifier: "doDrunkTest", sender: self)
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
    @IBAction func goStatus(_ sender: Any) {
        performSegue(withIdentifier: "viewStatus", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        minus1.tag = 0
        plus1.tag = 1
        minus2.tag = 2
        plus2.tag = 3
        minus3.tag = 4
        plus3.tag = 5
        profilePic.layer.cornerRadius = profilePic.frame.size.width/2
        profilePic.clipsToBounds = true
        profile1.layer.cornerRadius = profile1.frame.size.width/2
        profile1.clipsToBounds = true
        profile2.layer.cornerRadius = profile2.frame.size.width/2
        profile2.clipsToBounds = true
        profile3.layer.cornerRadius = profile3.frame.size.width/2
        profile3.clipsToBounds = true
        // Do any additional setup after loading the view.
        let swipeToStatus = UISwipeGestureRecognizer(target:self, action: #selector(swipeAction(swipe:)))
        swipeToStatus.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeToStatus)
        number1.text = String(quantity1)
        number2.text = String(quantity2)
        number3.text = String(quantity3)
        profilePic.image = profilePicture
        pauseButton.isHidden = true
        exitButton.isHidden = true
        restartButton.isHidden = true
        pauseButton.isEnabled = false
        exitButton.isEnabled = false
        restartButton.isEnabled = false
        resumeButton.isHidden = true
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
        nextButton.isHidden = true
        nextButton.isEnabled = false
        subscribe()
        
    }
    func subscribe(){
        Messaging.messaging().subscribe(toTopic: "/topics/\(groupID)")
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(withNotification:)), name: NSNotification.Name(rawValue:"notification_key"), object: nil)
    }
    @objc func handleNotification(withNotification notification : NSNotification) {
        if let result = notification.userInfo?["topic"] as? String {
            if result == "Pause" {
                card.image = #imageLiteral(resourceName: "Poker back")
                currentCard.isHidden = true
                currentCardNumber.isHidden = true
                textLabel.isHidden = true
                nextButton.isHidden = true
                nextButton.isEnabled = false
                resumeButton.isHidden = false
                let info = notification.userInfo?["message"] as? String ?? ""
                if info == "" {
                    ruleDetail.text = "The game is paused."
                } else {
                    ruleDetail.text = info
                }
            } else if result == "gameInitialize" {
                warning.text = ""
                startButton.setImage(#imageLiteral(resourceName: "pick button"), for: .normal)
                card.image = #imageLiteral(resourceName: "Poker back")
                pauseButton.isHidden = false
                exitButton.isHidden = false
                restartButton.isHidden = false
                pauseButton.isEnabled = true
                exitButton.isEnabled = true
                restartButton.isEnabled = true
                currentCardNumber.isHidden = true
                currentCard.isHidden = true
                startButton.isHidden = false
                startButton.isEnabled = true
                textLabel.isHidden = true
                nextButton.isHidden = true
                ruleDetail.isHidden = true
                game_count = game_count + 1
            } else if result == "drawCard" {
                warning.text = ""
                textLabel.isHidden = false
                currentCardNumber.isHidden = false
                currentCard.isHidden = false
                startButton.isHidden = true
                startButton.isEnabled = false
                nextButton.isHidden = false
                ruleDetail.isHidden = false
                currentCardNumber.isHidden = false
                currentCard.isHidden = false
                let s_tmp = notification.userInfo?["suit"] as? String ?? ""
                let r_tmp = notification.userInfo?["rank"] as? String ?? ""
                print(s_tmp)
                let s = Int(s_tmp)
                var r = Int(r_tmp)
                r = r!-1
                card.image = card_collection[s!]
                currentCard.text = numbers[r!]
                currentCardNumber.text = numbers[r!]
                textLabel.font = textLabel.font.withSize(18)
                textLabel.text = titles[r!]
                ruleDetail.text = rules[r!]
                if s == 0 || s == 3 {
                    currentCardNumber.textColor = UIColor.black
                    currentCard.textColor = UIColor.black
                } else {
                    currentCardNumber.textColor = UIColor.red
                    currentCard.textColor = UIColor.red
                }
            } else if result == "gameResume" {
                warning.text = ""
                ruleDetail.text = "Pick a card"
                nextButton.isHidden = false
                nextButton.isEnabled = true
                resumeButton.isHidden = true
            } else if result == "SoberTest" {
                warning.text = notification.userInfo?["message"] as? String ?? ""
            } else if result == "Drunk" {
                textLabel.isHidden = true
                startButton.isHidden = true
                resumeButton.isHidden = false
                warning.text = notification.userInfo?["message"] as? String ?? ""
            }
        }
    }


}
