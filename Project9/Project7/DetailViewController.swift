//
//  DetailViewController.swift
//  Project7
//
//  Created by Justin Bengtson on 8/16/19.
//  Copyright © 2019 Justin Bengtson. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let detailItem = detailItem else { return }
        
        // Challenge 3
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%;} </style>
        </head>
        <body>
        <font color="red">\(detailItem.body)</font>
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
    }
    
    

}
