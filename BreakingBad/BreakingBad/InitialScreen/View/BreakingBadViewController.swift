//
//  ViewController.swift
//  BreakingBad
//
//  Created by Kristiyan Kornazov on 5.09.21.
//

import UIKit

class BreakingBadViewController: UIViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    private var toolBar = UIToolbar()
    private var pickerView  = UIPickerView()
    private var viewModel = CharactersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.loadData()
        
        setupNavigationBar()
        setupSearchBar()
        setupTableView()
    }
}

private extension BreakingBadViewController {
    
    @objc func showPickerView() {
        hidePickerView()
        self.pickerView = UIPickerView(frame: CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 150, width: UIScreen.main.bounds.size.width, height: 150))
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.pickerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.9)
        self.view.addSubview(pickerView)
        
        toolBar = UIToolbar(frame: CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 150, width: UIScreen.main.bounds.size.width, height: 30))
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(hidePickerView))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let allCharactersButton = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(showAllCharacters))
        toolBar.setItems([allCharactersButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        self.view.addSubview(toolBar)
    }
    
    @objc func showAllCharacters() {
        viewModel.showAllCharacters()
        hidePickerView()
    }
    
    @objc func hidePickerView() {
        toolBar.removeFromSuperview()
        pickerView.removeFromSuperview()
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
        let backTap = UITapGestureRecognizer(target: self, action: #selector(showPickerView))
        view.addGestureRecognizer(backTap)
        let leftBarButtonItem = UIBarButtonItem(customView: view)
        
        self.navigationController?.navigationBar.backgroundColor = .green
        self.navigationItem.rightBarButtonItem = leftBarButtonItem
    }
}

extension BreakingBadViewController: UITableViewDelegate, UITableViewDataSource {
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

extension BreakingBadViewController: CharactersViewModelDelegate {
    func reloadData() {
        self.tableView.reloadData()
    }
}

extension BreakingBadViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            viewModel.searchString = nil
            return
        }
        
        viewModel.searchString = searchText.lowercased()
    }
}

extension BreakingBadViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.seasons.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.seasons[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.numberForSeason = row + 1
    }
}
