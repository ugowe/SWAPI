//
//  CategoryTableViewCell.swift
//  SWAPI
//
//  Created by Joseph Ugowe on 9/3/19.
//  Copyright © 2019 Joseph Ugowe. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var itemInitialsBackgroundView: UIView!
    @IBOutlet weak var itemInitialsLabel: UILabel!
    
    // MARK: - Properties
    
    static let reuseIdentifier = Constants.Cell.categoryTableViewCell
    static let nibName = Constants.Cell.categoryTableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupTableViewCell()
    }
    
    // MARK: - Methods
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(category: GenericCategory) -> CategoryTableViewCell {
        
        self.titleLabel.text = category.title ?? category.name
        self.itemInitialsLabel.text = category.title?.initalizedLetters ?? category.name?.initalizedLetters
        self.dateLabel.text = category.created.localeDateString
        self.selectionStyle = .none
        
        if let openingCrawl = category.openingCrawl {
            self.subtitleLabel.text = openingCrawl
        }
        
        if let birthYear = category.birthYear {
            self.subtitleLabel.text = birthYear
        }
        
        if let diameter = category.diameter {
            self.subtitleLabel.text = diameter
        }
        
        if let classification = category.classification {
            self.subtitleLabel.text = classification.capitalized
        }
        
        if let model = category.model {
            self.subtitleLabel.text = model
        }
        
        return self
    }
    
    private func setupTableViewCell() {
        let arrow = UIImage(named: "disclosure_caret")
        self.accessoryType = .disclosureIndicator
        self.accessoryView = UIImageView(image: arrow!)
        self.itemInitialsBackgroundView.layer.cornerRadius = self.itemInitialsBackgroundView.frame.width / 2
    }
    
}
