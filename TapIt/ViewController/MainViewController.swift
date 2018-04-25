//
//  MainViewController.swift
//  TapIt
//
//  Created by James Neeley on 4/25/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let highScoresButton = UIButton()
    let scoreLabel = UILabel()
    let actionLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setupObjects()
    }
    
    func setupObjects() {
        setupHighScoreButton()
        setupScoreLabel()
        setupActionLabel()
    }
    
    
    func setupHighScoreButton() {
        view.addSubview(highScoresButton)
        highScoresButton.backgroundColor = .yellow
        setupHighScoreButtonConstraints()
    }
    
    func setupScoreLabel() {
        view.addSubview(scoreLabel)
        scoreLabel.backgroundColor = .blue
        setupScoreLabelConstraints()
        
    }

    
    func setupActionLabel() {
        view.addSubview(actionLabel)
        actionLabel.backgroundColor = .red
        setupActionLabelConstraints()
    }
    
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
