//
//  TrainingMethodViewController.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/05.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

class TrainingMethodViewController: UIViewController {

    var explanation: String = ""
    
    // MARK: - UIOutlet

    @IBOutlet weak var explainPopView: UIView!
    @IBOutlet weak var explanLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    // MARK: - LifeStyle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
       
        self.explainPopView.layer.cornerRadius = 30
        self.explanLabel.text = self.explanation
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let colorSet = ColorManager.singletonColorManager.colorSet
        
        self.explainPopView.backgroundColor = colorSet.light
        self.backButton.backgroundColor = colorSet.backButtonBackground
        self.backButton.tintColor = colorSet.backButtonTint
    }
    
    // MARK: - IBAcrtion
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
