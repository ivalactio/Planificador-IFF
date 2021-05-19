//
//  ConfigScreen.swift
//  Planificador IFF
//
//  Created by ivan on 11/05/2021.
//

import UIKit

class ConfigScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.layer.cornerRadius = 10
        sendButton.layer.cornerRadius = 10
        modifyButton.layer.cornerRadius = 10
        minutesButton.layer.cornerRadius = 10
        sendMinutesButton.layer.cornerRadius = 10
        
        text.text = ViewController.viewGlobal.firstDay
        
        
        transition.startProgress = 0
        transition.endProgress = 1.0
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.duration = 0.2
        //text.text = "gol"
    }
    
    let transition = CATransition()
    
    struct configGlobal {
        static var previewMinutes = "minutos Previos"
    }
    
    var window: UIWindow?

    @IBOutlet var backButton: UIButton!
    

    @IBAction func backAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let vc = MainInterface()

            self.window?.layer.add(self.transition, forKey: "transition")
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }
        
        
    }
    @IBAction func sendAction(_ sender: Any) {
        if text.text! >= "1" && text.text! <= "31" {
            ViewController.viewGlobal.firstDay = text.text!
            sendButton.isHidden = true
            text.isHidden = true
            modifyButton.isHidden = false
        }
        else{
            text.text = "¡Valores incorrectos!"
        }
    }
    @IBAction func endEdit(_ sender: Any) {
        self.resignFirstResponder()
    }
    
    @IBAction func modifyAction(_ sender: Any) {
        sendButton.isHidden = false
        modifyButton.isHidden = true
        text.isHidden = false
    }
    
    @IBAction func sendMinutesAction(_ sender: Any) {
        var minutes = Int(minutesText.text!)
        if minutes! >= 1 && minutes! <= 180 {
            ViewController.viewGlobal.firstDay = text.text!
            sendMinutesButton.isHidden = true
            minutesText.isHidden = true
            minutesButton.isHidden = false
            configGlobal.previewMinutes = minutesText.text!
            let x = Int(minutesText.text!)
            Constantes.constants.minPrevios = x!
        }
        else{
            text.text = "¡Valores incorrectos!"
        }
    }
    
    @IBAction func minutesAction(_ sender: Any) {
        sendMinutesButton.isHidden = false
        minutesText.isHidden = false
        minutesButton.isHidden = true
    }
    @IBAction func endEdit2(_ sender: Any) {
        self.resignFirstResponder()
    }
    
    @IBOutlet var minutesText: UITextField!
    
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var modifyButton: UIButton!
    
    @IBOutlet var text: UITextField!
    @IBOutlet var sendMinutesButton: UIButton!
    
    @IBOutlet var minutesButton: UIButton!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
