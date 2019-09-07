//
//  ViewController.swift
//  defaults
//
//  Created by Justin Bengtson on 9/6/19.
//  Copyright © 2019 Justin Bengtson. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var startWord: String = "Item"
    var userWords = ["end", "begin", "alternate", "Virgil", "Justin"]
    var combinedWords = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveStartWord(startWord: startWord)
        saveUsedWords(usedWords: userWords)
        loadStartWord()
        loadUsedWords()
        combineWords(startWord: startWord, usedWord: userWords, combinedWords: &combinedWords)
        saveCombinedWords(combinedWords: combinedWords)
        loadCombinedWords()
        tableView.reloadData()
    }
    
    func combineWords(startWord: String, usedWord: [String], combinedWords: inout [String]) {
        combinedWords.append(contentsOf: usedWord)
        combinedWords.append(startWord)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return combinedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = combinedWords[indexPath.row]
        
        return cell
    }
    
    func saveStartWord(startWord: String) {
        let defaults = UserDefaults.standard
        
        defaults.set(startWord, forKey: "startWord")
    }
    
    func loadStartWord() {
        startWord = UserDefaults.standard.string(forKey: "startWord") ?? ""
        print(startWord)
    }
    
    func saveUsedWords(usedWords: [String]) {
        let defaults = UserDefaults.standard
        
        defaults.set(usedWords, forKey: "userWords")
    }
    
    func saveCombinedWords(combinedWords: [String]) {
        let defaults = UserDefaults.standard
        
        defaults.set(combinedWords, forKey: "combinedWords")
    }
    
    func loadUsedWords() {
        userWords = UserDefaults.standard.array(forKey: "userWords") as? [String] ?? []
        print(userWords)
    }
    
    func loadCombinedWords() {
        combinedWords = UserDefaults.standard.array(forKey: "combinedWords") as? [String] ?? []
        print(combinedWords)
    }
    
    
    func combinedWords(startWord: String, usedWords: [String], combinedWords: inout [String]) {
        combinedWords.append(contentsOf: usedWords)
        combinedWords.append(startWord)
    }
    
    
    
    


}

