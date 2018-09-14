//
//  AboutYou.swift
//  DrinkPlay
//
//  Created by EO on 03/04/2018.
//  Copyright © 2018 EO. All rights reserved.
//

import UIKit
import Alamofire

class AboutYou: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return gender.count
        } else if pickerView.tag == 1 {
            return weightUnit.count
        } else {
            return drinkFreq.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            if row == 1 {
                gender_index = true
            } else {
                gender_index = false
            }
            return gender[row]
        } else if pickerView.tag == 1 {
            return weightUnit[row]
        } else {
            frequency_index = row
            return drinkFreq[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            genderText.text = gender[row]
        } else if pickerView.tag == 1 {
            weightUnitText.text = weightUnit[row]
        } else {
            drinkFreqText.text = drinkFreq[row]
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted
        
        let components = string.components(separatedBy: inverseSet)
        
        let filtered = components.joined(separator: "")
        
        if filtered == string {
            return true
        } else {
            if string == "." {
                let countdots = textField.text!.components(separatedBy:".").count - 1
                if countdots == 0 {
                    return true
                }else{
                    if countdots > 0 && string == "." {
                        return false
                    } else {
                        return true
                    }
                }
            }else{
                return false
            }
        }
    }
    @objc func done(){
        self.view.endEditing(true)
    }
    
    let gender = ["Female","Male"]
    let weightUnit = ["lbs","kg"]
    let drinkFreq = ["Cheap Drink","Social Drinker","Frequent Drinker","Heavy Drinker","Frat Boy"]
    var genderPicker = UIPickerView()
    var weightUnitPicker = UIPickerView()
    var drinkFreqPicker = UIPickerView()
    var gender_index = false
    var frequency_index = 0
    @IBOutlet weak var weight: UITextField!
    
    @IBOutlet weak var genderText: UITextField!
    
    @IBOutlet weak var drinkFreqText: UITextField!
    @IBOutlet weak var weightUnitText: UITextField!
    @IBOutlet weak var warningText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        genderPicker.tag = 0
        weightUnitPicker.tag = 1
        drinkFreqPicker.tag = 2
        genderPicker.delegate = self
        genderPicker.dataSource = self
        weightUnitPicker.delegate = self
        weightUnitPicker.dataSource = self
        drinkFreqPicker.delegate = self
        drinkFreqPicker.dataSource = self
        genderText.inputView = genderPicker
        genderText.textAlignment = .left
        genderText.text = "Female"
        weightUnitText.inputView = weightUnitPicker
        weightUnitText.textAlignment = .left
        weightUnitText.text = "lbs"
        drinkFreqText.inputView = drinkFreqPicker
        drinkFreqText.textAlignment = .left
        drinkFreqText.text = "Cheap Drink"
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem:.done,target:nil,action:#selector(done))
        toolbar.setItems([doneButton],animated:false)
        genderText.inputAccessoryView = toolbar
        weightUnitText.inputAccessoryView = toolbar
        drinkFreqText.inputAccessoryView = toolbar
        weight.delegate = self
    }
    
    
    // submit the information and start the main procedure
    @IBAction func nextStep(_ sender: Any) {
        if weight.text != "" {
            let parameter = [
                "gender": gender_index,
                "weight": weight.text ?? "100",
                "frequency": frequency_index,
                "metabolismRate": 0.0
                ] as [String : Any]
            Alamofire.request(url+"/user/\(userID)/profile", method: .put, parameters: parameter, encoding:URLEncoding.default, headers:nil).responseJSON{ response in switch response.result {
            case .success(let jsonData):
                print(jsonData)
                self.performSegue(withIdentifier: "goToMainPage", sender: self)
            case .failure(let error):
                print(error)
                }
            }
            
        } else {
            warningText.text = "Please complete all fields."
        }
    }
    
}
