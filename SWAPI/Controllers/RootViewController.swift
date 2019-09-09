//
//  RootViewController.swift
//  SWAPI
//
//  Created by Joseph Ugowe on 9/3/19.
//  Copyright © 2019 Joseph Ugowe. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var rootResourceTableView: UITableView!
    
    // MARK: - Properties
    
    var selectedResourceCategory: RootResource?
    var rootResourceArray: [RootResource] = [] {
        didSet {
            DispatchQueue.main.async {
                self.rootResourceTableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupTableView()
    }
    
    // MARK: - Methods
    
    private func setupNavigationBar() {
        self.navigationItem.title = "STAR WARS API"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupTableView() {
        self.rootResourceTableView.delegate = self
        self.rootResourceTableView.dataSource = self
        
        let nib = UINib(nibName: RootResourceTableViewCell.nibName, bundle: nil)
        self.rootResourceTableView.register(nib, forCellReuseIdentifier: RootResourceTableViewCell.reuseIdentifier)
        
        DispatchQueue.main.async {
            APIClient.shared.decodeRootResources(completion: { (result) in
                switch result {
                case .success(let rootResources):
                    self.rootResourceArray = rootResources
                case .failure(let error):
                    print(APIError.requestFailed(description: error.customDescription))
                }
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let categoryVC = segue.destination as? CategoryViewController {
            categoryVC.resourceCategory = self.selectedResourceCategory
        }
    }
}

// MARK: TableView DataSource & Delegate Methods

extension RootViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rootResourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RootResourceTableViewCell.reuseIdentifier, for: indexPath) as! RootResourceTableViewCell
        
        let rootResource = rootResourceArray[indexPath.row]
        cell.resourceTitleLabel.text = rootResource.resourceName.capitalized
        cell.resourceImageView.image = UIImage(named: rootResource.resourceName)
        cell.selectionStyle = .none
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rootResource = rootResourceArray[indexPath.row]
        self.selectedResourceCategory = rootResource
        performSegue(withIdentifier: Constants.Segue.categoryVCSegue, sender: self)
    }

}
