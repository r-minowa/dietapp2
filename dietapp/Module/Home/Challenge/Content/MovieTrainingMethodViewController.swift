//
//  MovieTrainingMethodViewController.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/25.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class MovieTrainingMethodViewController: UIViewController {

    var movieId: String = ""
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var movieView: YTPlayerView! {
        didSet {
            self.movieView.delegate = self
        }
    }
    @IBOutlet weak var backButton: UIButton!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        self.movieView.load(withVideoId: self.movieId)
        
        let colorSet = ColorManager.singletonColorManager.colorSet
        
        self.backButton.layer.cornerRadius = 20
        self.backButton.backgroundColor = colorSet.buttonBackground
        self.backButton.tintColor = colorSet.buttonTint
    }
    
    // MARK: - IBAction
    
    @IBAction func backButton(_ sender: Any) {
//        self.movieView.playVideo()
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - YTPlayerViewDelegate

extension MovieTrainingMethodViewController: YTPlayerViewDelegate {
    
}
