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
        
        text.text = ViewController().textDet
        //var x = ViewController().textDetected.text
        // Do any additional setup after loading the view.
    }
    
    var window: UIWindow?



    @IBAction func backAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let vc = MainInterface()


            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }
        
        
    }
    
    
    @IBOutlet var text: UITextField!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
