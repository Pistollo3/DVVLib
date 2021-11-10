//
//  GHLocalizationManager.swift
//  DVVLib
//
//  Created by Daniele Viscuso on 10/11/21.
//

import VFGMVA10Foundation
import UIKit

//MVA10 ContentManager (Localization) Test class

//https://localise.biz/api/export/locale/
//WQd5KrH0zWjL3qmG4XT8uTfNxtptCCuZ

public class GHLocalizationManager {
    
    public static let shared = GHLocalizationManager()
    static let locoUrl = "https://localise.biz/api/export/locale/"
    static let locoKey = "WQd5KrH0zWjL3qmG4XT8uTfNxtptCCuZ"
    
    class func setupContentDictionary() {
        //compose URL
        guard let url: URL = URL(string: locoUrl +
                                    "it-IT" +
                                    ".json?fallback=en&key=" +
                                    locoKey +
                                    "&foramt=xcode") else { return }

        //create download task
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String] else { return }
                VFGContentManager.shared.dictionary = dictionary
            } catch let error {
                print("Error! \(error)")
            }
        })
        
        //launch download task
        task.resume()
    }
    
}
