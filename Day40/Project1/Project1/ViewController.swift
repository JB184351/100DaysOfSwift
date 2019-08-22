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
    var numpics = 0
    var currentpicnum = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        // Enables large titles across the app
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Trying to read the pictures of the path
        performSelector(inBackground: #selector(loadImages), with: nil)
        
        // Challenge 2
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
    }
    
    @objc func loadImages() {
        let fm = FileManager.default
        // Bundle is file containing compiled code
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                // This is a picture to load
                pictures.append(item)
                numpics = pictures.count
                print(numpics)
                tableView.reloadData()
            }
        }
    }
    
    // Changing behavior from parent class and returning the number of rows that is in our array of pictures
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Challenge 2
        pictures.sort()
        return pictures.count
    }
    
    // Getting all the cells needed for our app
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // DequeueReuseableCell puts the cell not on the screen in an queue to use when needed
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // Challenge 3
            currentpicnum = indexPath.row
            vc.selectedImage = pictures[indexPath.row]
            title = " \(currentpicnum + 1) out of \(numpics)"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // Challenge 2
    @objc func shareTapped() {
        
        // Can Change image to the selectedImage to get the string of the picture
        let vc = UIActivityViewController(activityItems: ["Link for App"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
}

