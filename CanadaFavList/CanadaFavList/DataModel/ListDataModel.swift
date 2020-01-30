//
//  ListDataModel.swift
//  CanadaFavList
//
//  Created by Prakash Rastogi on 23/01/20.
//  Copyright © 2020 Prakash Rastogi. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import Combine

public class ListDataModel: Identifiable, Codable {
    
    public var title:String?
    public var description:String?
    public var imageRef:String?
    public var imageRefUrl: URL?
    
    init() {
        
    }
    
    init(dataDict: Dictionary<String,Any?>) {
        if let title = dataDict[kTitle] as? String {
            self.title = title
        } else {
            self.title = ""
        }
        if let description = dataDict[kDescription] as? String {
            self.description = description
        } else {
            self.description = ""
        }
        if let imageRef = dataDict[kImageRef] as? String {
            self.imageRef = imageRef
        } else {
            self.imageRef = ""
        }
        if let imageRef = self.imageRef {
            self.imageRefUrl = URL(string: imageRef)
        } else {
            self.imageRefUrl = URL(string: "")
        }
    }
    
    class func getDataModelLis(listDict: [Dictionary<String,Any?>])->[ListDataModel] {
        var listObj = [ListDataModel]()
        if listDict.count > 0 {
            for currentDict in listDict {
                let currentDataObj = ListDataModel.init(dataDict: currentDict)
                if currentDataObj.title?.count == 0, currentDataObj.description?.count == 0, currentDataObj.imageRef?.count == 0 {
                    //No addition in List
                } else {
                    listObj.append(currentDataObj)
                }
            }
        }
        return listObj
    }
    
}

class DataModels: Identifiable, Codable {
    var feedTitle: String = ""
    var feedDataArray: [ListDataModel] = []
}

final class ParseData: ObservableObject {
    
    let didChange = PassthroughSubject<ParseData,Never>()
    
    @Published var isLoading: Bool = true {
        willSet {
            didChange.send(self)
        }
    }
    
    @Published var feedTitle: String = "" {
        willSet {
            didChange.send(self)
        }
    }
    
    @Published var feedDataArray: [ListDataModel] = [] {
        willSet {
            didChange.send(self)
        }
    }
    
    init() {
        self.feedTitle = ""
        self.feedDataArray = []
        let webCallObj = NetworkHandler.shared()
        webCallObj.getPlacesList(url: AppUrl, parameters: [:], finished: { response in
            //print("Success Response = \(response)")
            if let dataDict = response as? Dictionary<String,Any?>  {
                let allKeys = dataDict.keys
                if allKeys.count > 0 {
                    for key in allKeys {
                        if key.elementsEqual(kTitle) {
                            self.feedTitle = dataDict[key] as? String ?? ""
                        }
                        if key.elementsEqual(kRows) {
                            if let dataArray = dataDict[key] as? [Dictionary<String,Any?>], dataArray.count > 0 {
                                let responseDataList = ListDataModel.getDataModelLis(listDict: dataArray)
                                if responseDataList.count > 0 {
                                    self.feedDataArray.append(contentsOf: responseDataList)
                                }
                            }
                        }
                    }
                }
            }
            
            if self.feedDataArray.count > 0 {
                self.isLoading = false
            } else {
                self.isLoading = true
            }
            
        }) { failureMsg in
            print("Failure Response = \(failureMsg)")
            self.isLoading = false
        }
    }
    
    init(urlStr:String) {
        self.feedTitle = ""
        self.feedDataArray = []
        let webCallObj = NetworkHandler.shared()
        webCallObj.getPlacesList(url: AppUrl, parameters: [:], finished: { response in
            print("Success Response = \(response)")
        }) { failureMsg in
            print("Failure Response = \(failureMsg)")
        }
    }
    
    init(responseDict: Dictionary<String,Any?>?) {
        self.feedTitle = ""
        self.feedDataArray = []
        if let dataDict = responseDict {
            let allKeys = dataDict.keys
            if allKeys.count > 0 {
                for key in allKeys {
                    if key.elementsEqual(kTitle) {
                        self.feedTitle = dataDict[key] as? String ?? ""
                    }
                    if key.elementsEqual(kRows) {
                        if let dataArray = dataDict[key] as? [Dictionary<String,Any?>], dataArray.count > 0 {
                            let responseDataList = ListDataModel.getDataModelLis(listDict: dataArray)
                            if responseDataList.count > 0 {
                                self.feedDataArray.append(contentsOf: responseDataList)
                            }
                        }
                    }
                }
            }
        }
    }
    
}
