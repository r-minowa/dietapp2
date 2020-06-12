//
//  BodyWeightRecordViewController.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/11.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

class BodyWeightRecordViewController: UIViewController {

    private(set) lazy var presenter: BodyWeightRecordPresenterProtocol? = BodyWeightRecordPresenter(view: self, realmAccessor: RealmAccessor())
    
    private var alertController: UIAlertController!
    
    var calenderDate = Date()
    
    // MARK: - IBOutlet

    @IBOutlet weak var WeightTextField: UITextField! {
        didSet {
            self.WeightTextField.delegate = self
        }
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - IBAction
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - BodyWeightRecordViewProtocol

extension BodyWeightRecordViewController: BodyWeightRecordViewProtocol {
    
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
    
    func dismissBodyWeightRecordView() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate

extension BodyWeightRecordViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        //キーボードをしまう
        self.view.endEditing(true)
        
        if let weightStr = WeightTextField.text {
            self.presenter?.saveWeight(weightStr, self.calenderDate)
        }
    
        return false
    }
    
}
