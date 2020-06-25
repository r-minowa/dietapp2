//
//  DistanceSettingViewController.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/22.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit
import MBCircularProgressBar

class DistanceSettingViewController: UIViewController {

    private(set) lazy var presenter: DistanceSettingPresenterProtocol? =
        DistanceSettingPresenter(view: self)
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var stepCountView: MBCircularProgressBarView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var stepUnitLabel: UILabel!
    @IBOutlet weak var stepsTextLabel: UILabel!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.stepCountView.showUnitString = false
        self.stepCountView.showValueString = false
        self.stepCountView.progressLineWidth = 20
        self.stepCountView.emptyLineWidth = 20
        self.stepCountView.value = 0
        
        if let targetStep = self.presenter?.getTargetSteps(){
            self.stepCountView.maxValue = CGFloat(targetStep)  // 毎日の目標歩数
        }
        
        self.presenter?.getSteps()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let colorSet = ColorManager.singletonColorManager.colorSet
        
        self.view.backgroundColor = colorSet.background
        
        self.stepCountView.backgroundColor = colorSet.background
        self.stepCountView.progressColor = colorSet.thick
        self.stepCountView.progressStrokeColor = colorSet.thick
        self.stepCountView.emptyLineColor = colorSet.light
        self.stepCountView.emptyLineStrokeColor = colorSet.light
        
        self.backButton.backgroundColor = colorSet.backButtonBackground
        self.backButton.tintColor = colorSet.backButtonTint
        
        self.stepLabel.backgroundColor = colorSet.background
        self.stepLabel.adjustsFontSizeToFitWidth = true
        self.stepUnitLabel.backgroundColor = colorSet.background
        self.stepsTextLabel.backgroundColor = colorSet.background
        self.stepsTextLabel.textColor = colorSet.bodyText
        self.stepsTextLabel.adjustsFontSizeToFitWidth = true
        if let text = self.presenter?.getStepsTextLabelString() {
            self.stepsTextLabel.text = text
        }
    }

    // MARK: - IBAction
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - PrvateMethod
    
}

// MARK: - DistanceSettingViewProtocol

extension DistanceSettingViewController: DistanceSettingViewProtocol {
    
    func setSteps(_ steps: NSNumber) {
        self.stepCountView.value = CGFloat(truncating: steps)
        self.stepLabel.text = steps.stringValue
    }
    
    func displayStepsAlart(_ alart: UIAlertController) {
        present(alart, animated: true)
    }
}
