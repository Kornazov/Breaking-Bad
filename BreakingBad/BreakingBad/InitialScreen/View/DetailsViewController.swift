//
//  DetailsViewController.swift
//  BreakingBad
//
//  Created by Kristiyan Kornazov on 6.09.21.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var occupationLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var seasonAppearancesLabel: UILabel!
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBAction private func didTapCloseButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    var character: CharactersResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 35))
        let imageView = UIImageView(frame: CGRect(x: 4, y: 10, width: 16, height: 16))
        
        if let imgBackArrow = UIImage(named: "backArrow") {
            imageView.image = imgBackArrow
        }
        view.addSubview(imageView)
        let backTap = UITapGestureRecognizer(target: self, action: #selector(backToMain))
        view.addGestureRecognizer(backTap)
        let leftBarButtonItem = UIBarButtonItem(customView: view)
        self.navigationController?.navigationBar.backgroundColor = .green
        
        let label = UILabel()
        label.text = character?.name
        self.navigationItem.titleView = label
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @objc func backToMain() {
        self.navigationController?.popViewController(animated: true)
    }
    private func setupUI() {
        guard let character = character else {
            return
        }
        
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
        imageView.downloaded(from: character.img ?? "")
        let occupation = character.occupation?.joined(separator: ",")
        
        occupationLabel.text = "Occupation: " + (occupation ?? "")
        statusLabel.text = "Status: " + (character.status ?? "")
        nicknameLabel.text = "Nickname: " + (character.nickname ?? "")
        
    }
}
