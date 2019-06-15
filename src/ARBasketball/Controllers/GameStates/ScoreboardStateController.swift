//
//  GameResultsStateController.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 02/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import UIKit

class ScoreboardStateController: GameStateController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var winnerNamesLabel: UILabel!
    @IBOutlet weak var winnerMsgView: UIView!
    
    weak var previousState: GameState!
    var isGameOver: Bool!
    var defaults: UserDefaults = .standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        nextButton.isHidden = isGameOver
        resetButton.isHidden = !isGameOver
        winnerMsgView.isHidden = !isGameOver
        
        if isGameOver {
            winnerMsg()
        }
    }
    
    
    @IBAction func nextTapped(_ sender: Any) {
        dismiss(animated: true) {
            self.game.state = self.previousState
        }
    }
    
    func winnerMsg() {
        //TODO 显示胜者名字
        let num = game.scoreboard.players.count
        var name: [String] = []
        var maxScore = game.scoreboard.players[0].score
        for i in 0...num-1 {
            if game.scoreboard.players[i].score > maxScore {
                name.removeAll()
                name.append(game.scoreboard.players[i].name)
                maxScore = game.scoreboard.players[i].score
            } else if game.scoreboard.players[i].score == maxScore {
                name.append(game.scoreboard.players[i].name)
            }
        }
        
        var msg: String = ""
        for item in name {
            msg.append(item+" ")
        }
        winnerNamesLabel.text = msg
    }

}

extension ScoreboardStateController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return game.scoreboard.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreboardTableViewCell") as? ScoreboardTableViewCell else {
            fatalError("dequeueReusableCell error")
        }
        
        cell.playerIndex = indexPath.row
        
        return cell
    }
    
}
