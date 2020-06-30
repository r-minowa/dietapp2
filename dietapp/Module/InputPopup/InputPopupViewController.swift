//
//  InputPopUpViewController.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/25.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

class InputPopupViewController: UIViewController {

    private(set) lazy var presenter: InputPopupPresenterProtocol? = InputPopupPresenter(view: self, realmAccessor: RealmAccessor())
    
    var titleName: String = ""
    var trainingName: String = ""
    var date = Date()
    var addTapped: (() -> Void)?
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var inputTextField: UITextField! {
        didSet {
            self.inputTextField.delegate = self
        }
    }
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        self.mainView.layer.cornerRadius = 15
        
        self.inputTextField.placeholder = titleName
        self.inputTextField.keyboardType = .numberPad
        
        let pathAddButton = UIBezierPath(roundedRect: self.addButton.bounds, byRoundingCorners: [.bottomLeft], cornerRadii: CGSize(width: 15, height: 15))
        let maskAddButton = CAShapeLayer()
        maskAddButton.path = pathAddButton.cgPath
        self.addButton.layer.mask = maskAddButton
        
        let pathCancelButton = UIBezierPath(roundedRect: self.cancelButton.bounds, byRoundingCorners: [.bottomRight], cornerRadii: CGSize(width: 15, height: 15))
        let maskCancelButton = CAShapeLayer()
        maskCancelButton.path = pathCancelButton.cgPath
        self.cancelButton.layer.mask = maskCancelButton
        
        self.unitLabel.adjustsFontSizeToFitWidth = true
        
        self.presenter?.selectUnit(titleName)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let colorSet = ColorManager.singletonColorManager.colorSet
        
        self.mainView.backgroundColor = colorSet.light
        self.addButton.backgroundColor = colorSet.mid
        self.addButton.tintColor = colorSet.bodyText
        self.cancelButton.backgroundColor = colorSet.thick
        self.cancelButton.tintColor = colorSet.bodyText
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - IBAction
    
    @IBAction func addButton(_ sender: Any) {
        
        self.presenter?.setDate(trainingName: self.trainingName,
                                date: self.date)
        if let unwarpTextFieldString = self.inputTextField.text {
            self.presenter?.selectInputView(titleName: self.titleName,
                                            textFieldString: unwarpTextFieldString)
        }
        self.addTapped?()
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate

extension InputPopupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //キーボードをしまう
        self.view.endEditing(true)
    }
}

// MARK: - InputPopupViewProtocol

extension InputPopupViewController: InputPopupViewProtocol {
    func displayInputPopupAlart(alart: UIAlertController) {
        self.present(alart, animated:  true)
    }
    
    func dismissInputPopup() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func changeUnit(_ unit: String, _ title: String) {
        self.unitLabel.text = unit
        self.titleLabel.text = title
    }
    
    func changeAddButton(_ name: String) {
        self.addButton.setTitle(name, for: .normal)
    }
}
