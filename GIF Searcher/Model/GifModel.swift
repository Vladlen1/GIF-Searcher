//
//  GifModel.swift
//  GIF Searcher
//
//  Created by Vlad Birukov on 19/10/2018.
//  Copyright © 2018 Vlad Birukov. All rights reserved.
//

import Foundation

class GifModel {
    let url: URL
    let width: Float
    let height: Float
    let name: String
    
    init(url: URL, width: Float, height: Float, name: String) {
        self.url = url
        self.width = width
        self.height = height
        self.name = name
    }
}
