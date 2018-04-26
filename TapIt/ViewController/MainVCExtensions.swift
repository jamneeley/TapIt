//
//  MainVCViewExtensions.swift
//  TapIt
//
//  Created by James Neeley on 4/26/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

extension MainViewController {
    
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
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 25)
        scoreLabel.text = "Score: "
        setupScoreLabelConstraints()
    }
    
    func setupActionLabel() {
        view.addSubview(actionLabel)
        actionLabel.font = UIFont.boldSystemFont(ofSize: 50)
        actionLabel.textAlignment = .center
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
        
        NSLayoutConstraint(item: scoreLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: view.frame.width / 3).isActive = true
    }
    
    
    func setupActionLabelConstraints() {
        actionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: actionLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: view.frame.height / 2.5).isActive = true
        
        NSLayoutConstraint(item: actionLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: view.frame.width / 10).isActive = true
        
        NSLayoutConstraint(item: actionLabel, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: view.frame.height / -2.5).isActive = true
        
        NSLayoutConstraint(item: actionLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: view.frame.width / -10).isActive = true
    }
}
