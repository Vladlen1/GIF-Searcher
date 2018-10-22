//
//  GifModels_to_GifViewModels.swift
//  GIF Searcher
//
//  Created by Vlad Birukov on 19/10/2018.
//  Copyright © 2018 Vlad Birukov. All rights reserved.
//

import Foundation

class GifModels_to_GifViewModels {
    
    func transform(models: [GifModel]) -> [GifViewModel] {
        var arrayViewModel = [GifViewModel]()
        
        for model in models {
            let viewModel = GifViewModel(url: model.url, width: model.width, height: model.height)
            
            arrayViewModel.append(viewModel)
        }
        
        return arrayViewModel
    }
}
