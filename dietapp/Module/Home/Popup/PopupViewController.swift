//
//  PopupViewController.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/03.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

final class PopupViewController: UIViewController {
    
    private(set) lazy var presenter: PopupPresenterProtocol? =
    PopupPresenter(view: self, realmAccessor: RealmAccessor())
    
    var partsStr: [String] = []
    var alartFlag: Bool = false
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var decisionButton: CustomButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var partsLabel: UILabel!
    @IBOutlet weak var levelView: UIView!
    @IBOutlet weak var partsView: UIView!
    @IBOutlet weak var targetView: UIView!
    @IBOutlet weak var partsPickerView: UIPickerView! {
        didSet {
            self.partsPickerView.dataSource = self
            self.partsPickerView.delegate = self
        }
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.viewWillAppear()
        
        let colorSet = ColorManager.singletonColorManager.colorSet
        
        // ポップアップの設定
        self.view.backgroundColor = colorSet.background
        
        self.levelView.backgroundColor = colorSet.light
        self.levelView.layer.cornerRadius = 20
        self.levelView.clipsToBounds = true
        
        self.partsView.backgroundColor = colorSet.light
        self.partsView.layer.cornerRadius = 20
        self.partsView.clipsToBounds = true
        
        self.targetView.backgroundColor = .clear
        
        self.titleLabel.font = UIFont.systemFont(ofSize: 40)
        self.levelLabel.font = UIFont.systemFont(ofSize: 25)
        self.partsLabel.font = UIFont.systemFont(ofSize: 25)
        
        
        guard let partsStr_ = self.presenter?.getPartsStr() else { return }
        self.partsStr = partsStr_
    }
    
    // MARK: - IBAction
    
    @IBAction func difficultySegmentController(_ sender: UISegmentedControl) {
        self.presenter?.selectLevelSegment(sender.selectedSegmentIndex)
    }
    
    /// 決定ボタン
    @IBAction func decisionButton(_ sender: Any) {
        self.presenter?.selectDecisionButton(alartFlag)
    }
}

// MARK: - PopupViewProtocol

extension PopupViewController: PopupViewProtocol {
    
    func displayPopupAlart(_ alart: UIAlertController) {
        present(alart, animated: true)
    }
    
    func dismissPopUp() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIPickerView

extension PopupViewController:  UIPickerViewDelegate, UIPickerViewDataSource {
    /// PickerViewの列数
    /// - Parameter pickerView: UIPickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /// PickerViewの行数
    /// - Parameter pickerView: UIPickerView
    /// - Parameter component: Int
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.partsStr.count
    }
    
    /// PickerViewの各行の文字列設定
    /// - Parameter pickerView: UIPickerView
    /// - Parameter row: Int
    /// - Parameter component: Int
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.partsStr[row]
    }
    
    /// PickerViewで選ばれた文字列
    /// - Parameter pickerView: UIPickerView
    /// - Parameter row: Int
    /// - Parameter component: Int
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.presenter?.setSelectedPositionStr(self.partsStr[row])
    }
}
