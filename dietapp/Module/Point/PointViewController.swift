//
//  PointViewController.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/05/19.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

class PointViewController: UIViewController {

    private(set) lazy var presenter: PointPresenterProtocol? =
        PointPresenter(view: self, realmAccessor: RealmAccessor())
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var pointCollectionView: UICollectionView! {
        didSet {
            self.pointCollectionView.delegate = self
            self.pointCollectionView.dataSource = self
        }
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // カスタムセルを登録する(セル名：Cell)
        let nib = UINib(nibName: "PointCollectionViewCell", bundle: nil) //xibファイルを読み込む
        self.pointCollectionView.register(nib, forCellWithReuseIdentifier: "CollectionCell") //xibを登録する
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.sectionInset = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
        layout.minimumInteritemSpacing = 50
        layout.minimumLineSpacing = 50
        self.pointCollectionView.collectionViewLayout = layout
        
    }
}

// MARK: - PointViewProtocol

extension PointViewController: PointViewProtocol {
    
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension PointViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ColorManager.ThemeType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! PointCollectionViewCell
        cell.setColor(indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter?.selectColor(indexPath.row)
        
        print("hoge")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalSpace : CGFloat = 20
        let cellSize : CGFloat = self.view.bounds.width / 3 - horizontalSpace
        return CGSize(width: cellSize, height: cellSize)
    }
}
