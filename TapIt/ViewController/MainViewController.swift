//
//  MainViewController.swift
//  TapIt
//
//  Created by James Neeley on 4/25/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let imageViewOpacity = UIView()
    let highScoresButton = UIButton()
    let scoreLabel = UILabel()
    let actionLabel = UILabel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setupObjects()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        startGameAlert()
    }
    
///////////////////////////////////////////////////
    //MARK: - Setup Objects
///////////////////////////////////////////////////
    
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
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 35)
        scoreLabel.text = "Score: "
        setupScoreLabelConstraints()
    }

    
    func setupActionLabel() {
        view.addSubview(actionLabel)
        actionLabel.font = UIFont.boldSystemFont(ofSize: 50)
        actionLabel.backgroundColor = .random()
        actionLabel.textAlignment = .center
        actionLabel.text = "Tap It!"
        setupActionLabelConstraints()
    }
    
    ///////////////////////////////////////////////////
    //MARK: - Setup Constraints
    ///////////////////////////////////////////////////
    
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
    
    ///////////////////////////////////////////////////
    //MARK: - local functions
    ///////////////////////////////////////////////////
    
    @objc func highScoreButtonTapped() {
        
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
        let _ = Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(randomAction), userInfo: nil, repeats: true)
        //what to do when the timer ticks??
    }
    
    @objc func randomAction() {
        let randomNumber = Int(arc4random_uniform(3) + 1)
        if randomNumber == 1 {
            actionLabel.text = "Tap It!"
        } else if randomNumber == 2 {
            actionLabel.text = "Swipe It!"
        } else {
            actionLabel.text = "Shake It!"
        }
        print("\(randomNumber)")
    }
}


extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}
