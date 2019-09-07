//
//  ViewController.swift
//  Project5
//
//  Created by Justin Bengtson on 8/8/19.
//  Copyright © 2019 Justin Bengtson. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()
    var startWord: String = ""
    var combinedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        if let startWordsURL = Bundle.main.url(forResource: "anagram", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        // Challenge 3
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        startGame()
       
    }
    
    @objc func startGame() {
        let startingWord = allWords.randomElement()
        title = startingWord!
        startWord = startingWord!
        print(startWord)
        usedWords.removeAll(keepingCapacity: true)
        loadStartWords()
        loadUsedWords()
        combineWords(startWord: startWord, usedWords: usedWords, combinedWords: &combinedWords)
        saveCombinedWorads(combinedWords: combinedWords)
        loadCombinedWords()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return combinedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = combinedWords[indexPath.row]
        
        return cell
    }
    
    // Called by right bar button item
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        // User types into textfield
        ac.addTextField()
        
        // Trailing closuare syntax
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                   // usedWords.insert(startWord, at: 1)
                    usedWords.insert(answer, at: 0)
                    //saveStartWords(startWord: lowerAnswer)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    // with arguement is for the type of animation is going to be performed
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    saveUsedWords(usedWords: usedWords)

                    return
                }
                    
                    // Challenge 2
                else {
                    showErrorMessage(errorMessage: "You can't just make them up, you know!", errorTitle: "Word not recongized")
                }
            }
            else {
                showErrorMessage(errorMessage: "Be more original", errorTitle: "Word already used")
            }
        }
        else {
            showErrorMessage(errorMessage: "You can't spell that word from \(title!.lowercased())", errorTitle: "Word not possible")
        }
        
        combineWords(startWord: startWord, usedWords: usedWords, combinedWords: &combinedWords)
        saveCombinedWorads(combinedWords: combinedWords)
        
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
         if word == tempWord {
            return false
         }
 
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            }
            else {
                return false
            }
        }
        
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        
        // Challenge 1
        if word.count < 3 {
            return false
        }
        
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
        
    }
    
    // Challenge 2
    func showErrorMessage(errorMessage: String, errorTitle: String) {
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func saveUsedWords(usedWords: [String]) {
        let defaults = UserDefaults.standard
        print(usedWords)
        defaults.set(usedWords, forKey: "usedWords")
    }
    
    func saveStartWords(startWord: String) {
        let defaults = UserDefaults.standard
        
        defaults.set(startWord, forKey: "startWord")     
    }
    
    func loadStartWords() {
         startWord = UserDefaults.standard.string(forKey: "startWord") ?? ""
         //print(startWord)
    }
    
    func loadUsedWords() {
        usedWords = UserDefaults.standard.array(forKey: "usedWords") as? [String] ?? []
       // print(usedWords)
    }
    
    func saveCombinedWorads(combinedWords: [String]) {
        let defaults = UserDefaults.standard
        
        defaults.set(combinedWords, forKey: "combinedWords")
    }
    
    func loadCombinedWords() {
        combinedWords = UserDefaults.standard.array(forKey: "combinedWorads") as? [String] ?? []
    }
    
    func combineWords(startWord: String, usedWords: [String], combinedWords: inout [String]) {
        combinedWords.append(contentsOf: usedWords)
        print(startWord)
        combinedWords.append(startWord)
        print(combinedWords)
    }
    
    
}

