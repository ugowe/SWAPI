//
//  ItemDetailsTableViewCell.swift
//  SWAPI
//
//  Created by Joseph Ugowe on 9/3/19.
//  Copyright © 2019 Joseph Ugowe. All rights reserved.
//

import UIKit

class ItemDetailsTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    // MARK: - Properties
    
    static let reuseIdentifier = Constants.Cell.itemDetailsTableViewCell
    static let nibName = Constants.Cell.itemDetailsTableViewCell
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
