//
//  NetworkHandler.swift
//  CanadaFavList
//
//  Created by Prakash Rastogi on 22/01/20.
//  Copyright © 2020 Prakash Rastogi. All rights reserved.
//

import Foundation
import Alamofire

class NetworkHandler {
    
    // MARK: - Properties
    private static var sharedNetworkHandler:NetworkHandler = {
        let networkManager = NetworkHandler()
        return networkManager
    }()

    // Initialization
    private init() {}
    
    // Shared Object
    class func shared() -> NetworkHandler {
        return sharedNetworkHandler
    }
    
    //Get List from API
    public func getPlacesList(url:String, parameters:Dictionary<String,Any>?, finished:@escaping (Dictionary<String, Any>)->Void, failed:@escaping (String)->Void) {
        // Read from Local File
        
        if let path = Bundle.main.path(forResource: "canadaPlaceList", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                  if let jsonResult = jsonResult as? Dictionary<String, Any> {
                            // do stuff
                    DispatchQueue.main.async {
                        // update our UI
                        //print("jsonResult = \(jsonResult)")
                        finished(jsonResult)
                    }
                  } else {
                    DispatchQueue.main.async {
                        // update our UI
                        failed("Data Not Found")
                    }
                }
              } catch {
                   // handle error
                DispatchQueue.main.async {
                    // update our UI
                    failed("Failed")
                }
              }
        }
         
    }
    
}
