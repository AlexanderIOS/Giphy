//
//  TrendingGifsViewController.swift
//  Giphy
//
//  Created by Oleksandr Hryhorchuk on 01.10.2017.
//  Copyright © 2017 Oleksandr Hryhorchuk. All rights reserved.
//

import UIKit

class TrendingGifsViewController: UIViewController {
    
    @IBOutlet weak var gifsCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!

    fileprivate var offset = 0
    fileprivate var gifs: [Gif] = [] { didSet { offset = gifs.count } }
    
    fileprivate var searchedText: String = ""
    fileprivate let dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        uploadGifs()
        gifs.removeAll()
    }
    
    fileprivate func registerCells() {
        gifsCollectionView.register(R.nib.gifCell)
    }
    
    fileprivate func uploadGifs() {
        GiphyAPI.trendingGifs(by: offset) { [weak self] gifs in
            guard let gifs = gifs else {
                print("Не удалось загрузить gif. Попробуйте позже")
                return
            }
            self?.gifs.append(contentsOf: gifs)
            self?.gifsCollectionView.reloadData()
        }
    }
    
    fileprivate func searchingGifs() {
        GiphyAPI.searchingGifs(by: searchedText, and: offset) { [weak self] gifs in
            guard let gifs = gifs else {
                print("Не удалось найти gif")
                return
            }
            self?.gifs.append(contentsOf: gifs)
            self?.gifsCollectionView.reloadData()
        }
    }
    
    @objc func longTap(gestureReconizer: UILongPressGestureRecognizer) {
        let locationInView = gestureReconizer.location(in: gifsCollectionView)
        let indexPath = gifsCollectionView.indexPathForItem(at: locationInView)!
        
        let shareAction = UIAlertAction(title: "Переслать", style: .default, handler: { _ in
            self.gifs[indexPath.row].share(with: self)
        })
        let saveAction = UIAlertAction(title: "Сохранить", style: .default, handler: { _ in
            self.dataManager.addToFavorites(self.gifs[indexPath.row])
        })
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel, handler: { _ in })
        Alert.present(title: "Действия", actions: [shareAction, saveAction, cancelAction], from: self, preferredStyle: .actionSheet)
    }
}

// MARK: - UICollectionViewDataSource
extension TrendingGifsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return gifs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.gifCell.identifier, for: indexPath) as! GifCollectionViewCell
        
        cell.fill(gif: gifs[indexPath.row])
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(TrendingGifsViewController.longTap))
        cell.addGestureRecognizer(longGesture)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let side = UIScreen.main.bounds.width / 2 - 20
        return CGSize(width: side, height: side)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        Alert.present(title: gifs[indexPath.row].info, from: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard indexPath.row == gifs.count - 1 else { return }
        offset += 20
        uploadGifs()
    }
}

// MARK: - UISearchResultsUpdating

extension TrendingGifsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedText = searchBar.text ?? ""
        gifs.removeAll()

        guard !searchedText.isEmpty else {
            uploadGifs()
            return
        }
        searchingGifs()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        gifs.removeAll()
        searchBar.text?.removeAll()
        searchBar.resignFirstResponder()
        uploadGifs()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
