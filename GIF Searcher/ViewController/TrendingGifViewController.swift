//
//  TrendingGifViewController.swift
//  GIF Searcher
//
//  Created by Vlad Birukov on 19/10/2018.
//  Copyright © 2018 Vlad Birukov. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class TrendingGifViewController: UIViewController {
    @IBOutlet weak private var gifPresenter: GifPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gifView = self.view as? GifViewProtocol
        
        self.gifPresenter.setupPresenter(isSettingSearchBar: true, view: gifView)
    }
    
    override func didReceiveMemoryWarning() {
        self.gifPresenter.cleanCache()
    }
}

