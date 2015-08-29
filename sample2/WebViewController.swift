//
//  WebViewController.swift
//  qiitaList
//
//  Created by 山崎友弘 on 2015/08/11.
//  Copyright (c) 2015年 basic. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    let _url:String!
    init(url:String){
        _url = url
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webView = UIWebView(frame: self.view.frame)
        self.view.addSubview(webView)
        webView.loadRequest(NSURLRequest(URL: NSURL(string: _url)!))
    }
}
