//
//  QitaListViewController.swift
//  qiitaList
//
//  Created by 山崎友弘 on 2015/04/11.
//  Copyright (c) 2015年 basic. All rights reserved.
//

import UIKit

class QitaListViewController: UIViewController,UITableViewDelegate {
    private let mModel = QiitaViewModel();
    
    override func loadView() {
        self.view = QiitaListView(model:mModel);
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let qiitaListView = self.view as! QiitaListView
        qiitaListView.refreshControl.addTarget(self, action: "tableUpdate:", forControlEvents: UIControlEvents.ValueChanged)
        qiitaListView.table.delegate   = self;
        qiitaListView.table.dataSource = mModel;
    }
    
    func tableUpdate(sender:UIRefreshControl){
        let qiitaListView = self.view as! QiitaListView
        mModel.updateQiitaList { () -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                qiitaListView.table.reloadData()
                sender.endRefreshing()
            })
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(mModel.getUrl(indexPath))
        let webViewCtr = WebViewController(url: mModel.getUrl(indexPath)!)
        self.navigationController?.pushViewController(webViewCtr, animated: true)
    }
}