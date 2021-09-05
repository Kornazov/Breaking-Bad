//
//  ViewController.swift
//  BreakingBad
//
//  Created by Kristiyan Kornazov on 5.09.21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    private var viewModel = CharactersViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.loadData()
        
        setupSearchBar()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.searchTextField.backgroundColor = .white
    }
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(cellType: CharactersTableViewCell.self)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filterCharacters?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 325
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let characterCell = tableView.dequeueReusableCell(with: CharactersTableViewCell.self, for: indexPath) else {
            return UITableViewCell()
        }
        
        let index = indexPath.item
        let character = viewModel.filterCharacters?[index]
        characterCell.configureUI(with: character)
        return characterCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let verticalPadding: CGFloat = 20
        
        let maskLayer = CALayer()
        maskLayer.cornerRadius = 10
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
    
}

extension ViewController: CharactersViewModelDelegate {
    func reloadData() {
        self.tableView.reloadData()
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterData(by: searchText.lowercased())
    }
}
