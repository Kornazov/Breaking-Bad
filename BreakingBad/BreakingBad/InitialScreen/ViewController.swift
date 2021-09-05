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

        setupNavigationBar()
        setupSearchBar()
        setupTableView()

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
    
    private func setupNavigationBar() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 35))
        let imageView = UIImageView(frame: CGRect(x: 4, y: 10, width: 16, height: 16))
        
        if let imgBackArrow = UIImage(named: "filter") {
            imageView.image = imgBackArrow
        }
        view.addSubview(imageView)
       // let backTap = UITapGestureRecognizer(target: self, action: #selector(nil))
        //view.addGestureRecognizer(backTap)
        let leftBarButtonItem = UIBarButtonItem(customView: view)
        self.navigationController?.navigationBar.backgroundColor = .green
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = viewModel.filterCharacters?[indexPath.item]
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        secondViewController.character = character
        self.navigationController?.pushViewController(secondViewController, animated: true)
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
