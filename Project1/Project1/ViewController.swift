//
//  ViewController.swift
//  Project1
//
//  Created by Justin Bengtson on 6/13/19.
//  Copyright © 2019 Justin Bengtson. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fm = FileManager.default
        // Bundle is file containing compiled code
        let path = Bundle.main.resourcePath!
        
        // Trying to read the pictures of the path
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                // This is a picture to load
                pictures.append(item)
            }
        }
    }
    
    // Changing behavior from parent class and returning the number of rows that is in our array of pictures
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    // Getting all the cells needed for our app
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // DequeueReuseableCell puts the cell not on the screen in an queue to use when needed
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
}

