//
//  customSegue.swift
//  DrinkPlay
//
//  Created by EO on 03/04/2018.
//  Copyright © 2018 EO. All rights reserved.
//

import UIKit

class customSegue: UIStoryboardSegue {
    override func perform() {
        fromLeftToRight()
    }
    func fromLeftToRight(){
        let toViewController = self.destination
        let fromViewController = self.source


//        toViewController.view.transform = CGAffineTransform(scaleX: 0.05, y:0.05)
//        toViewController.view.center = originalCenter
        
//        UIView.animate(withDuration:0.5, delay:0,options:.curveEaseInOut, animations: {
//            toViewController.view.transform = CGAffineTransform.identity
//        },completion: {success in
//            fromViewController.present(toViewController,animated: false,completion: nil)
//        })
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        fromViewController.view.window?.layer.add(transition, forKey: kCATransition)
        fromViewController.present(toViewController, animated: false, completion: nil)
    }
}
