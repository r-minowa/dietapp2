//
//  ChallengeContentViewController.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/05/19.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit
import MBCircularProgressBar

class ChallengeContentViewController: UIViewController {
    
    private(set) lazy var presenter: ChallengeContentPresenterProtocol? =
        ChallengeContentPresenter(view: self, realmAccessor: RealmAccessor())
    
    var alertController: UIAlertController!
    
    // 初期セット
    var challenge: Training?
    var selectedLevel: Training.Level = .low
    var detail: Training.Details?
    
    // タイマー
    var timer: Timer!
    var trainingTimer: Timer!
    
    // タイマーラベル用変数
    var timer_sec: Float = 0
    // インターバル時間
    let intervalTime: Double = 10
    
    // トレーニング時間
    var trainingTime: Double = 0
    var trainingTime_: Double = 0
    //トレーニングのセット回数
    var trainingSet: Int = 0
    var nowTrainingSet: Int = 1
    
    // ロジック用カウント
    var count: Int = 0
    
    var id: Int = 0
    var index: Int = 0
    
    let colorManager = ColorManager().colorSet
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var currentSituationLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var timerView: MBCircularProgressBarView!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = self.colorManager.background
        self.timerView.backgroundColor = .clear
        self.timerView.progressAngle = 100
        
        // 取得したチャレンジのセット数と時間の取得
        detail = self.challenge?.details.filter{ $0.level == self.selectedLevel }.first
        if let unwrapDetail = detail {
            self.trainingTime = Double(unwrapDetail.secOfSets)
            self.trainingSet = unwrapDetail.countOfSets
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    // MARK: - IBAction
    
    @IBAction func wayBuuton(_ sender: Any) {
        let vc = TrainingMethodViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.explanation = self.challenge!.explanation
        show(vc, sender: nil)
    }
  
    @IBAction func backButtton(_ sender: Any) {
        
        if backButton.titleLabel?.text == "スタート" {
            
            self.trainingTime_ = self.trainingTime
            currentSituationLabel.text = "\(nowTrainingSet)セット目:トレーニングなう"
            
            // 動作中のタイマーを1つに保つために、 timer が存在しない場合だけ、タイマーを生成して動作させる
            if self.timer == nil {
                self.timer = Timer.scheduledTimer(timeInterval: 0.025, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
                self.trainingTimer = Timer.scheduledTimer(timeInterval: self.trainingTime_, target: self, selector: #selector(resetTimer(_:)), userInfo: nil, repeats: true)
                self.timerView.maxValue = CGFloat(trainingTime_)
            }
            
            backButton.setTitle("リタイア", for: .normal)
            backButton.title(for: .normal)
        } else {
            
            if self.timer != nil {
                self.timer.invalidate()   // タイマーを停止する
                self.trainingTimer.invalidate()
            }
            
            alertRetire(title: "警告", message: "本当にリタイアしますか？")
        }
    }
    
    // MARK: - PrivateMethod
    
    // selector: #selector(updatetimer(_:)) で指定された関数
    // timeInterval: 0.025, repeats: true で指定された通り、0.025秒毎に呼び出され続ける
    @objc func updateTimer(_ timer: Timer) {
        self.timer_sec += 0.025
        self.timerView.value = CGFloat(self.timer_sec)
    }
    
    @objc func resetTimer(_ timer: Timer) {
        
        // タイマーラベルを0秒にする
        self.timer_sec = 0
        
        // trainingTimerを停止する
        if self.trainingTimer != nil {
            self.trainingTimer.invalidate()
            self.trainingTimer = nil
        }
        
        // ロジックに従って、トレーニングとインターバルの値をtrainingTime_にセットする
        if ( (self.nowTrainingSet - 1) * 2 == count || self.nowTrainingSet == 0 ) { // 各セットのトレーニングが実行された後
            self.nowTrainingSet += 1
            self.trainingTime_ = self.intervalTime
            
            if self.nowTrainingSet <= self.trainingSet {
                self.trainingTimer = Timer.scheduledTimer(timeInterval: self.trainingTime_,
                                                          target: self,
                                                          selector: #selector(resetTimer(_:)),
                                                          userInfo: nil,
                                                          repeats: true)
                currentSituationLabel.text = "\(nowTrainingSet - 1)セット目:インターバル"
            }
        } else if ( (self.nowTrainingSet - 1) * 2 - 1 == count ) {  // 各セットのインターバルが実行された後
            self.trainingTime_ = self.trainingTime
            self.trainingTimer = Timer.scheduledTimer(timeInterval: self.trainingTime_,
                                                      target: self,
                                                      selector: #selector(resetTimer(_:)),
                                                      userInfo: nil,
                                                      repeats: true)
            currentSituationLabel.text = "\(nowTrainingSet)セット目:トレーニングなう"
        }
        
        self.timerView.maxValue = CGFloat(trainingTime_)
        
        // 現在のセット数が規定のセット数を超えた時
        if self.nowTrainingSet > self.trainingSet,
            self.timer != nil {
            self.timer.invalidate()
            self.timer = nil
            currentSituationLabel.text = "お疲れ様でした！"
            UserDefaultManager.shared.point += 1
            print("point = \(UserDefaultManager.shared.point)")
            self.presenter?.setBoolChallenge(id, index)
            alertPointGet(title: "Congraturation!!!", message: "おめでとう！1Pointゲット！")
        }
        
        // ロジック用カウントを＋１する
        self.count += 1
    }
    
    func alertRetire(title:String, message:String) {
        alertController = UIAlertController(title: title,
                                   message: message,
                                   preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "YES",
                                                style: .default,
                                                handler: {(action: UIAlertAction!) -> Void in
                                                    self.timer = nil          // タイマー開始のself.timer == nil で判断するために、self.timer = nil としておく
                                                    self.trainingTimer = nil
                                                    self.dismiss(animated: true, completion: nil)
                                                    
        }))
        alertController.addAction(UIAlertAction(title: "NO",
                                                style: .default,
                                                handler: {(action: UIAlertAction!) -> Void in
                                                    self.timer = Timer.scheduledTimer(timeInterval: 0.025,
                                                                                      target: self,
                                                                                      selector: #selector(self.updateTimer(_:)),
                                                                                      userInfo: nil,
                                                                                      repeats: true)
                                                    self.trainingTime_ -= Double(self.timer_sec)    // trainingTimerのtrainingTime_を残りの時間に設定する
                                                    self.trainingTimer = Timer.scheduledTimer(timeInterval: self.trainingTime_,
                                                                                              target: self,
                                                                                              selector: #selector(self.resetTimer(_:)),
                                                                                              userInfo: nil,
                                                                                              repeats: true)
        }))
        present(alertController, animated: true)
    }
    
    func alertPointGet(title:String, message:String) {
        alertController = UIAlertController(title: title,
                                   message: message,
                                   preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Point Get",
                                                style: .default,
                                                handler: {(action: UIAlertAction!) -> Void in
                                                    self.dismiss(animated: true, completion: nil)
        }))
        
        present(alertController, animated: true)
    }
}


// MARK: - ChallengeContentViewProtocol

extension ChallengeContentViewController: ChallengeContentViewProtocol {
    
}

