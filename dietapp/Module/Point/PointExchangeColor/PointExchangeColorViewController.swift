//
//  PointExchangeColorViewController.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/18.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

class PointExchangeColorViewController: UIViewController {

    var pointExchangeColorAlertController: UIAlertController!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colorSet = ColorManager.singletonColorManager.colorSet
        
        self.view.backgroundColor = colorSet.background
        self.activityIndicatorView.color = colorSet.thick
        self.activityIndicatorView.style = .whiteLarge
        
        self.view.addSubview(activityIndicatorView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        activityIndicatorView.startAnimating()

        DispatchQueue.global(qos: .default).async {
            // 非同期処理などを実行
            Thread.sleep(forTimeInterval: 1)

            // 非同期処理などが終了したらメインスレッドでアニメーション終了
            DispatchQueue.main.async {
                // アニメーション終了
                self.activityIndicatorView.stopAnimating()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
