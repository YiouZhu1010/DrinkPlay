//
//  GetPartyCode.swift
//  DrinkPlay
//
//  Created by EO on 06/04/2018.
//  Copyright © 2018 EO. All rights reserved.
//

import UIKit
import Alamofire
class GetPartyCode: UIViewController {

    @IBOutlet weak var code: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var username: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        code.text = partyCode
        profilePic.image = profilePicture
        username.text = userName
        profilePic.layer.cornerRadius = profilePic.frame.size.width/2
        profilePic.clipsToBounds = true
    }

    @IBAction func joinParty(_ sender: Any) {
        performSegue(withIdentifier: "joinMyParty", sender: self)
    }
}
