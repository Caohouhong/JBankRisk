//
//  BaseWebViewController.swift
//  JBankRisk
//
//  Created by 曹后红 on 16/10/10.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//  网页的基类

import UIKit
import NJKWebViewProgress

class BaseWebViewController: UIViewController, UIWebViewDelegate, NJKWebViewProgressDelegate {

    //头部标题
    var webTitle: String?
    
    var webView: UIWebView?
    var requestUrl: String?
    var progressView: NJKWebViewProgressView?
    var progressProxy:NJKWebViewProgress?
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        
        webView = UIWebView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - TopFullHeight))
        webView?.scalesPageToFit = true
        self.view.addSubview(self.webView!)
        
        progressProxy = NJKWebViewProgress()
        webView?.delegate = progressProxy
        progressProxy?.webViewProxyDelegate = self
        progressProxy?.progressDelegate = self
        
        let progressBarHeight:CGFloat = 2.0
        let naviagtionBarBounds = self.navigationController?.navigationBar.bounds
        progressView = NJKWebViewProgressView(frame: CGRect(x: 0, y: (naviagtionBarBounds?.size.height)! - progressBarHeight, width: (naviagtionBarBounds?.size.width)!, height: progressBarHeight))
        
        progressView?.autoresizingMask = UIViewAutoresizing.flexibleWidth
       
        loadURL()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.addSubview(self.progressView!)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        progressView?.removeFromSuperview()
    }

    //基本UI
    func setupUI(){
        self.view.backgroundColor = UIColor.white
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "navigation_left_back_13x21"), style: .plain, target: self, action: #selector(doLeftNavigationBarImageBtnAction))
        self.view.addSubview(backImageView)
        
        backImageView.snp.makeConstraints { (make) in
            make.width.equalTo(13)
            make.height.equalTo(21)
            make.left.equalTo(16)
            make.top.equalTo(StatusBarHeight+11.5)
        }
    }
    
    //假navigationbar 返回键
    private lazy var backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "navigation_left_back_13x21")
        return imageView
    }()
    
    //MARK: - 加载地址
    func loadURL() {
        
        let url = URL(string: requestUrl!)
        let request = URLRequest(url: url!)
        webView?.loadRequest(request)
    }
    
    //MARK: - UIWebViewDelegate
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let url = request.url?.absoluteString
        print("加载地址：\(url as Optional)")
        return true
    }
    
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        if webTitle != nil {
            self.title = webTitle
        }else {
           self.title = webView.stringByEvaluatingJavaScript(from: "document.title")
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("finishLoad")
        progressView?.setProgress(1.0, animated: true)
    }
    
    //MARK: - NJKWebViewProgressDelegate
    func webViewProgress(_ webViewProgress: NJKWebViewProgress!, updateProgress progress: Float) {
        print("加载进度：\(progress)")
        progressView?.setProgress(progress, animated: true)
    }
    
    func doLeftNavigationBarImageBtnAction() {
        
        if ((webView?.canGoBack) == true) {
            webView?.goBack()
        }else
        {
            self.navigationController!.popViewController(animated: true)
        }
    }
//    //关闭
//    func doLeftNavigationBarTextBtnAction(){
//        self.navigationController!.popViewController(animated: true)
//    }
    
}
