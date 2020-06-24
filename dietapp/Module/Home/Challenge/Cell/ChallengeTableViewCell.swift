//
//  ChallengeTableViewCell.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/05/18.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

class ChallengeTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var partsView: UIView!
    @IBOutlet weak var secSetView: UIView!
    @IBOutlet weak var marginView: UIView!
    
    
    @IBOutlet weak var trainingNameLabel: UILabel!
    @IBOutlet weak var partsLabel: UILabel!
    @IBOutlet weak var secLabel: UILabel!
    @IBOutlet weak var secStrLabel: UILabel!
    @IBOutlet weak var setLabel: UILabel!
    @IBOutlet weak var setStrLabel: UILabel!
    
    @IBOutlet weak var batuLabel: UILabel!
    
    @IBOutlet weak var achievementImageView: UIImageView!
    
    
    // MARK: -
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
    }
    
    // MARK: - PrivateMethod
    
    func setChallenge(_ challenge: Training, _ level: Training.Level) {
        
        let image = UIImage(named: "achievement")
        self.achievementImageView.image = image
        
        self.mainView.layer.cornerRadius = 5
        self.mainView.clipsToBounds = true
        
        let colorSet = ColorManager.singletonColorManager.colorSet
        
        self.nameView.backgroundColor = colorSet.thick
        self.partsView.backgroundColor = colorSet.mid
        self.secSetView.backgroundColor = colorSet.light
        self.achievementImageView.isHidden = true
        self.achievementImageView.backgroundColor = UIColor(white:0.5, alpha:0.5)
        self.marginView.backgroundColor = colorSet.background
        
        self.trainingNameLabel.textColor = colorSet.titleText
        self.partsLabel.textColor = colorSet.titleText
        self.secLabel.textColor = colorSet.titleText
        self.secStrLabel.textColor = colorSet.titleText
        self.setLabel.textColor = colorSet.titleText
        self.setStrLabel.textColor = colorSet.titleText
        self.batuLabel.textColor = colorSet.titleText
        
        let detail = challenge.details.filter{ $0.level == level }.first
        
        var parts: String = ""
        for count in 0..<challenge.parts.count {
            parts += "\(challenge.parts[count].rawValue) "
        }
        
        var sec = 0
        var set = 0
        
        if let unwrapDetail = detail {
            sec = unwrapDetail.secOfSets
            set = unwrapDetail.countOfSets
        }
        
        self.trainingNameLabel.text! = challenge.name.rawValue
        self.partsLabel.text = parts
        self.secLabel.text = String(sec)
        self.setLabel.text = String(set)        
    }
    
    func setAchievementCell() {
        self.achievementImageView.isHidden = false
    }
}
