//
//  ViewController.swift
//  ShoppingList
//
//  Created by Justin Bengtson on 8/14/19.
//  Copyright © 2019 Justin Bengtson. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToList))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(clearList))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "List", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        
        return cell
    }
    
    @objc func addToList() {
        let ac = UIAlertController(title: "Enter Shopping List Item", message: nil, preferredStyle: .alert)
        
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] action in
            guard let item = ac?.textFields?[0].text else  {return }
            self?.submit(item)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    func submit(_ answer: String) {
        
        shoppingList.insert(answer, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @objc func clearList() {
        shoppingList.removeAll()
        tableView.reloadData()
        
    }
    
    


}

