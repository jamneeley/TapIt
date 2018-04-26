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
    var score = 0
    var name = ""
    var success = false
    
    
    
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
    
    
    // USER ACTIONS /////////////////////////////
    
    
    @objc func wasTapped() {
        guard let randomNumber = randomNumber else { return }
        if success == false {
            if randomNumber == 1 {
                print("User tapped correctly and in the correct amount of time")
                success = true
                score += 1
                print(score)
                scoreLabel.text = "Score: \(score)"
            } else {
                userLost()
                print("user didnt do the correct actions")
            }
        }
    }
    
    @objc func wasSwipped() {
        if success  ==  false {
            if randomNumber == 2 {
                print("User swipped correctly and in the correct amount of time")
                success = true
                score += 1
                scoreLabel.text = "Score: \(score)"
            } else {
                userLost()
                print("user didnt do the correct actions")
            }
        }
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if success == false{
            if randomNumber == 3 {
                print("User shaked correctly and in the correct amount of time")
                success = true
                score += 1
                scoreLabel.text = "Score: \(score)"
            } else {
                userLost()
                print("user didnt do the correct actions")
            }
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
        score = 0
        actionLabel.text = ""
        actionLabel.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.0)
    }
    
    func startGameAlert() {
        scoreLabel.text = "Score: \(score)"
        let alert = UIAlertController(title: "Are You Ready To Start?", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        let notYet = UIAlertAction(title: "Not Yet", style: .cancel, handler: nil)
        let start = UIAlertAction(title: "Start!", style: .default) { (_) in
            guard let name = alert.textFields?.first?.text, !name.isEmpty else {return}
            self.name = name
            self.startNewSession()
        }
        alert.addAction(notYet)
        alert.addAction(start)
        self.present(alert, animated: true)
    }
    
    func startNewSession() {
        randomAction()
        startTimer()
        success = false
    }
    
    
    func startTimer() {
        globalTimer = Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(newSession), userInfo: nil, repeats: false)
    }

    
    func userLost() {
        success = false
        let alert = UIAlertController(title: "You Died!", message: nil, preferredStyle: .alert)
        let goToScores = UIAlertAction(title: "See Scores", style: .default) { (segueToTB) in
            UserController.shared.addUser(username: self.name, score: Int16(self.score))
            self.score = 0
            self.highScoreButtonTapped()
        }
        let playAgain = UIAlertAction(title: "Git Gud!", style: .default) { (segue) in
            UserController.shared.addUser(username: self.name, score: Int16(self.score))
            self.score = 0
            self.startGameAlert()
        }
        alert.addAction(goToScores)
        alert.addAction(playAgain)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func newSession() {
        print("timer fired")
        if success == false {
            userLost()
        } else {
            startNewSession()
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

extension CGFloat {
    static func random(Int int: Int) -> Int {
        return Int(arc4random_uniform(UInt32(int)))
    }
}
