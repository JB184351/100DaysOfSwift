//
//  ViewController.swift
//  Day 23
//
//  Created by Justin Bengtson on 8/3/19.
//  Copyright © 2019 Justin Bengtson. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    var numpics = 0
    var currentpicnum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        title = "Flags"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        
        let path = Bundle.main.resourcePath!
        
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("flag_") {
                pictures.append(item)
                numpics = pictures.count
            }
        }
        
         print(pictures)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // DequeueReuseableCell puts the cell not on the screen in an queue to use when needed
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            currentpicnum = indexPath.row
            vc.selectedImage = pictures[indexPath.row]
          //  title = " \(currentpicnum + 1) out of \(numpics)"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    

}

