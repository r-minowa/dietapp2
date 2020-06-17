//
//  BodyWeightGraphViewController.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/15.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit
import Charts

class BodyWeightGraphViewController: UIViewController {

    private(set) lazy var presenter: BodyWeightGraphPresenterProtocol? =
        BodyWeightGraphPresenter(view: self, realmAccessor: RealmAccessor())
    
    // チャートデータ
    var lineDataSet: LineChartDataSet!
    
    var max: Double = 0
    var min: Double = 1000
    
    var calenderDate = Date()
    
    let colorManager = ColorManager().colorSet
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var marginView: UIView!
    @IBOutlet weak var marginView2: UIView!
    @IBOutlet weak var chartView: UIView!
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dayWeightLabel: UILabel!
    @IBOutlet weak var weekWeightAveLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var inputButton: UIButton!
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // View設定
        self.view.backgroundColor = self.colorManager.background
        self.marginView.backgroundColor = self.colorManager.light
        self.marginView.layer.cornerRadius = 2
        self.marginView2.backgroundColor = self.colorManager.light
        self.marginView2.layer.cornerRadius = 2
        self.chartView.backgroundColor = self.colorManager.light
        self.chartView.layer.cornerRadius = 20
        self.lineChartView.backgroundColor = .clear
        
        // Label設定
        self.dayLabel.tintColor = self.colorManager.bodyText
        self.dayLabel.adjustsFontSizeToFitWidth = true
        self.dayWeightLabel.tintColor = self.colorManager.bodyText
        self.dayWeightLabel.adjustsFontSizeToFitWidth = true
        self.weekWeightAveLabel.tintColor = self.colorManager.bodyText
        self.weekWeightAveLabel.adjustsFontSizeToFitWidth = true
        
        // Button設定
        self.backButton.backgroundColor = self.colorManager.backButtonBackground
        self.backButton.tintColor = self.colorManager.backButtonTint
        self.inputButton.backgroundColor = self.colorManager.inputButtonBackground
        self.inputButton.tintColor = self.colorManager.inputButtonTint
        self.inputButton.layer.cornerRadius = 30
        
        // Noデータ時
        self.lineChartView.noDataText = "体重入力がありません" //Noデータ時に表示する文字
        self.lineChartView.noDataFont = UIFont.systemFont(ofSize: 30) //Noデータ時の表示フォント
        self.lineChartView.noDataTextColor = self.colorManager.bodyText //Noデータ時の文字色
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        self.dayLabel.text = "\(DateFormatters.bodyLabelFormatter.string(from: calenderDate)) の体重"
        
        if let weight = self.presenter?.getWeekWeight(calenderDate) {
            if weight != [] {
                self.initDisplay(value: weight)
            }
        }
        
        if let dayWeight = self.presenter?.getDayWeight(calenderDate),
            let weekWeightAve = self.presenter?.getWeekWeightAve(self.calenderDate){
            
            self.dayWeightLabel.text = String(dayWeight)
            self.weekWeightAveLabel.text = String(format: "%.1f", weekWeightAve)
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func inputButton(_ sender: Any) {
        let vc = BodyWeightRecordViewController()
        vc.calenderDate = self.calenderDate
        vc.modalPresentationStyle = .fullScreen
        show(vc, sender: nil)
    }
    
    // MARK: - PrivateMethod
    
    /// 折れ線グラフの設定
    /// - Parameter value: 回数
    func initDisplay(value: [Double]) {
        
        // プロットデータ(y軸)を保持する配列
        var dataEntries = [ChartDataEntry]()
        
        for (i, val) in value.enumerated() {
            dataEntries.append(ChartDataEntry(x: Double(i + 1), y: val))
        }
        
        self.lineDataSet = LineChartDataSet(entries: dataEntries, label: "")
        self.lineChartView.data = LineChartData(dataSet: self.lineDataSet)
        
        // 軸設定
        self.lineChartView.xAxis.enabled = false  // x軸の非表示
        
        for i in 0..<value.count {
            if self.max < value[i] {
                self.max = value[i]
            }
        }
        
        self.lineChartView.leftAxis.drawLabelsEnabled = false
        self.lineChartView.leftAxis.drawAxisLineEnabled = false
        self.lineChartView.leftAxis.axisMaximum = Double(max + 5) //y左軸最大値
        
        for i in 0..<value.count {
            if self.min > value[i] {
                self.min = value[i]
            }
        }
        
        var axisMin: Double = 0
        if (min - 5) > 0 {
            axisMin = Double(min - 5)
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
        self.lineChartView.borderColor = .red
        
        self.lineDataSet.colors = [self.colorManager.mid]  // グラフの色
        self.lineDataSet.circleColors = [self.colorManager.light]  // プロットの色
        self.lineDataSet.circleRadius = 5.0  // プロットの大きさ
        self.lineDataSet.drawValuesEnabled = true //各プロットのラベル表示するか
        self.lineDataSet.highlightEnabled = false //各点を選択した時に表示されるx,yの線を表示するか
        
    }
}

// MARK: - BodyWeightGraphViewProtocol

extension BodyWeightGraphViewController: BodyWeightGraphViewProtocol {
    
}