//
//  NetworkRequest.swift
//  JBankRisk
//
//  Created by 曹后红 on 16/10/15.
//  Copyright © 2016年 jingjinsuo. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

private let NetworkRequestShareInstance = NetworkRequest()

class NetworkRequest {
    class var sharedInstance : NetworkRequest {
        return NetworkRequestShareInstance
    }
}
extension NetworkRequest {
    //MARK: - GET 请求
    //    let tools : NetworkRequest.shareInstance!
    
    func getRequest(urlString: String, params : [String : Any], success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()) {
        
        //使用Alamofire进行网络请求时，调用该方法的参数都是通过getRequest(urlString， params, success :, failture :）传入的，而success传入的其实是一个接受           [String : AnyObject]类型 返回void类型的函数
        Alamofire.request(urlString, method: .get, parameters: params)
            .responseJSON { (response) in/*这里使用了闭包*/
                //当请求后response是我们自定义的，这个变量用于接受服务器响应的信息
                //使用switch判断请求是否成功，也就是response的result
                switch response.result {
                case .success(let value):
                    //当响应成功是，使用临时变量value接受服务器返回的信息并判断是否为[String: AnyObject]类型 如果是那么将其传给其定义方法中的success
//                    if let value = response.result.value as? [String: AnyObject] {
                        success(value as! [String : AnyObject])
//                    }
                    let json = JSON(value)
                    PrintLog(json)
                    
                case .failure(let error):
                    failture(error)
                    print("error:\(error)")
                }
        }
        
    }
    //MARK: - POST 请求
    func postRequest(urlString : String, params : [String : AnyObject], success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()) {
        
        Alamofire.request(urlString, method: HTTPMethod.post, parameters: params).responseJSON { (response) in
            switch response.result{
            case .success:
                if let value = response.result.value as? [String: AnyObject] {
                    success(value)
                }
            case .failure(let error):
                failture(error)
                PrintLog("error:\(error)")
            }

            }
        }
}

