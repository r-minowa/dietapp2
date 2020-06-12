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
    
    @IBOutlet weak var backButton: CustomButton!
    @IBOutlet weak var explainPopView: UIView!
    @IBOutlet weak var explanLabel: UILabel!
    
    // MARK: - LifeStyle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        self.explainPopView.backgroundColor = UIColor(white:0.6, alpha:1.0)
        self.explainPopView.layer.cornerRadius = 30
        self.explanLabel.text = self.explanation
    }

    // MARK: - IBAcrtion
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
