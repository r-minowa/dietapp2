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
    
    // チャート
    var chartView: LineChartView!
    // チャートデータ
    var lineDataSet: LineChartDataSet!
    
    var name: String = ""
    var max: Int = 0
    var min: Int = 0
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var childView: UIView!
    @IBOutlet weak var trainingNameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var aveLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.presenter?.getActivityDetails(name)
        
        if let max_ = self.presenter?.getMaxCount(), let min_ = self.presenter?.getMinCount() {
            self.max = max_
            self.min = min_
        }
        
        if let count = self.presenter?.getCountArray(), let date = self.presenter?.getDate() {
            initDisplay(value: count, date: date)
        }
       
        // ラベル設定
        self.trainingNameLabel.text = name
        if let totalCount = self.presenter?.getTotalCount() {
            self.totalLabel.text = "累計回数： \(String(totalCount))回"
        }
        if let aveCount = self.presenter?.getAveCount() {
            self.aveLabel.text = "平均回数： \(String(aveCount))回"
        }
        if let count = self.presenter?.getNumOfTraining() {
            self.countLabel.text = "トレーニング回数： \(String(count))回"
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
        
        self.chartView = LineChartView(frame: CGRect(x: 0,
                                                     y: (self.childView.frame.height / 2) - 200,
                                                     width: self.childView.frame.width,
                                                     height: 400))
        
        // プロットデータ(y軸)を保持する配列
        var dataEntries = [ChartDataEntry]()
        
        for (i, val) in value.enumerated() {
            dataEntries.append(ChartDataEntry(x: Double(i + 1), y: val))
        }
        
        self.lineDataSet = LineChartDataSet(entries: dataEntries, label: "")
        self.chartView.data = LineChartData(dataSet: self.lineDataSet)
        
        self.chartView.backgroundColor = .darkGray
        // x軸の非表示
        self.chartView.xAxis.enabled = false
        
        self.chartView.noDataText = "Keep Waiting" //Noデータ時に表示する文字
        self.chartView.noDataFont = UIFont.systemFont(ofSize: 30) //Noデータ時の表示フォント
        self.chartView.noDataTextColor = .red //Noデータ時の文字色
        
        
        
        // タップでプロットを選択できないようにする
        self.chartView.highlightPerTapEnabled = true
        self.chartView.leftAxis.axisMaximum = Double(max + 10) //y左軸最大値
        
        var axisMin: Double = 0
        if (min - 10) > 0 {
           axisMin = Double(min - 10)
        }
        self.chartView.leftAxis.axisMinimum = axisMin //y左軸最小値
        self.chartView.leftAxis.labelCount = 5 //y軸ラベルの表示数
        self.chartView.leftAxis.drawTopYLabelEntryEnabled = true // y軸の最大値のみ表示
        self.chartView.leftAxis.forceLabelsEnabled = false //最小最大値ラベルを必ず表示?
        self.chartView.rightAxis.enabled = false // Y軸右軸(値)を非表示
        self.chartView.extraTopOffset = 20 // 上から20pxオフセット
        self.chartView.legend.enabled = false // 左下のラベル非表示
        self.chartView.pinchZoomEnabled = false // ピンチズームオフ
        self.chartView.doubleTapToZoomEnabled = false // ダブルタップズームオフ
        
        
        self.lineDataSet.colors = [UIColor.green]  // グラフの色
        self.lineDataSet.circleColors = [UIColor.red]  // プロットの色
        self.lineDataSet.circleRadius = 5.0  // プロットの大きさ
        self.lineDataSet.drawValuesEnabled = false //各プロットのラベル表示するか
        self.lineDataSet.highlightEnabled = false //各点を選択した時に表示されるx,yの線を表示するか
        
        // 描画
        self.childView.addSubview(self.chartView)
    }
}

// MARK: - ActivityDetailsViewProtocol

extension ActivityDetailsViewController: ActivityDetailsViewProtocol {
    
}


/*
 
 // y軸のプロットデータ(検証用)
 let plotDatas = [55.0, 100.0, 80.0, 100.0, 45.0]
 
 initDisplay(y: plotDatas)
 
 // チャート
 var chartView: LineChartView!
 // チャートデータ
 var lineDataSet: LineChartDataSet!
 
 func initDisplay(y: [Double]) {
 
 self.chartView = LineChartView(frame: CGRect(x: 0,
 y: (self.childView.frame.height / 2) - 200,
 width: self.childView.frame.width,
 height: 400))
 
 // プロットデータ(y軸)を保持する配列
 var dataEntries = [ChartDataEntry]()
 
 for (i, val) in y.enumerated() {
 let dataEntry = ChartDataEntry(x: Double(i),
 y: val) // X軸データは、0,1,2,...
 dataEntries.append(dataEntry)
 }
 
 lineDataSet = LineChartDataSet(entries: dataEntries, label: "")
 chartView.data = LineChartData(dataSet: lineDataSet)
 
 // x軸のラベルをボトムに表示
 chartView.xAxis.labelPosition = .bottom
 // x軸のラベル数をデータの数に設定
 chartView.xAxis.labelCount = dataEntries.count - 1
 // タップでプロットを選択できないようにする
 chartView.highlightPerTapEnabled = false
 chartView.leftAxis.axisMaximum = 100 //y左軸最大値
 chartView.leftAxis.axisMinimum = 0 //y左軸最小値
 chartView.leftAxis.labelCount = 5 //y軸ラベルの表示数
 chartView.leftAxis.drawTopYLabelEntryEnabled = true // y軸の最大値のみ表示
 chartView.leftAxis.forceLabelsEnabled = true //最小最大値ラベルを必ず表示?
 chartView.rightAxis.enabled = false // Y軸右軸(値)を非表示
 chartView.extraTopOffset = 25 // 上から20pxオフセット
 chartView.legend.enabled = false // 左下のラベル非表示
 chartView.pinchZoomEnabled = false // ピンチズームオフ
 chartView.doubleTapToZoomEnabled = false // ダブルタップズームオフ
 // グラフアニメーション
 //           chartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
 // グラフの色
 lineDataSet.colors = [UIColor.green]
 // プロットの色
 lineDataSet.circleColors = [UIColor.red]
 // プロットの大きさ
 lineDataSet.circleRadius = 5.0
 
 // 描画
 self.childView.addSubview(self.chartView)
 
 }
 
 */
