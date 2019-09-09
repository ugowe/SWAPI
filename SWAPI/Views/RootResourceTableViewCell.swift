//
//  RootResourceTableViewCell.swift
//  SWAPI
//
//  Created by Joseph Ugowe on 9/3/19.
//  Copyright © 2019 Joseph Ugowe. All rights reserved.
//

import UIKit

class RootResourceTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var resourceBackgroundView: UIView!
    @IBOutlet weak var resourceImageView: UIImageView!
    @IBOutlet weak var resourceTitleLabel: UILabel!
    
    // MARK: - Properties
    
    static let reuseIdentifier = Constants.Cell.rootResourceTableViewCell
    static let nibName = Constants.Cell.rootResourceTableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupBackgroundView()
    }
    
    // MARK: - Methods
    
    func setupBackgroundView() {
        
        self.resourceBackgroundView.layer.masksToBounds = false
        self.resourceBackgroundView.layer.shadowOpacity = 0.85
        self.resourceBackgroundView.layer.shadowColor = UIColor.darkGray.cgColor
        self.resourceBackgroundView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.resourceBackgroundView.layer.cornerRadius = 0.65
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
