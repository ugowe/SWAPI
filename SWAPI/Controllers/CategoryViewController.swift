//
//  CategoryViewController.swift
//  SWAPI
//
//  Created by Joseph Ugowe on 9/3/19.
//  Copyright © 2019 Joseph Ugowe. All rights reserved.
//

import Foundation
import UIKit

class CategoryViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var categoryTableView: UITableView!
    
    // MARK: - Properties
    
    var resourceCategory: RootResource?
    var selectedCategoryURLString: String?
    var itemTitle: String?
    var itemInitials: String?
    var genericCategoryArray: [GenericCategory] = [] {
        didSet {
            DispatchQueue.main.async {
                self.categoryTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
        self.setupTableView()
        
    }
    
    // MARK: Methods
    
    private func setupNavigationBar() {
        guard let categoryName = resourceCategory?.resourceName else {
            debugPrint("CategoryVC Error: ResourceCategory is nil"); return
        }
        self.navigationItem.title = categoryName.uppercased()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    
    private func setupTableView() {
        self.categoryTableView.delegate = self
        self.categoryTableView.dataSource = self
        
        let nib = UINib(nibName: CategoryTableViewCell.nibName, bundle: nil)
        self.categoryTableView.register(nib, forCellReuseIdentifier: CategoryTableViewCell.reuseIdentifier)
        self.categoryTableView.tableFooterView = UIView()
        
        guard let urlString = resourceCategory?.resourceURL else {
            debugPrint("CategoryVC Error: ResourceCategory is nil"); return
        }
        
        DispatchQueue.main.async {
            APIClient.shared.decodeGenericCategory(urlString: urlString) { (result) in
                switch result {
                case .success(let categoryArray):
                    self.genericCategoryArray = categoryArray
                case .failure(let error):
                    print(APIError.requestFailed(description: error.customDescription))
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let itemDetailsVC = segue.destination as? ItemDetailsViewController {
            itemDetailsVC.itemCategory = self.resourceCategory?.resourceType
            itemDetailsVC.itemURLString = self.selectedCategoryURLString
            itemDetailsVC.itemTitle = self.itemTitle
            itemDetailsVC.itemInitials = self.itemInitials
        }
    }

}

// MARK: TableView DataSource & Delegate Methods

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.genericCategoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.reuseIdentifier, for: indexPath) as! CategoryTableViewCell
        
        let category = genericCategoryArray[indexPath.row]
        let categoryTableViewCell = cell.configureCell(category: category)
        self.itemTitle = categoryTableViewCell.titleLabel.text
        self.itemInitials = categoryTableViewCell.itemInitialsLabel.text
        
        return categoryTableViewCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let category = genericCategoryArray[indexPath.row]
        self.selectedCategoryURLString = category.url
        
        performSegue(withIdentifier: Constants.Segue.itemDetailsVCSegue, sender: self)
    }
    
    
}

