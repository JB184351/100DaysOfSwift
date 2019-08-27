//
//  ViewController.swift
//  Hangman
//
//  Created by Justin Bengtson on 8/24/19.
//  Copyright © 2019 Justin Bengtson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var allWords = [String]()
    var usedLetters = [Character]()
    var currentWord = [Character]()
    var usersWord = [String]()
    var word = String()
    var letters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    var newWord = String()
    
    var numWrongAnswer = 0 {
        didSet {
            title = String(numWrongAnswer)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        
        if let startWordsURL = Bundle.main.url(forResource: "hangmanwords", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["smashbro"]
        }
        
        startGame()
        
    }
    
    @objc func startGame() {
        title = String(numWrongAnswer)
        newWord = allWords.randomElement()!
        usedLetters.removeAll()
        usersWord.removeAll()
        
        print(usedLetters)
        currentWord = Array(newWord)
        
        print(currentWord)
        
        for _ in 0..<newWord.count {
            usersWord.append("?")
        }
        
        numWrongAnswer = 0
        
    }
    
    func isLetterGuess(_ answer: String) -> Bool {
        if answer.count == 1{
            return true
        }
        
        else {
            return false
        }
    }
    
    func isLetterInWord(_ answer: String) -> Bool {
        let userAnswer = answer.lowercased()
        
        if isLetterGuess(userAnswer) && newWord.contains(userAnswer) {
            return true
        }
        
        else {
            return false
        }
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter Letter to Guess", message: nil, preferredStyle: .alert)
        
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submitAnswer(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submitAnswer(_ answer: String) {
        
        let userAnswer = answer.lowercased()
        //var lettersLeft = String()
        
        
        if isLetterGuess(answer) {
            var usedletters = String()
            
            if letters.contains(userAnswer) {
                let userAnswerr = Character(userAnswer)
                usedLetters.append(userAnswerr)
                
                /*
                for i in 0...letters.count {
                    if userAnswer == letters[i] {
                        letters.remove(at: i)
                    }
                    
                    else {
                        lettersLeft += letters[i]
                    }
                }
                */
                
                for _ in 0..<usedLetters.count {
                    usedletters += usedLetters
                }
                
                if isLetterInWord(userAnswer) {
                    
                    if !youWon(answer: userAnswer) {
                        let ac = UIAlertController(title: "That letter is in the word! Here is what is availiable left", message: nil, preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        present(ac, animated: true)
                    }
                    
                    for i in 0..<newWord.count {
                        let letterinWord = currentWord[i]
                        
                        let useranswer = Character(userAnswer)
                        
                        let letterInWord = String(letterinWord)
                        
                        
                        if letterinWord == useranswer {
                            usersWord[i] = letterInWord
                        }
                                            
                    }
                    
                    for i in 0..<usersWord.count {
                        word += usersWord[i]
                        print(word)
                    }
                    
                    
                    if youWon(answer: word) {
                        let ac = UIAlertController(title: "Congratulations you won!", message: "Pressed the refresh button for a new game", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        present(ac, animated: true)
                    }
                }
                
                else {
                    let ac = UIAlertController(title: "Letter Does not exist in word! These are the letters you have used so far", message: usedletters, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    present(ac, animated: true)
                    numWrongAnswer += 1
                    
                    if numWrongAnswer == 7 {
                        manIsHanged()
                    }
                }
            }
            
            else {
                let ac = UIAlertController(title: "You have entered a number or invalid character!", message: nil, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
            }
            
            
            
        }
        
        else {
            let ac = UIAlertController(title: "You entered a word instead of a letter", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    func manIsHanged() {
        if numWrongAnswer == 7 {
            let ac = UIAlertController(title: "You have lost! Click the refresh button to start a new game", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    func youWon(answer: String) -> Bool {
        if answer == newWord {
            return true
        }
        
        else {
            return false
        }
    }


}

