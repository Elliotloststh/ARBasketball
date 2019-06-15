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
    
    weak var previousState: GameState!
    var isGameOver: Bool!
    var defaults: UserDefaults = .standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        nextButton.isHidden = isGameOver
        if isGameOver {
            updateHighscores()
        }
    }
    
    private func updateHighscores() {
        guard var highscores = defaults.array(forKey: Constants.UserDefaults.keyForHighscores) as? [[String : Int]] else { return }
        for player in game.scoreboard.players {
            highscores.append([player.name: player.score])
        }
        
        highscores = highscores.sorted(by: { a, b -> Bool in
            return a.first!.value > b.first!.value
        })
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        dismiss(animated: true) {
            self.game.state = self.previousState
        }
    }
    
    @IBAction func resetTapped(_ sender: Any) {
        // todo: 回到顶部
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
