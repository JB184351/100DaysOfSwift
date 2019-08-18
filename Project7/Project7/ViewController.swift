//
//  ViewController.swift
//  Project7
//
//  Created by Justin Bengtson on 8/15/19.
//  Copyright © 2019 Justin Bengtson. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    
    var filterKeyword: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString: String
        
        // Challenge 1
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredit))
        
        // Challenge 2
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchPetitions))
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        }
        else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                // We're good to parse
                parse(json: data)
                return
            }
        }
        
        showError()
    }
    
    // Challenge 1
    @objc func showCredit() {
        let ac = UIAlertController(title: "Credits", message: "The data comes from the We The People API of the Whitehouse.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func searchPetitions() {
        let ac = UIAlertController(title: "Filter Petitions", message: nil, preferredStyle: .alert)
        
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title:"Search", style: .default) {
            [weak self, weak ac] _ in
            self?.filterKeyword = ac?.textFields?[0].text ?? ""
            self?.filterPetitions()
            self?.tableView.reloadData()
        })
        
        present(ac, animated: true)
        
        
    }
    
    func filterPetitions() {
        
        if filterKeyword.isEmpty {
            filteredPetitions = petitions
            navigationItem.leftBarButtonItem?.title = "Filter"
            return
        }
        
        navigationItem.leftBarButtonItem?.title = "Filter (current: \(filterKeyword))"
        
        // keep only petition whose title or body contains keyword
         filteredPetitions = petitions.filter() { petition in
         // use range instead of contains to filter in case insentive manner
         // (see https://www.hackingwithswift.com/example-code/strings/how-to-run-a-case-insensitive-search-for-one-string-inside-another)
         if let _ = petition.title.range(of: filterKeyword, options: .caseInsensitive) {
         return true
         }
         if let _ =  petition.body.range(of: filterKeyword, options: .caseInsensitive) {
         return true
         }
         return false
         }
 
        
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading Error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filterPetitions()
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

