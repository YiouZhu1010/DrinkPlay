//
//  profilePage.swift
//  DrinkPlay
//
//  Created by EO on 2018/4/10.
//  Copyright © 2018 EO. All rights reserved.
//

import UIKit

class profilePage: UIViewController {
    
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var codeText: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePic.layer.cornerRadius = profilePic.frame.size.width/2
        profilePic.clipsToBounds = true
        profilePic.image = profilePicture
        codeText.text = partyCode
        nameText.text = userName
    }

    @IBAction func logoutButton(_ sender: Any) {
        loginManager.logOut()
        performSegue(withIdentifier: "logOut", sender: self)
    }
}
