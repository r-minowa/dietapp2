//
//  ActivityRecordViewController.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/09.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

class ActivityRecordViewController: UIViewController {

    private(set) lazy var presenter: ActivityRecordPresenterProtocol? =
    ActivityRecordPresenter(view: self,
                            realmAccessor: RealmAccessor())
    
    private var alertController: UIAlertController!
    
    var name: String = ""
    
    let colorManager = ColorManager().colorSet
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var countTextField: UITextField! {
        didSet {
            self.countTextField.delegate = self
        }
    }
    @IBOutlet weak var backButton: UIButton!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = self.colorManager.background
        self.countTextField.backgroundColor = self.colorManager.mid
        
        self.backButton.backgroundColor = self.colorManager.backButtonBackground
        self.backButton.tintColor = self.colorManager.backButtonTint
    }
    
    // MARK: - IBAction
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - ActivityRecordViewProtocol

extension ActivityRecordViewController: ActivityRecordViewProtocol {
 
    func displayAlert(title:String, message:String) {
 
        alertController = UIAlertController(title: title,
                                            message: message,
                                            preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",
                                                style: .default,
                                                handler: nil
        ))
        
        present(alertController, animated: true)
    }
    
    func dismissActivityView() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate

extension ActivityRecordViewController: UITextFieldDelegate {
    
    /// TextFieldのreturnが押されたとき
    /// - Parameter textField: UITextField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Realmに保存する
        if let textFieldString = self.countTextField.text {
            self.presenter?.saveCountRealm(name, textFieldString)
        }
        
        //キーボードをしまう
        self.view.endEditing(true)

        return false
    }
}
