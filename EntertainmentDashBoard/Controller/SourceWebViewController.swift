//
//  NewSourceController.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 2/6/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit
import WebKit

class SourceWebViewController: ViewControllerPannable,Storyboarded {

    @IBOutlet weak var closeButton: UIButton!
    @objc var webContent: WKWebView!
    @IBOutlet weak var webContentView: WKWebView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var navLeftButton: UIButton!
    @IBOutlet weak var navRightButton: UIButton!
    
    public var urlString:String?
    public var sourceTitle:String?
    
    var coordinator:MusicCoordinator?
    
//    convenience init(url:String,title:String) {
//        self.urlString = url
//        self.sourceTitle = title
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProgressView()
        setUpWebContentView()
        titleLabel.text = sourceTitle
        

        
        
    }

    func setUpProgressView(){
        progressView.progressViewStyle = .default
        progressView.transform = progressView.transform.scaledBy(x: 1,
                                                                 y: 2)
    }
    
    func setUpWebContentView(){
        webContentView.load(urlString!)
        webContentView.allowsBackForwardNavigationGestures = true
        webContentView.navigationDelegate = self
        webContentView.addObserver(self,
                                   forKeyPath: #keyPath(WKWebView.estimatedProgress),
                                   options: .new,
                                   context: nil)
    }
    
    @IBAction func closeMe(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress"{
            progressView.setProgress(Float(webContentView!.estimatedProgress), animated: true)
        }
    }
    
    @IBAction func navLeftAction(_ sender: Any) {
        if webContentView.canGoBack{
            webContentView.goBack()
            navLeftButton.isEnabled = true
        }else{
            navLeftButton.isEnabled = false
        }
    }
    
    @IBAction func navRightAction(_ sender: Any) {
        if webContentView.canGoForward{
            webContentView.goForward()
            navRightButton.isEnabled = true
        }else{
            navRightButton.isEnabled = false
        }
    }
    
}

extension SourceWebViewController:WKNavigationDelegate{
    private func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        print(error.localizedDescription)
    }
    private func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Start to Navigating")
    }
    private func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        print("Start to Navigating")
    }
}

extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}
