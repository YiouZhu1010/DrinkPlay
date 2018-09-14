//
//  SoberResult.swift
//  DrinkPlay
//
//  Created by EO on 05/04/2018.
//  Copyright © 2018 EO. All rights reserved.
//

import UIKit

class SoberResult: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = userName
        profilePic.image = profilePicture
        profilePic.layer.cornerRadius = profilePic.frame.size.width/2
        profilePic.clipsToBounds = true
        
    }


}
