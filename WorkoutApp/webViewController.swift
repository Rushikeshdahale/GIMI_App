//
//  webViewController.swift
//  WorkoutApp
//
//  Created by Rushikesh Dahale on 28/12/23.
//
//import UIKit
//import WebKit
//
//class webViewController: UIViewController, WKNavigationDelegate {
//    
//    
//    var webView: WKWebView!
//    let activityIndicator = UIActivityIndicatorView(style: .medium)
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        initilzeWebKitView()
//    }
//    
//    func initilzeWebKitView() {
//        activityIndicator.startAnimating()
//        webView = WKWebView()
//        webView.navigationDelegate = self
//        
//        if let url = URL(string: "https://youtu.be/R6gZoAzAhCg?si=3WY5gJ_P4ggZTRpu") {
//            let urlRequest = URLRequest(url: url)
//            webView.load(urlRequest)
//        }
//        
//        webView.allowsBackForwardNavigationGestures = true
//    }
//}
import UIKit
import WebKit

class webViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    let activityIndicator = UIActivityIndicatorView(style: .medium)

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Do work hard")
        initializeWebView()
    }
    
    func initializeWebView() {
        activityIndicator.startAnimating()
        
        webView = WKWebView()
        webView.navigationDelegate = self
        
        if let url = URL(string: "https://youtu.be/R6gZoAzAhCg?si=3WY5gJ_P4ggZTRpu") {
            let urlRequest = URLRequest(url: url)
            webView.load(urlRequest)
        }
        
        webView.allowsBackForwardNavigationGestures = true
        
        // Add the webView as a subview to your view controller's view
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        // Set constraints to fill the entire view
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
