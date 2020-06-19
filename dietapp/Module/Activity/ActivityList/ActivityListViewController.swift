//
//  ActivityListViewController.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/09.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

class ActivityListViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var trainingListLabel: UILabel!
    @IBOutlet weak var activityTableView: UITableView! {
        didSet {
            self.activityTableView.delegate = self
            self.activityTableView.dataSource = self
        }
    }
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // カスタムセルを登録する(セル名：Cell)
        let nib = UINib(nibName: "ActivityTableViewCell", bundle: nil) //xibファイルを読み込む
        activityTableView.register(nib, forCellReuseIdentifier: "ActivityCell") //xibを登録する
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let colorSet = ColorManager.singletonColorManager.colorSet
        
        self.view.backgroundColor = colorSet.background
        self.activityTableView.backgroundColor = colorSet.background
        
        self.trainingListLabel.tintColor = colorSet.titleText
        self.trainingListLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        
        self.activityTableView.reloadData()
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension ActivityListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Training.TrainingMenu.allCases.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 選択されたcellのトレーニング名を取得する
        let trainingName: String = Training.TrainingMenu.allCases[indexPath.row].rawValue
        
        // ActivityRecordViewControllerのインスタンスを作成し遷移する
        let vc = ActivityDetailsViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.name = trainingName
        show(vc, sender: nil)
        
        self.activityTableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell",
                                                 for: indexPath) as! ActivityTableViewCell
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator // ここで「>」ボタンを設定
        cell.tintColor = UIColor(white: 0.8, alpha: 1.0)
        // cellに表示する内容を指定する
        cell.setCell(Training.TrainingMenu.allCases[indexPath.row].rawValue)
        return cell
    }
}
