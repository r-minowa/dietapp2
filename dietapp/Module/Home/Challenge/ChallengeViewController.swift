//
//  ChallengeViewController.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/05/18.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

final class ChallengeViewController: UIViewController {

    private(set) lazy var presenter: ChallengePresenterProtocol? =
        ChallengePresenter(view: self, realmAccessor: RealmAccessor())

    //　チャレンジを格納する変数
    var selectedChallenges: [Training] = []
    
    // カレンダータブの日付
    var calenderDate = Date()
    
    var today = Date()
    
    let colorManager = ColorManager().colorSet
    
    // MARK: - IBOulet
    
    @IBOutlet weak var challengeTableView: UITableView! {
        didSet{
            self.challengeTableView.delegate = self
            self.challengeTableView.dataSource = self
        }
    }
    @IBOutlet weak var noChallengesLavel: UILabel!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // カスタムセルを登録する(セル名：Cell)
        let nib = UINib(nibName: "ChallengeTableViewCell", bundle: nil) //xibファイルを読み込む
        challengeTableView.register(nib, forCellReuseIdentifier: "ChallengeCell") //xibを登録する
        self.noChallengesLavel.isHidden = true
        
        self.view.backgroundColor = self.colorManager.background
        self.challengeTableView.backgroundColor = self.colorManager.background
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.presenter?.selectedChallenge(calenderDate)
        self.presenter?.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !UserDefaultManager.shared.isShowPopUp {
            let vc = PopupViewController()
            vc.modalPresentationStyle = .fullScreen
            show(vc, sender: nil)
            self.presenter?.selectedChallenge(calenderDate)
            self.challengeTableView.reloadData()
        }
        
        
    }
}

// MARK: - ChallengeViewProtocol

extension ChallengeViewController: ChallengeViewProtocol {

    func reloadData(challenges: [Training]) {
        self.selectedChallenges = challenges
        self.challengeTableView.reloadData()
    }
    
    func getCalenderTabDate() -> Date {
        return self.calenderDate
    }
    
    
    func whetherSelectTableView(_ bool: Bool) {
        self.challengeTableView.allowsSelection = bool
    }
    
    /// ChallengeContentViewControllerへの遷移
    func transitionToContent(challenge: Training, level: Training.Level, index: Int) {
        let vc = ChallengeContentViewController()
        vc.challenge = challenge
        vc.selectedLevel = level
        var ID: Int = 0
        if let id = self.presenter?.getChallengeID() {
            ID = id
        }
        vc.id = ID
        vc.index = index
        // フルスクリーンで表示
        vc.modalPresentationStyle = .fullScreen
        self.show(vc, sender: nil)
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension ChallengeViewController: UITableViewDelegate, UITableViewDataSource {
    
    ///cellの数
    /// - Parameter tableView: UITableView
    /// - Parameter section: Int
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if self.selectedChallenges.count == 0 {
            self.noChallengesLavel.isHidden = false
        }
        return self.selectedChallenges.count    // チャレンジの数
    }
    
    /// セルが選択された時
    /// - Parameter tableView: UITableView
    /// - Parameter indexPath: IndexPath
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let challengeBool = self.presenter?.getChallengeBool(indexPath.row) {
            if !challengeBool {
                self.presenter?.didSelectCell(at: indexPath.row)
            }
        }
    }
    
    /// セルの設定
    /// - Parameter tableView: UITableView
    /// - Parameter indexPath: IndexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChallengeCell",
                                                 for: indexPath) as! ChallengeTableViewCell
        
        if let challenge_ = self.presenter?.setCellChallenge(self.selectedChallenges),
            let level = self.presenter?.getLevel() {
            cell.setChallengeString(challenge_, level)
        }
        
        if let challengeBool = self.presenter?.getChallengeBool(indexPath.row) {
            if challengeBool {
                cell.setAchievementCell()
            }
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 168
    }
}
