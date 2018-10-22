//
//  JSON_to_GifModels.swift
//  GIF Searcher
//
//  Created by Vlad Birukov on 19/10/2018.
//  Copyright © 2018 Vlad Birukov. All rights reserved.
//

import Foundation
import SwiftyJSON

class JSON_to_GifModels {
    
    func transform(json: JSON) -> [GifModel] {
        let imageType = "fixed_width"

        var gifModels = [GifModel]()

        for (_, subJson):(String, JSON) in json["data"] {
            if let url = subJson["images"][imageType]["url"].url,
                let width = subJson["images"][imageType]["width"].string,
                let height = subJson["images"][imageType]["height"].string,
                let gifName = subJson["title"].string {
                    if let floatWidth = Float(width), let floatHeight = Float(height) {
                        let gif = GifModel(url: url, width: floatWidth, height: floatHeight, name: gifName)
                        gifModels.append(gif)
                }
            }
        }
        
        return gifModels
    }
}
