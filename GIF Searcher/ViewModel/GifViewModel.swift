//
//  GifViewModel.swift
//  GIF Searcher
//
//  Created by Vlad Birukov on 19/10/2018.
//  Copyright © 2018 Vlad Birukov. All rights reserved.
//

import Foundation

class GifViewModel {
    let url: URL
    let width: Float
    let height: Float
    
    init(url: URL, width: Float, height: Float) {
        self.url = url
        self.width = width
        self.height = height
    }
}
