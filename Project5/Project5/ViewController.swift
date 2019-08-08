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
        
        startGame()
    }
    
    func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        // reloads table cells
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        
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
        
    }


}

