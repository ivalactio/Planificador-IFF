//
//  AlarmController.swift
//  Planificador IFF
//
//  Created by ivan on 14/05/2021.
//


import UIKit
import UserNotifications
import AVFoundation
import BackgroundTasks



class AlarmController: UIViewController, AVAudioPlayerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        backButton.layer.cornerRadius = 10
        registerButton.layer.cornerRadius = 10
        scheduleButton.layer.cornerRadius = 10
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(getter: registerButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(getter: scheduleButton))
        
        transition.startProgress = 0
        transition.endProgress = 1.0
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.duration = 0.2
    }
    // MARK: - Variables
    var window: UIWindow?
    let transition = CATransition()
    
    
    var secondsRemaining = 10
    
    var timer: Timer?
    var soundEnabled = true

    private var audioPlayer: AVAudioPlayer?
    var timer1 = Constantes.constants.minPrevios * 60
    

    
    
    // MARK: - Oulets
    @IBOutlet var registerButton: UIButton!

    @IBOutlet var scheduleButton: UIButton!
    
    @IBOutlet var backButton: UIButton!
    
    @IBOutlet var timerText: UITextField!
    
    @IBOutlet var stopSongButton: UIButton!
    
    // MARK: - Oulet Actions
    @IBAction func backAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let vc = MainInterface()

            self.window?.layer.add(self.transition, forKey: "transition")
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }
        
    }
    @IBAction func registerAction(_ sender: Any) {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { garanted, error in
            if garanted{
                print("yay")
            }
            else{
                print("D'oh")
            }
        })
    }
    
    
    
    
    @IBAction func scheduleAction(_ sender: Any) {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { garanted, error in
            if garanted{
                print("yay")
            }
            else{
                print("D'oh")
            }
        })
        
        alarma()
    }
    
    
    @IBAction func stopSongAction(_ sender: Any) {
        if soundEnabled {
            //soundEnabled = false
            //soundStateLabel.text = "Enable Sound"
        } else {
            //soundEnabled = true
            //soundStateLabel.text = "Disable Sound"
        }
        audioPlayer?.stop()
        timer1 = Constantes.constants.minPrevios * 60
        timer?.invalidate()
    }
    
    
    // MARK: - Functions
    

    func notification(){
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        
        
        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "loqueseaxd"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = .defaultCritical
        
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request)
    }

    func alarma() {

            
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.countdown), userInfo: nil, repeats: true)
        //RunLoop.current.add(self.timer!, forMode: .common)

        //self.timerText.text = String(self.timer1)
    }
    
    
    @objc func countdown(){
        
        if timer1 > 0 {
            timer1 -= 1
            var time = secondsToHoursMinutesSeconds(seconds: timer1)
            self.timerText.text = "Horas: \(time.0) Minutos: \(time.1) Segundos: \(time.2) Restantes..."
            //print("time left: " + String(timer1))
        }
        else{
            timer?.invalidate()
            playMusic()
        }
        
        if timer1 == 2 {
            notification()

        }
        //var time = Constantes.secondsToHoursMinutesSeconds(seconds: timer1)
        
//        var toPrint: String
//        toPrint = "Horas: \(time.0), Minutos: \(time.1) Segundos: \(time.2) Restantes..."

        
    }
    
    func playMusic() {
        let urlstring = "https://github.com/ivalactio/uploadsForPlanificadorIFF/blob/main/Banana%20Tree.mp3?raw=true"
        let url = URL(string: urlstring)
        let data = try! Data(contentsOf: url!)
        
        
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                self.audioPlayer = try AVAudioPlayer(data: data)
                self.audioPlayer?.prepareToPlay()
                self.audioPlayer?.volume = 1.0
                self.audioPlayer?.play()
            } catch let error{
                print(error)
            }
        }
    }
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    

}


