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
        newScheduleOutlet.layer.cornerRadius = 10
        config.layer.cornerRadius = 10
        alarmButton.layer.cornerRadius = 10
        
        transition.startProgress = 0
        transition.endProgress = 1.0
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromBottom
        transition.duration = 0.2

        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Variables
    
    let transition = CATransition()
    
    var window: UIWindow?
    
    // MARK: - Oulets
    
    @IBOutlet var newScheduleOutlet: UIButton!
    
    @IBOutlet var config: UIButton!
    
    @IBOutlet var alarmButton: UIButton!

    // MARK: - Outlet Button Methods

    @IBAction func newScheduleAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let vc = ViewController()
            self.window?.layer.add(self.transition, forKey: "transition")
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }
        
    }
    
    @IBAction func configAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let vc = ConfigScreen()
            
            //var e: UIViewController
            
            
            self.window?.layer.add(self.transition, forKey: "transition")
            
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }
        
    }
    
    @IBAction func alarmAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let vc = AlarmController()
            self.window?.layer.add(self.transition, forKey: "transition")
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
/*
public enum SwapRootVCAnimationType {
    case push
    case pop
    case present
    case dismiss
}

extension UIWindow {
    public func swapRootViewControllerWithAnimation(newViewController:UIViewController, animationType:SwapRootVCAnimationType, completion: (() -> ())? = nil)
    {
        guard let currentViewController = rootViewController else {
            return
        }

        let width = currentViewController.view.frame.size.width;
        let height = currentViewController.view.frame.size.height;

        var newVCStartAnimationFrame: CGRect?
        var currentVCEndAnimationFrame:CGRect?

        var newVCAnimated = true

        switch animationType
        {
        case .push:
            newVCStartAnimationFrame = CGRect(x: width, y: 0, width: width, height: height)
            currentVCEndAnimationFrame = CGRect(x: 0 - width/4, y: 0, width: width, height: height)
        case .pop:
            currentVCEndAnimationFrame = CGRect(x: width, y: 0, width: width, height: height)
            newVCStartAnimationFrame = CGRect(x: 0 - width/4, y: 0, width: width, height: height)
            newVCAnimated = false
        case .present:
            newVCStartAnimationFrame = CGRect(x: 0, y: height, width: width, height: height)
        case .dismiss:
            currentVCEndAnimationFrame = CGRect(x: 0, y: height, width: width, height: height)
            newVCAnimated = false
        }

        newViewController.view.frame = newVCStartAnimationFrame ?? CGRect(x: 0, y: 0, width: width, height: height)

        addSubview(newViewController.view)

        if !newVCAnimated {
            bringSubviewToFront(currentViewController.view)
        }

        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
            if let currentVCEndAnimationFrame = currentVCEndAnimationFrame {
                currentViewController.view.frame = currentVCEndAnimationFrame
            }

            newViewController.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
        }, completion: { finish in
            self.rootViewController = newViewController
            completion?()
        })

        makeKeyAndVisible()
    }
}*/
