//
//  ViewController.swift
//  Day50
//
//  Created by Justin Bengtson on 9/4/19.
//  Copyright © 2019 Justin Bengtson. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var pics = [Picture]()
    var caption = ""
    var captions = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(takePicture))
      //  navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCaption))
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        let pic = pics[indexPath.row]
        cell.textLabel?.text = pic.caption
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pic = pics[indexPath.row]
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pic.image
            title = pic.image
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func captionToAdd(thingToBeCaptioned: String) {
        caption = thingToBeCaptioned
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @objc func takePicture() {
        if (UIImagePickerController  .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.allowsEditing = true
            vc.delegate = self
            present(vc, animated: true)
            
            let ac = UIAlertController(title: "Add Caption", message: "Add a caption to go along with your picture", preferredStyle: .alert)
            ac.addTextField()
            
            let submitAction = UIAlertAction(title: "Submit", style: .default) {
                [weak self, weak ac] action in
                guard let caption = ac?.textFields?[0].text else { return }
                self?.captionToAdd(thingToBeCaptioned: caption)
            }
            
            ac.addAction(submitAction)
            present(ac, animated: true)
            
        }
        
        else {
            print("No camera availiable")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        // Convert an image to a string
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let picture = Picture(caption: caption, image: imageName)
        pics.append(picture)
        tableView.reloadData()
        
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return pics.count
    }

    
    


}

