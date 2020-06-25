//
//  SettiingListViewController.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/19.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

class SettingListViewController: UIViewController {

    private(set) lazy var presenter: SettingListPresenterProtocol? =
        SettingListPresenter(view: self, realmAccessor: RealmAccessor())
    
    private let settingList: [String] = ["目標体重", "週間目標変更", "歩数"]
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var settingTableView: UITableView! {
        didSet {
            self.settingTableView.delegate = self
            self.settingTableView.dataSource = self
        }
    }
    @IBOutlet weak var settingLabel: UILabel!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // カスタムセルを登録する(セル名：Cell)
        let nib = UINib(nibName: "SettingTableViewCell", bundle: nil) //xibファイルを読み込む
        self.settingTableView.register(nib, forCellReuseIdentifier: "SettingCell") //xibを登録する
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let colorSet = ColorManager.singletonColorManager.colorSet
        
        self.view.backgroundColor = colorSet.background
        self.settingTableView.backgroundColor = colorSet.background
        
        self.settingLabel.tintColor = colorSet.titleText
        self.settingLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        
        self.settingTableView.reloadData()
    }
}

// MARK: - SettingListViewProtocol

extension SettingListViewController: SettingListViewProtocol {
    
    func trancefromSettingtoTargetWeight(_ vc: TargetWeightSettingViewController) {
        self.show(vc, sender: nil)
    }
    
    func trancefromInputPopup(_ vc: InputPopupViewController) {
        self.show(vc, sender: nil)
    }
    
    func trancefromSettingtoPopup(_ vc: PopupViewController) {
        self.show(vc, sender: nil)
    }
    
    func trancefromSettingtoDistance(_ vc: DistanceSettingViewController) {
        self.show(vc, sender: nil)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SettingListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingTableViewCell
        
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator // ここで「>」ボタンを設定
        cell.tintColor = UIColor(white: 0.8, alpha: 1.0)
        cell.setSettingCell(self.settingList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.selectCell(indexPath.row)
        self.settingTableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
}
