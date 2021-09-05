//
//  CharactersTableViewCell.swift
//  BreakingBad
//
//  Created by Kristiyan Kornazov on 5.09.21.
//

import UIKit

class CharactersTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var characterImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
        // Initialization code
    }
    
    private func setupCell() {
        self.layer.cornerRadius = 10.0
    }
    
    func configureUI(with character: CharactersResponse?) {
        nameLabel.text = character?.name ?? "No name"
        characterImage.downloaded(from: character?.img ?? "")
    }
}
