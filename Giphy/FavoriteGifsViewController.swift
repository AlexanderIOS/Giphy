//
//  FavoriteGifsViewController.swift
//  Giphy
//
//  Created by Oleksandr Hryhorchuk on 01.10.2017.
//  Copyright © 2017 Oleksandr Hryhorchuk. All rights reserved.
//

import UIKit
import RealmSwift

class FavoriteGifsViewController: UIViewController {
    
    @IBOutlet weak var gifsCollectionView: UICollectionView!
    
    fileprivate let dataManager = DataManager()
    fileprivate var gifs: [Gif] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        prepareGifs()
    }
    
    fileprivate func prepareGifs() {
        gifs.removeAll()
        gifs = dataManager.getFavoriteGifs()
        gifsCollectionView.reloadData()
    }
    
    fileprivate func registerCells() {
        gifsCollectionView.register(R.nib.gifCell)
    }
    
    @objc func longTap(gestureReconizer: UILongPressGestureRecognizer) {
        let locationInView = gestureReconizer.location(in: gifsCollectionView)
        let indexPath = gifsCollectionView.indexPathForItem(at: locationInView)!
        
        let shareAction = UIAlertAction(title: "Переслать", style: .default, handler: { _ in
            self.gifs[indexPath.row].share(with: self)
        })
        let saveAction = UIAlertAction(title: "Удалить", style: .default, handler: { _ in
            self.dataManager.deleteToFavorites(self.gifs.remove(at: indexPath.row))
            self.gifsCollectionView.reloadData()
        })
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel, handler: { _ in })
        Alert.present(title: "Действия", actions: [shareAction, saveAction, cancelAction], from: self, preferredStyle: .actionSheet)
    }
}


// MARK: - UICollectionViewDataSource
extension FavoriteGifsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
}
