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
    print("Was tapped")
    }
    
    @objc func wasSwipped() {
        print("Was swipped")
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        print("started Shaking")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        startGameAlert()
    }
}
///////////////////////////////////////////////////
    //MARK: - Setup Objects
///////////////////////////////////////////////////

extension MainViewController {
    
    func setupObjects() {
        setupImage()
        setupBlurEffect()
        setupHighScoreButton()
        setupScoreLabel()
        setupActionLabel()
    }

    func setupImage() {
        let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        backgroundImageView.image = UIImage(named: "backGroundImage")
        backgroundImageView.contentMode = UIViewContentMode.scaleAspectFill
        view.insertSubview(backgroundImageView, at: 0)
    }
    
    func setupBlurEffect() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffextView = UIVisualEffectView(effect: blurEffect)
        blurEffextView.frame = view.bounds
        blurEffextView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffextView)
    }

    func setupHighScoreButton() {
        view.addSubview(highScoresButton)
        highScoresButton.setImage(#imageLiteral(resourceName: "trophyButton.png"), for: .normal)
        highScoresButton.addTarget(self, action: #selector(highScoreButtonTapped), for: .touchUpInside)
        setupHighScoreButtonConstraints()
    }
    
    func setupScoreLabel() {
        view.addSubview(scoreLabel)
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 30)
        scoreLabel.text = "Score: "
        setupScoreLabelConstraints()
    }

    func setupActionLabel() {
        view.addSubview(actionLabel)
        actionLabel.font = UIFont.boldSystemFont(ofSize: 50)
        actionLabel.textAlignment = .center
        setupActionLabelConstraints()
    }
}


    ///////////////////////////////////////////////////
    //MARK: - Setup Constraints
    ///////////////////////////////////////////////////

extension MainViewController {
    
    func setupHighScoreButtonConstraints() {
        highScoresButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: highScoresButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 20).isActive = true
        
        NSLayoutConstraint(item: highScoresButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint(item: highScoresButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant:  view.frame.height / 10).isActive = true
        
        NSLayoutConstraint(item: highScoresButton, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: view.frame.width / -8).isActive = true
        
    }
    
    func setupScoreLabelConstraints() {
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: scoreLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 20).isActive = true
        
        NSLayoutConstraint(item: scoreLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint(item: scoreLabel, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: view.frame.height / 10).isActive = true
        
        NSLayoutConstraint(item: scoreLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: view.frame.width / 4).isActive = true
    }

    
    func setupActionLabelConstraints() {
        actionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: actionLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: view.frame.height / 2.5).isActive = true
        
        NSLayoutConstraint(item: actionLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: view.frame.width / 10).isActive = true
        
        NSLayoutConstraint(item: actionLabel, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: view.frame.height / -2.5).isActive = true
        
        NSLayoutConstraint(item: actionLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: view.frame.width / -10).isActive = true
    }
}


    ///////////////////////////////////////////////////
    //MARK: - local functions
    ///////////////////////////////////////////////////

extension MainViewController {
    
    @objc func highScoreButtonTapped() {
        let navigationController =  UINavigationController(rootViewController: ScoresTableViewController())
        self.present(navigationController, animated: true, completion: nil)
        
        stopTimer()
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
                self.startTimer()
        }
        alert.addAction(notYet)
        alert.addAction(start)
        self.present(alert, animated: true)
        
    }
    
    func startNewGame() {
        startTimer()
    }
    
    
    func startTimer() {
         globalTimer = Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(randomAction), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        globalTimer?.invalidate()
        globalTimer = nil
    }
    
    
    //this is where we need to call the observer for wether tap shake or swipe happened
    @objc func randomAction() {
        let randomNumber = Int(arc4random_uniform(3) + 1)
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
