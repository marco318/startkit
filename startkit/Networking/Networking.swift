//
//  Networking.swift
//  startkit
//
//  Created by kimmyunghoon on 2016. 5. 24..
//  Copyright © 2016년 raspberrysoft. All rights reserved.
//

import Foundation
import Alamofire

class NetworkingController {
    
    static let sharedInstance = NetworkingController()
    
    let manager: Alamofire.Manager = {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.timeoutIntervalForRequest = 5
        config.timeoutIntervalForResource = 10
        return Manager(configuration: config)
    }()
    
    // used in singleton only
    private init() {}
    
    func get(url: String, params: [String: AnyObject]?, delegate: NetworkingControllerDelegate, requestName: String) {
        print("get url: \(url), params: \(params), requestName: \(requestName)")
        manager.request(.GET, url, parameters: params).responseJSON {
            response in
            print("\(response.request?.description)")
            delegate.onGetResponse(response, requestName: requestName)
        }
    }
    
    func post(url: String, params: [String: AnyObject]?, encoding: ParameterEncoding, delegate: NetworkingControllerDelegate, requestName: String) {
        print("post url: \(url), params: \(params), requestName: \(requestName)")
        manager.request(.POST, url, parameters: params, encoding: encoding).responseJSON {
            response in
            delegate.onPostResponse(response, requestName: requestName)
        }
    }
}

protocol NetworkingControllerDelegate {
    func onGetResponse(response: Response<AnyObject, NSError>, requestName: String)
    func onPostResponse(response: Response<AnyObject, NSError>, requestName: String)
}

extension NetworkingControllerDelegate {
    // This extension makes funcs below are not required.
    func onGetResponse(response: Response<AnyObject, NSError>, requestName: String) {}
    func onPostResponse(response: Response<AnyObject, NSError>, requestName: String) {}
}