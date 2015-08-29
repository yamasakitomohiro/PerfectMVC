//
//  WebApi.swift
//  qiitaList
//
//  Created by 山崎友弘 on 2015/06/28.
//  Copyright (c) 2015年 basic. All rights reserved.
//

import UIKit

class WebApi {
    class func jsonObject(url:String,complated:((AnyObject?) -> Void)) -> NSURLSessionDataTask{
        var mRequestTask: NSURLSessionDataTask!
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "GET"
        mRequestTask = NSURLSession.sharedSession().dataTaskWithRequest(request,
            completionHandler: { data, response, error in
            var jsonObject:AnyObject?
            let statusCode = (response as! NSHTTPURLResponse).statusCode
            if(statusCode == 200){
                if (error == nil) {
                    var error:NSError?
                    jsonObject = NSJSONSerialization.JSONObjectWithData(
                        data,
                        options: NSJSONReadingOptions.AllowFragments,
                        error: &error) as AnyObject?
                }
            }
            complated(jsonObject)
        })
        mRequestTask.resume()
        return mRequestTask
    }
}
