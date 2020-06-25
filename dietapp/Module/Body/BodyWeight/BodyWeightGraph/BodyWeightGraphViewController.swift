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
    
//    var max: Double = 0
//    var min: Double = 1000
    
    var calenderDate = Date()
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        let colorSet = ColorManager.singletonColorManager.colorSet
        
        // View設定
        self.view.backgroundColor = colorSet.background
        self.marginView.backgroundColor = colorSet.light
        self.marginView.layer.cornerRadius = 2
        self.marginView2.backgroundColor = colorSet.light
        self.marginView2.layer.cornerRadius = 2
        self.chartView.backgroundColor = colorSet.light
        self.chartView.layer.cornerRadius = 20
        self.lineChartView.backgroundColor = .clear
        
        // Label設定
        self.dayLabel.textColor = colorSet.bodyText
        self.dayLabel.adjustsFontSizeToFitWidth = true
        self.dayWeightLabel.textColor = colorSet.bodyText
        self.dayWeightLabel.adjustsFontSizeToFitWidth = true
        self.weekWeightAveLabel.textColor = colorSet.bodyText
        self.weekWeightAveLabel.adjustsFontSizeToFitWidth = true
        
        // Button設定
        self.backButton.backgroundColor = colorSet.backButtonBackground
        self.backButton.tintColor = colorSet.backButtonTint
        self.inputButton.backgroundColor = colorSet.inputButtonBackground
        self.inputButton.tintColor = colorSet.inputButtonTint
        self.inputButton.layer.cornerRadius = 30
        
        // グラフ設定
        self.lineChartView.noDataText = "体重入力がありません" //Noデータ時に表示する文字
        self.lineChartView.noDataFont = UIFont.systemFont(ofSize: 30) //Noデータ時の表示フォント
        self.lineChartView.noDataTextColor = colorSet.bodyText //Noデータ時の文字色
        
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
//        let vc = BodyWeightRecordViewController()
//        vc.calenderDate = self.calenderDate
//        vc.modalPresentationStyle = .fullScreen
//        show(vc, sender: nil)
        
        let vc = InputPopupViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.titleName = "体重"
        vc.date = self.calenderDate
        show(vc, sender: nil)
    }
    
    // MARK: - PrivateMethod
    
    /// 折れ線グラフの設定
    /// - Parameter value: 回数
    func initDisplay(value: [Double]) {
        
        let colorSet = ColorManager.singletonColorManager.colorSet
        
        // プロットデータ(y軸)を保持する配列
        var linedata:  [LineChartDataSet] = Array()
        var dataEntries = [ChartDataEntry]()
        var targetWeight = [ChartDataEntry]()
        
        // データの設定
        for (i, val) in value.enumerated() {
            dataEntries.append(ChartDataEntry(x: Double(i + 1), y: val))
        }
        
        if value.count == 1 {
            for i in 0...2 {
                targetWeight.append(ChartDataEntry(x: Double(i), y: UserDefaultManager.shared.targetWeight))
            }
        } else {
            for i in 1...value.count {
                targetWeight.append(ChartDataEntry(x: Double(i), y: UserDefaultManager.shared.targetWeight))
            }
        }
        
        self.lineDataSet = LineChartDataSet(entries: dataEntries, label: "遷移")
        self.lineDataSet.circleRadius = 5.0  // プロットの大きさ
        self.lineDataSet.drawValuesEnabled = true //各プロットのラベル表示するか
        self.lineDataSet.highlightEnabled = false //各点を選択した時に表示されるx,yの線を表示するか
        self.lineDataSet.colors = [colorSet.graphColor]  // グラフの色
        self.lineDataSet.circleColors = [colorSet.graphProtColor]  // プロットの色
        linedata.append(lineDataSet)
        
        
        self.lineDataSet = LineChartDataSet(entries: targetWeight, label: "目標(\(UserDefaultManager.shared.targetWeight)kg)")
        self.lineDataSet.lineWidth = CGFloat(3)
        
        self.lineDataSet.drawCirclesEnabled = false // プロットを表示するか
        self.lineDataSet.drawValuesEnabled = false //各プロットのラベル表示するか
        self.lineDataSet.highlightEnabled = false //各点を選択した時に表示されるx,yの線を表示するか
        self.lineDataSet.colors = [.red]  // グラフの色
        linedata.append(lineDataSet)
        
        // chartView設定
        // 軸設定
        self.lineChartView.xAxis.enabled = false  // x軸の非表示
        
        if let max = self.presenter?.getWeightMax() {
            self.lineChartView.leftAxis.axisMaximum = Double(max + 5) //y左軸最大値
        }
        self.lineChartView.leftAxis.drawLabelsEnabled = false
        self.lineChartView.leftAxis.drawAxisLineEnabled = false
        
        if let axisMin = self.presenter?.getWeightMin() {
            self.lineChartView.leftAxis.axisMinimum = axisMin //y左軸最小値
        }
        self.lineChartView.leftAxis.labelCount = 5 //y軸ラベルの表示数
        self.lineChartView.leftAxis.drawTopYLabelEntryEnabled = true // y軸の最大値のみ表示
        self.lineChartView.leftAxis.forceLabelsEnabled = false //最小最大値ラベルを必ず表示?
        self.lineChartView.rightAxis.enabled = false // Y軸右軸(値)を非表示
        self.lineChartView.extraTopOffset = 20 // 上から20pxオフセット
        self.lineChartView.legend.enabled = true // 左下のラベル非表示
        self.lineChartView.highlightPerTapEnabled = true  // タップでプロットを選択できないようにする
        self.lineChartView.pinchZoomEnabled = false // ピンチズームオフ
        self.lineChartView.doubleTapToZoomEnabled = false // ダブルタップズームオフ
        self.lineChartView.borderColor = .red
        
        self.lineChartView.data = LineChartData(dataSets: linedata)
    }
}

// MARK: - BodyWeightGraphViewProtocol

extension BodyWeightGraphViewController: BodyWeightGraphViewProtocol {
    
}
