//
//  AppDelegate.swift
//  Planificador IFF
//
//  Created by ivan on 04/05/2021.
//

import UIKit
import MLKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        self.setupView()
        return true
    }

    // MARK: - private methods
    
    private func setupView(){
        DispatchQueue.main.async {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let vc = MainInterface()


            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }

        
    }



}

