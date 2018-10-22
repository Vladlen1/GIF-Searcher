//
//  SearchGifViewController.swift
//  GIF Searcher
//
//  Created by Vlad Birukov on 19/10/2018.
//  Copyright © 2018 Vlad Birukov. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class SearchGifViewController: UIViewController {
    @IBOutlet weak private var gifPresenter: GifPresenter!
    
    var query: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gifView = self.view as? GifViewProtocol

        self.gifPresenter.setupPresenter(isSettingSearchBar: true, query: self.query, view: gifView)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.gifPresenter.cleanCache()
    }
    
    override func didReceiveMemoryWarning() {
        self.gifPresenter.cleanCache()
    }
}



