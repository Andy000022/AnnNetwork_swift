//
//  AnnNetwork.swift
//  AnnNetworkTool
//
//  Created by iSolar on 2017/8/14.
//  Copyright © 2017年 nothing. All rights reserved.
//

import UIKit
import AFNetworking

enum requestType : Int {
    case GET = 1
    case POST = 2
}


class AnnNetwork: AFHTTPSessionManager {

    
    // 单例
    static let networkTool : AnnNetwork = {
        
        let networkTool = AnnNetwork()
        
        networkTool.responseSerializer.acceptableContentTypes?.insert("text/html")
        
        return networkTool
    
    }()
    
    
}


extension AnnNetwork {

    func request(requestType : requestType, url : String, parameters : [String : Any]?, succeed : @escaping([String : Any]?) -> (), failure : @escaping(Error?) -> ()) {
        
        // 成功闭包
        let successBlock = { (task: URLSessionDataTask, responseObj: Any?) in
            succeed(responseObj as? [String : Any])
        }
        // 失败的闭包
        let failureBlock = { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        }
        // Get 请求
        if requestType == .GET {
            get(url, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }
        // Post 请求
        if requestType == .POST {
            post(url, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }
    }
    
    
    // 上传图片
    // MARK: - 封装 AFN 方法
    /// 上传文件必须是 POST 方法，GET 只能获取数据
    /// 封装 AFN 的上传文件方法
    ///
    /// - parameter URLString:  URLString
    /// - parameter parameters: 参数字典
    /// - parameter img:      UIImage对象
    /// - parameter completion: 完成回调
    
    func unload(urlString: String, parameters: AnyObject?, img : UIImage , uploadProgress: ((_ progress:Progress) -> Void)?, success: ((_ responseObject:AnyObject?) -> Void)?, failure: ((_ error: NSError) -> Void)?) -> Void {
        
        post(urlString, parameters: parameters, constructingBodyWith: { (formData) in
            
            let imageData = UIImageJPEGRepresentation(img, 0.8)
            
            formData.appendPart(withFileData: imageData!, name: "upload", fileName: "head.img", mimeType: "image/jpeg")
            
        }, progress: { (progress) in
            uploadProgress!(progress)
            
        }, success: { (task, objc) in
            if objc != nil {
                success!(objc as AnyObject?)
            }
        }, failure: { (task, error) in
            
            failure!(error as NSError)
            
        })
        
    }
    
}
