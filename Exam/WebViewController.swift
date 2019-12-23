//
//  WebViewController.swift
//  Exam
//
//  Created by Apple on 2019/12/23.
//  Copyright © 2019 Exam. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var news: News?

    fileprivate lazy var wkWebView: WKWebView = {
        let user = WKUserContentController()
        let config = WKWebViewConfiguration()
        config.userContentController = user
        config.preferences.javaScriptEnabled = true
        config.preferences.javaScriptCanOpenWindowsAutomatically = true
        config.suppressesIncrementalRendering = true
        let webView = WKWebView(frame: self.view.bounds, configuration: config)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        return webView
    }()
    
    lazy var loading: UIActivityIndicatorView = {
        let object = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        object.hidesWhenStopped = true
        return object
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = news?.title
        view.addSubview(self.wkWebView)
        view.addSubview(loading)
        loading.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        wkWebView.frame = view.bounds
        
        guard let urlString = news?.url else {
            debugPrint("url为空, 无法加载")
            return
        }
        print(urlString)
        guard let url = URL(string: urlString) else {
            debugPrint("URL有误, 无法加载")
            return
        }
        
        let request = URLRequest(url: url)
        loading.startAnimating()
        wkWebView.load(request)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        wkWebView.frame = view.bounds
    }

}

// MARK: - WKUIDelegate, WKNavigationDelegate
extension WebViewController: WKUIDelegate, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("接收到服务器跳转请求");
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("发送请求前是否允许");
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print("接受响应后是否允许");
        decisionHandler(WKNavigationResponsePolicy.allow)
    }
    
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        print("开始加载地址: %@", webView.url?.absoluteString ?? "");
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("加载失败: %@", error.localizedDescription);
        loading.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("加载失败: %@", error.localizedDescription);
        loading.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("加载成功");
        loading.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            print("不受信任的网站: %@", webView.url?.absoluteString ?? "");
            guard let serverTrust = challenge.protectionSpace.serverTrust else {
                return
            }
            let card = URLCredential(trust: serverTrust)
            completionHandler(URLSession.AuthChallengeDisposition.useCredential,card);
        }
        
    }
}
