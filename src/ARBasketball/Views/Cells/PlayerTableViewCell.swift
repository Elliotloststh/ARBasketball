//
//  PlayerTableViewCell.swift
//  ARBasketball
//
//  Created by Jack on 15/06/2019.
//  Copyright © 2019年 Jack. All rights reserved.
//

import UIKit

protocol PlayerTableViewCellDelegate: AnyObject {
    func cell(_ cell: PlayerTableViewCell, didRemovePlayer player: Player)
}

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var playerNameField: UITextField!
    @IBOutlet weak var removePlayerButton: UIButton!
    
    weak var delegate: PlayerTableViewCellDelegate?
    
    weak var player: Player? {
        didSet {
            playerNameField.text = player?.name
        }
    }
    
    override func awakeFromNib() {
        playerNameField.delegate = self
    }
    
    @IBAction func removePlayerButtonTapped() {
        guard let player = player else { return }
        delegate?.cell(self, didRemovePlayer: player)
    }
}

extension PlayerTableViewCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text ?? ""
        guard let stringRange = Range(range, in: text) else { return false }
        let newText = text.replacingCharacters(in: stringRange, with: string)
        return newText.count <= Constants.Player.nameMaxLength
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        player?.name = textField.text ?? ""
    }
}
