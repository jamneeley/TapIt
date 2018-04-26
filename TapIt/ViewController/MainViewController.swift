//
//  MainViewController.swift
//  TapIt
//
//  Created by James Neeley on 4/25/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIGestureRecognizerDelegate {
    
    let imageViewOpacity = UIView()
    let highScoresButton = UIButton()
    let scoreLabel = UILabel()
    let actionLabel = UILabel()
    var globalTimer: Timer? = nil
    var randomNumber: Int?
    var countDown = 12
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObjects()
        let tap = UITapGestureRecognizer(target: self, action: #selector(wasTapped))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(wasSwipped))
        swipe.delegate = self
        view.addGestureRecognizer(swipe)
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    @objc func wasTapped() {
        guard let randomNumber = randomNumber else { return }
        if randomNumber == 1 {
            print("User tapped correctly")
            startTimer()
            randomAction()
        } else {
            stopGame()
            print("user didnt do the correct actions")
        }
    }
    
    @objc func wasSwipped() {
        if randomNumber == 2 {
            print("User Swipped")
            startTimer()
            randomAction()
        } else {
            stopGame()
            print("user didnt do the correct actions")
        }
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if randomNumber == 3 {
            print("User Shaked it")
            startTimer()
            randomAction()
        } else {
            stopGame()
            print("user didnt do the correct actions")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        startGameAlert()
    }
}


    ///////////////////////////////////////////////////
    //MARK: - local functions
    ///////////////////////////////////////////////////

extension MainViewController {
    
    @objc func highScoreButtonTapped() {
        let navigationController =  UINavigationController(rootViewController: ScoresTableViewController())
        self.present(navigationController, animated: true, completion: nil)
        
        stopGame()
        actionLabel.text = ""
        actionLabel.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.0)
        
    }
    
    func startGameAlert() {
        
        let alert = UIAlertController(title: "Are You Ready To Start?", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        let notYet = UIAlertAction(title: "Not Yet", style: .cancel, handler: nil)
        let start = UIAlertAction(title: "Lets do it!", style: .default) { (nil) in
                guard let name = alert.textFields?.first?.text else {return}
                //Have the model create a new user, dismiss the view and start the timer
                print(name)
                self.startNewGame()
        }
        alert.addAction(notYet)
        alert.addAction(start)
        self.present(alert, animated: true)
        
    }
    
    func startNewGame() {
        randomAction()
        countDown = 12
        startTimer()
    }
    
    
    func startTimer() {
        globalTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(counting), userInfo: nil, repeats: true)
    }
    
    func stopGame() {
        globalTimer?.invalidate()
        globalTimer = nil
        countDown = 12
    }
    
    @objc func counting() {
        print(countDown)
        if countDown > 0 {
            countDown -= 1
        } else if countDown == 0 {
            stopGame()
        }
    }
    
    @objc func randomAction() {
        let randomNumber = Int(arc4random_uniform(3) + 1)
        self.randomNumber = randomNumber
        if randomNumber == 1 {
            actionLabel.text = "Tap It!"
        } else if randomNumber == 2 {
            actionLabel.text = "Swipe It!"
        } else  if randomNumber == 3 {
            actionLabel.text = "Shake It!"
        }
        transformActionLabelScale()
        changeActionLabelColor()
    }
    
    func transformActionLabelScale() {
        let animationX = CABasicAnimation(keyPath: "transform.scale.x")
        animationX.duration = 0.1
        animationX.repeatCount = 1
        animationX.fromValue = 1
        animationX.toValue = 1.1
        let animationY = CABasicAnimation(keyPath: "transform.scale.y")
        animationY.duration = 0.1
        animationY.repeatCount = 1
        animationY.fromValue = 1
        animationY.toValue = 1.1
        actionLabel.layer.add(animationX, forKey: "Xtransform")
        actionLabel.layer.add(animationY, forKey: "YTransform")
    }
    
    
    func changeActionLabelColor() {
        let randomNumber = CGFloat.random(Int: Colors.colorArray.count)
        UIView.animate(withDuration: 1.0, animations: {
            self.actionLabel.backgroundColor = Colors.colorArray[randomNumber]
        })
    }
}

//made a change again

extension CGFloat {
    static func random(Int int: Int) -> Int {
        return Int(arc4random_uniform(UInt32(int)))
    }
}
