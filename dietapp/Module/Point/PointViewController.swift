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
            self.pointCollectionView.allowsSelection = true
        }
    }
    @IBOutlet weak var pointImageView: UIImageView!
    @IBOutlet weak var nowPointLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var needPointLabel: UILabel!
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaultManager.shared.point += 100
        
        let pointImage = UIImage(named: "point")
        self.pointImageView.image = pointImage
        
        // label設定
        self.nowPointLabel.adjustsFontSizeToFitWidth = true
        self.pointLabel.backgroundColor = .clear
        self.pointLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        self.pointLabel.text = "ポイント交換"
        
        // カスタムセルを登録する
        let nib = UINib(nibName: "PointCollectionViewCell", bundle: nil) //xibファイルを読み込む
        self.pointCollectionView.register(nib, forCellWithReuseIdentifier: "CollectionCell") //xibを登録する

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.sectionInset = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 50
        self.pointCollectionView.collectionViewLayout = layout

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let colorSet = ColorManager.singletonColorManager.colorSet
        
        self.view.backgroundColor = colorSet.background
        self.pointCollectionView.backgroundColor = colorSet.background
        
        self.nowPointLabel.text = String(UserDefaultManager.shared.point)
        
        if let unwarapNeedPoint = self.presenter?.getNeedPoint() {
            self.needPointLabel.text = "必要ポイント：\(unwarapNeedPoint)ポイント"
        }
        
        self.pointCollectionView.reloadData()
    }
}

// MARK: - PointViewProtocol

extension PointViewController: PointViewProtocol {

    func displayAlart(_ alart: UIAlertController) {
        present(alart, animated: true)
    }
    
    func trancePointExchangeColor() {
        let vc = PointExchangeColorViewController()
        vc.modalPresentationStyle = .fullScreen
        show(vc, sender: nil)
    }
    
    func removeCellSubView(_ cell: UICollectionViewCell) {
        cell.subviews[cell.subviews.count - 1].removeFromSuperview()
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension PointViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    // セルの個数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ColorManager.ThemeType.allCases.count
    }

    // セル生成
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! PointCollectionViewCell
        if let color = self.presenter?.getPointCollectionCellColor(indexPath.row),
            let name = self.presenter?.getPointCollectionCellString(indexPath.row),
            let flag = self.presenter?.getLockIconFrag(indexPath.row){
            cell.setColor(color, name, flag)
        }
        return cell
    }

    // セルが選択された場合
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)!
        let selectedBGView = UIView(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: cell.bounds.size.height))
        selectedBGView.layer.cornerRadius = 30
        selectedBGView.backgroundColor = UIColor(white: 0.2, alpha: 0.5)
        cell.addSubview(selectedBGView)
        cell.bringSubviewToFront(selectedBGView)
        
        self.presenter?.alartUnlockColor(indexPath.row, cell)
    }

    // セルの配置
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalSpace : CGFloat = 20
        let cellSize : CGFloat = self.view.bounds.width / 3 - horizontalSpace
        return CGSize(width: cellSize, height: cellSize)
    }
}
