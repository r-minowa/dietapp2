//
//  ActivityDetailsViewController.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/09.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit
import Charts

class ActivityDetailsViewController: UIViewController {
    
    private(set) lazy var presenter: ActivityDetailsPresenterProtocol? = ActivityDetailsPresenter(view: self, realmAccessor: RealmAccessor())
    
    // チャートデータ
    var lineDataSet: LineChartDataSet!
    
    var name: String = ""
    var max: Int = 0
    var min: Int = 0
    
    let colorManager = ColorManager().colorSet
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var lineChartView: LineChartView!
    
    @IBOutlet weak var trainingNameLabel: UILabel!
    @IBOutlet weak var aveLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var previousDataLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var inputActivityButton: UIButton!
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.view.backgroundColor = self.colorManager.background
        self.chartView.backgroundColor = self.colorManager.light
        self.chartView.layer.cornerRadius = 20
        self.lineChartView.backgroundColor = .clear
        
        self.trainingNameLabel.backgroundColor = .clear
        self.trainingNameLabel.adjustsFontSizeToFitWidth = true
        self.trainingNameLabel.text = name
        
        self.previousDataLabel.adjustsFontSizeToFitWidth = true
        
        // Button設定
        self.backButton.backgroundColor = self.colorManager.backButtonBackground
        self.backButton.tintColor = self.colorManager.backButtonTint
        self.inputActivityButton.layer.cornerRadius = 30
        self.inputActivityButton.backgroundColor = self.colorManager.inputButtonBackground
        self.inputActivityButton.tintColor = self.colorManager.inputButtonTint
        
        // Noデータ時
        self.lineChartView.noDataText = "未チャレンジです" //Noデータ時に表示する文字
        self.lineChartView.noDataFont = UIFont.systemFont(ofSize: 30) //Noデータ時の表示フォント
        self.lineChartView.noDataTextColor = self.colorManager.titleText //Noデータ時の文字色
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.presenter?.getActivityDetails(name)
        
        if let max_ = self.presenter?.getMaxCount(), let min_ = self.presenter?.getMinCount() {
            self.max = max_
            self.min = min_
        }
        
        if let count = self.presenter?.getCountArray(), let date = self.presenter?.getDate() {
            if count != [] {
                initDisplay(value: count, date: date)
            }
        }
        
        // ラベル設定
        if let totalCount = self.presenter?.getTotalCount() {
            self.totalLabel.text = String(totalCount)
        }
        if let aveCount = self.presenter?.getAveCount() {
            self.aveLabel.text = String(aveCount)
        }
        if let previousData = self.presenter?.getPreviousData() {
            self.previousDataLabel.text = String(previousData)
        }
        
    }
    
    // MARK: - IBAction
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func inputActivityButton(_ sender: Any) {
        let vc = ActivityRecordViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.name = name
        show(vc, sender: nil)
    }
    
    // MARK: - PrivateMethod
    
    /// 折れ線グラフの設定
    /// - Parameter value: 回数
    func initDisplay(value: [Double], date: [String]) {
        
        // プロットデータ(y軸)を保持する配列
        var dataEntries = [ChartDataEntry]()
        
        for (i, val) in value.enumerated() {
            dataEntries.append(ChartDataEntry(x: Double(i + 1), y: val))
        }
        
        self.lineDataSet = LineChartDataSet(entries: dataEntries, label: "")
        self.lineChartView.data = LineChartData(dataSet: self.lineDataSet)

        // 軸設定
        self.lineChartView.xAxis.enabled = false  // x軸の非表示
        self.lineChartView.leftAxis.axisMaximum = Double(max + 10) //y左軸最大値
        var axisMin: Double = 0
        if (min - 10) > 0 {
           axisMin = Double(min - 10)
        }
        self.lineChartView.leftAxis.axisMinimum = axisMin //y左軸最小値
        self.lineChartView.leftAxis.labelCount = 5 //y軸ラベルの表示数
        self.lineChartView.leftAxis.drawTopYLabelEntryEnabled = true // y軸の最大値のみ表示
        self.lineChartView.leftAxis.forceLabelsEnabled = false //最小最大値ラベルを必ず表示?
        self.lineChartView.rightAxis.enabled = false // Y軸右軸(値)を非表示
        self.lineChartView.extraTopOffset = 20 // 上から20pxオフセット
        self.lineChartView.legend.enabled = false // 左下のラベル非表示
        
        self.lineChartView.highlightPerTapEnabled = true  // タップでプロットを選択できないようにする
        self.lineChartView.pinchZoomEnabled = false // ピンチズームオフ
        self.lineChartView.doubleTapToZoomEnabled = false // ダブルタップズームオフ
        
        self.lineDataSet.colors = [UIColor.green]  // グラフの色
        self.lineDataSet.circleColors = [UIColor.red]  // プロットの色
        self.lineDataSet.circleRadius = 5.0  // プロットの大きさ
        self.lineDataSet.drawValuesEnabled = false //各プロットのラベル表示するか
        self.lineDataSet.highlightEnabled = false //各点を選択した時に表示されるx,yの線を表示するか
    }
}

// MARK: - ActivityDetailsViewProtocol

extension ActivityDetailsViewController: ActivityDetailsViewProtocol {
    
}
