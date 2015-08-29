//
//  QiitaViewModel.swift
//  qiitaList
//
//  Created by 山崎友弘 on 2015/04/11.
//  Copyright (c) 2015年 basic. All rights reserved.
//

import UIKit
let CellId = "CellId"

class QiitaViewModel: NSObject, UITableViewDataSource  {
    var qiitList: [AnyObject] = []
    private var mRequestTask: NSURLSessionDataTask?
    override init() {
        super.init()
    }
    
    func updateQiitaList(complated:() -> Void) {
        WebApi.jsonObject("https://qiita.com/api/v2/items", complated: { (jsonObject:AnyObject?) -> Void in
            if let qiitaJsonObject: AnyObject = jsonObject{
                self.qiitList.removeAll(keepCapacity: false)
                for origin in qiitaJsonObject as! [[String:AnyObject]]{
                    var dic: [String:AnyObject] = [:]
                    dic["title"] = origin["title"]
                    dic["url"] = origin["url"]
                    self.qiitList.append(dic)
                }
                complated()
            }else{
                complated()
            }
        })
    }
    
    
    // MARK: - DataSourceメソッド
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: CellId);
        cell.textLabel?.text = qiitList[indexPath.row]["title"] as? String
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qiitList.count ?? 0;
    }
    
    
    func getUrl(indexPath: NSIndexPath) -> String?{
        return qiitList[indexPath.row]["url"] as? String
    }
}
