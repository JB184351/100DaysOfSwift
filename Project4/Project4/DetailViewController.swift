//
//  ViewController.swift
//  Project4
//
//  Created by Justin Bengtson on 8/5/19.
//  Copyright © 2019 Justin Bengtson. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var progressView: UIProgressView!
    
    // Safe websites
    var websites: [String]!
    var selectedWebsite: String?
    
    // This function will be called before viewDidLoad method
    override func loadView() {
        webView = WKWebView()
        // Delegation pattern is being used here
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        // Challenge 2
        let goBack = UIBarButtonItem(title: "Back", style: .plain, target: webView, action: #selector(webView.goBack))
        let goForward = UIBarButtonItem(title: "Forward", style: .plain, target: webView, action: #selector(webView.goForward))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [goBack, progressButton, spacer, refresh, goForward]
        navigationController?.isToolbarHidden = false
        
        // Add Observer tells us who the observer is, property we want to observe, the value we want and a context value
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        // URL data type
        let url = URL(string: "https://" + websites[0])!
        // Wraps our URL in a request
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        
        // Goes through the array of safe websites to go
        // If I manually change this for loop to be gone and replace the title with something that is not in the array of websites then challenge 1 is complete.
        for website in websites {
         ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }
    
    private func loadPage() {
        if let website = selectedWebsite {
            let url = URL(string: "https://" + website)!
            webView.load(URLRequest(url: url))
        }
    }


    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        // Evaluating whether the url is on the safe list
        let url = navigationAction.request.url
        
        // If there is a url we check it
        if let host = url?.host {
            // Look through the list of websites and if we find it we allow it
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
                
                /*
                 This also helps solve challenge 1 when uncommented
                 else if !host.contains(website) {
                 let ac = UIAlertController(title: title, message: "Cannot open website", preferredStyle: .alert)
                 ac.addAction(UIAlertAction(title: title, style: .default, handler: openTapped))
                 present(ac, animated: true)
                 }
                 */
            }
        }
        // Otherwise we don't load the website
        decisionHandler(.cancel)
    }
}

