//
//  GifPresenter.swift
//  GIF Searcher
//
//  Created by Vlad Birukov on 20/10/2018.
//  Copyright © 2018 Vlad Birukov. All rights reserved.
//

import Foundation
import UIKit
import RxSwift



class GifPresenter: NSObject {
    private let gifInteractor = GifInteractor()
    private let cleanCacheInteractor = CleanCacheInteractor()
    private let modelsToViewModels = GifModels_to_GifViewModels()
    private var arrayModels = [GifViewModel]()
    private var page: Int = 0
    private var isPageRefreshing: Bool = false
    private var query: String? = nil
    private var gifView: GifViewProtocol?
    private let errorMessage = "Error has occurred"
    
    func setupPresenter(isSettingSearchBar: Bool, query: String? = nil, view: GifViewProtocol?) {
        self.gifView = view
        self.gifView?.setupView(isSettingSearchBar: isSettingSearchBar)
        self.query = query
        self.loadData(query: self.query)
    }
    
    func cleanCache() {
        self.cleanCacheInteractor.execute()
    }
    
    private func loadData(query: String? = nil) {
        let _ = self.gifInteractor.execute(page: self.page, searchQuery: query).observeOn(MainScheduler.instance).subscribe(onNext: {[weak self] models in
            if let instance = self {
                let viewModels = instance.modelsToViewModels.transform(models: models)
                instance.arrayModels += viewModels
            }
            
        }, onError: {[weak self] error in
            self?.gifView?.showToast(string: self?.errorMessage)
        }, onCompleted: {[weak self] in
            self?.isPageRefreshing = false
            self?.gifView?.reloadCollectionView()
            self?.gifView?.stopLoadIndicator()
        }, onDisposed: {})
    }
}

extension GifPresenter: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellGif", for: indexPath) as! GifCollectionViewCell
        
        cell.setup(with: self.arrayModels[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.arrayModels[indexPath.row].width
        let height = self.arrayModels[indexPath.row].height
        
        return CGSize(width: CGFloat(width), height: CGFloat(height))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.gifView?.hideKeyboard()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let collectionView = self.gifView?.getCollectionView() {
            if (collectionView.contentOffset.y >= (collectionView.contentSize.height - collectionView.bounds.size.height)) {
                if (self.isPageRefreshing == false) {
                    if self.page != 0 {
                        self.gifView?.startLoadIndicator()
                    }
                    self.isPageRefreshing = true
                    self.page += 1
                    
                    self.loadData(query: self.query)
                }
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let nextVC = UIStoryboard(name:"SearchGifViewController", bundle:nil).instantiateViewController(withIdentifier: "SearchGifViewController") as? SearchGifViewController else {
            print("Could not instantiate VC with identifier of type SearchGifViewController")
            
            return
        }
        
        if let query = searchBar.text {
            nextVC.title = query.uppercased()
            nextVC.query = query
            searchBar.text = ""
            
            searchBar.endEditing(true)
            
            if let currentVC = UIApplication.topViewController() {
                currentVC.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
}


