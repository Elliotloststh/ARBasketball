//
//  PlayerSelectionViewController.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 02/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import UIKit

class PlayerSelectionStateController: GameStateController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    private var scoreboard: Scoreboard { return game.scoreboard }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateButtons()
        setupTapGesture()
        tableView.isEditing = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        dismissKeyboard()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        scoreboard.players.append(Player())
        updateButtons()
        tableView.reloadData()
    }
    
    private func setupTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tableView.addGestureRecognizer(tap)
    }
    
    private func updateButtons() {
        let numberOfPlayers = scoreboard.players.count
        addButton.isHidden = numberOfPlayers >= Constants.Game.maxPlayers
        
        let namedPlayers = scoreboard.players.filter { !$0.name.isEmpty }.count
        startButton.isEnabled = numberOfPlayers == namedPlayers && namedPlayers > 0
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
        updateButtons()
    }
    
    @IBAction func backToPlayerSelection(unwindSegue: UIStoryboardSegue) {}
}

extension PlayerSelectionStateController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreboard.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell") as? PlayerTableViewCell else {
            fatalError("dequeueReusableCell error")
        }

        cell.delegate = self
        cell.player = scoreboard.players[indexPath.row]
        
        return cell
    }
}

extension PlayerSelectionStateController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let player = scoreboard.players.remove(at: sourceIndexPath.row)
        scoreboard.players.insert(player, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}


extension PlayerSelectionStateController: PlayerTableViewCellDelegate {
    
    func cell(_ cell: PlayerTableViewCell, didRemovePlayer player: Player) {
        scoreboard.players = scoreboard.players.filter { $0 !== player }
        updateButtons()
        tableView.reloadData()
    }
}
