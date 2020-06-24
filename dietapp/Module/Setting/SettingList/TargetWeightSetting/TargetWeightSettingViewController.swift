//
//  TargetWeightSettingViewController.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/21.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

class TargetWeightSettingViewController: UIViewController {

    private(set) lazy var presenter: TargetWeightSettingPresenterProtocol? =
        TargetWeightSettingPresenter(view: self, realmAccessor: RealmAccessor())
    
    // MARK: -IBOutlet
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var targetWeightTextField: UITextField! {
        didSet {
            self.targetWeightTextField.delegate = self
        }
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let colorSet = ColorManager.singletonColorManager.colorSet
        
        self.view.backgroundColor = colorSet.background
        
        self.backButton.backgroundColor = colorSet.backButtonBackground
        self.backButton.tintColor = colorSet.backButtonTint
        self.targetWeightTextField.backgroundColor = colorSet.light
    }
    
    // MARK: - IBOutlet
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - TargetWeightSettingViewProtocol

extension TargetWeightSettingViewController: TargetWeightSettingViewProtocol {
    func displayTargetWeightAlart(_ alart: UIAlertController) {
        present(alart, animated: true)
    }
    
    func dismissTargetWeightRecordView() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate

extension TargetWeightSettingViewController: UITextFieldDelegate {
    
    /// TextFieldのreturnが押されたとき
    /// - Parameter textField: UITextField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //キーボードをしまう
        self.view.endEditing(true)

        
        if let textFieldString = self.targetWeightTextField.text {
            self.presenter?.saveTargetWeight(textFieldString)
        }
        
        return false
    }
}
