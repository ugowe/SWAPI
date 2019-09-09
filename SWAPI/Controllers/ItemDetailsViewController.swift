//
//  ItemDetailsViewController.swift
//  SWAPI
//
//  Created by Joseph Ugowe on 9/3/19.
//  Copyright © 2019 Joseph Ugowe. All rights reserved.
//

import UIKit

class ItemDetailsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var itemDetailsTableView: UITableView!
    @IBOutlet weak var itemInitialsBackgroundView: UIView!
    @IBOutlet weak var itemInitialsLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    // MARK: - Properties
    
    var itemCategory: RootResource.RootResourceType?
    var itemURLString: String?
    var itemTitle: String?
    var itemInitials: String?
    var subtitleStringValue: String? {
        didSet {
            DispatchQueue.main.async {
                self.subtitleLabel.text = self.subtitleStringValue?.capitalized
            }
        }
    }
    
    var itemDetailsArray: [GenericItem] = [] {
        didSet {
            DispatchQueue.main.async {
                self.itemDetailsTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViewController()
        self.setupTableView()
    }
    
    // MARK: Methods
    
    private func setupViewController() {
        
        self.navigationItem.title = self.itemTitle?.uppercased()
        self.itemInitialsBackgroundView.layer.cornerRadius = self.itemInitialsBackgroundView.frame.width / 2
        self.itemInitialsLabel.text = self.itemInitials
    }
    
    private func setupTableView() {
        self.itemDetailsTableView.delegate = self
        self.itemDetailsTableView.dataSource = self
        
        let nib = UINib(nibName: ItemDetailsTableViewCell.nibName, bundle: nil)
        self.itemDetailsTableView.register(nib, forCellReuseIdentifier: ItemDetailsTableViewCell.reuseIdentifier)
        
        self.itemDetailsTableView.tableFooterView = UIView()
        guard let urlString = self.itemURLString else {
            debugPrint("CategoryVC Error: ResourceCategory is nil"); return
        }
        
        DispatchQueue.main.async {
            APIClient.shared.decodeGenericItem(urlString: urlString) { (result) in
                switch result {
                case .success(let itemDetailsArray):
                    self.itemDetailsArray = itemDetailsArray
                    if let category = self.itemCategory {
                        self.configureViewForCategory(category)
                    }
                case .failure(let error):
                    print(APIError.requestFailed(description: error.customDescription))
                }
            }
        }
    }
    
    private func configureViewForCategory(_ category: RootResource.RootResourceType) {
        
        switch category {
        case .people:
            let subtitleValue = find(value: "Birth Year", in: self.itemDetailsArray)
            self.subtitleStringValue = subtitleValue?.1.itemValue as? String
        case .films:
            let subtitleValue = find(value: "Opening Crawl", in: self.itemDetailsArray)
            self.subtitleStringValue = subtitleValue?.1.itemValue as? String
        case .starships:
            let subtitleValue = find(value: "Model", in: self.itemDetailsArray)
            self.subtitleStringValue = subtitleValue?.1.itemValue as? String
            
        case .vehicles:
            let subtitleValue = find(value: "Model", in: self.itemDetailsArray)
            self.subtitleStringValue = subtitleValue?.1.itemValue as? String
            
        case .planets:
            let subtitleValue = find(value: "Diameter", in: self.itemDetailsArray)
            self.subtitleStringValue = subtitleValue?.1.itemValue as? String
        case .species:
            let subtitleValue = find(value: "Classification", in: self.itemDetailsArray)
            self.subtitleStringValue = subtitleValue?.1.itemValue as? String
        }
    }
    
    private func find(value searchValue: String, in array: [GenericItem]) -> (Int, GenericItem)? {
        for (index, value) in array.enumerated() {
            if value.itemKey == searchValue {
                return (index, value)
            }
        }
        return nil
    }
    
}

// MARK: TableView DataSource & Delegate Methods

extension ItemDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemDetailsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemDetailsTableViewCell.reuseIdentifier, for: indexPath) as! ItemDetailsTableViewCell
        
        let itemDetail = itemDetailsArray[indexPath.row]
        cell.keyLabel.text = itemDetail.itemKey
        cell.valueLabel.text = itemDetail.itemValue as? String
        cell.selectionStyle = .none
        
        return cell
    }
    
}

