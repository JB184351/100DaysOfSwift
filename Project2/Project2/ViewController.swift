//
//  ViewController.swift
//  Project2
//
//  Created by Justin Bengtson on 7/30/19.
//  Copyright © 2019 Justin Bengtson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var scores = 0
    var correctAnswer = 0
    var numQuestionsAsked = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        // Border around flags for better visibility
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        // Added some border color around the flags for better visibility
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        
        countries.shuffle()
        
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        // Title in navigation bar
        title = countries[correctAnswer].uppercased() + " Score: \(scores)"
        
        // Challenge 1 Day 21
        numQuestionsAsked += 1
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            scores += 1
        }
        
        // Challenge 3 Day 21
        else {
            title = "Wrong! it's \(countries[correctAnswer].uppercased())"
            scores -= 1
        }
        
        // Challenge 2 Day 21
        if numQuestionsAsked == 10 {
            
            let finalalert = UIAlertController(title: title, message: "Your final score is \(scores) after ten questions", preferredStyle: .alert)
            finalalert.addAction(UIAlertAction(title: "Game over", style: .default, handler: askQuestion))
            present(finalalert, animated: true)
        }
        
        else {
            let ac = UIAlertController(title: title, message: "Your score is \(scores) and \(numQuestionsAsked) question(s) have been asked.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
        
    }
    
    // Challenge 3  Day 22
    @objc func shareTapped() {
        // Can Change image to the selectedImage to get the string of the picture
        let ac = UIAlertController(title: title, message: "Your current score is \(scores)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
    


}

