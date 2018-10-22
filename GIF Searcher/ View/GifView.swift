//
//  GifView.swift
//  GIF Searcher
//
//  Created by Vlad Birukov on 19/10/2018.
//  Copyright © 2018 Vlad Birukov. All rights reserved.
//

import UIKit

protocol GifViewProtocol {
    func setupView(isSettingSearchBar: Bool)
    func reloadCollectionView()
    func stopLoadIndicator()
    func startLoadIndicator()
    func getCollectionView() -> UICollectionView
    func hideKeyboard()
    func showToast(string: String?)
}

class GifView: UIView, GifViewProtocol {
    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!

    func setupView(isSettingSearchBar: Bool) {
        if isSettingSearchBar == true {
            self.setupHideKeyboard()
        }
        
        self.registerCollectionViewCell()
    }
    
    func reloadCollectionView() {
        self.collectionView.reloadData()
    }
    
    func stopLoadIndicator() {
        self.activityIndicator.stopAnimating()
    }
    
    func startLoadIndicator() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    func showToast(string: String?) {
        if let message = string {
            self.showToast(message: message)
        }
    }
    
    func getCollectionView() -> UICollectionView {
        return self.collectionView
    }
    
    private func registerCollectionViewCell() {
        self.collectionView.register(UINib(nibName: "GifCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cellGif")
    }
    
    private func setupHideKeyboard() {
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.hideKeyboard))
        self.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() {
        if self.searchBar != nil {
            self.searchBar.endEditing(true)
        }
    }
}
