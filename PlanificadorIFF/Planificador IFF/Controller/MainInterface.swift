//
//  MainInterface.swift
//  Planificador IFF
//
//  Created by ivan on 11/05/2021.
//

import UIKit

class MainInterface: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Variables
    
    var window: UIWindow?
    
    // MARK: - Oulets
    
    @IBOutlet var newScheduleOutlet: UIButton!
    
    @IBOutlet var config: UIButton!
    
    // MARK: - Outlet Button Methods
    
    @IBAction func newScheduleAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let vc = ViewController()


            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }
        
    }
    
    @IBAction func configAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let vc = ConfigScreen()


            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
