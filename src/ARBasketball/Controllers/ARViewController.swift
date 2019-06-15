//
//  ARViewController.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 28/02/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import UIKit
import ARKit
import AVFoundation

class ARViewController: BaseViewController {

    @IBOutlet var sceneView: ARSCNView!
    
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        Game.instance.setup(sceneView: sceneView)
        Thread.sleep(forTimeInterval: 3.0) //延长3秒
        playBgMusic()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Game.instance.resume()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Game.instance.pause()
    }
    
    func playBgMusic(){
        let session = AVAudioSession.sharedInstance()
        do{
            try session.setActive(true)
            try session.setCategory(AVAudioSessionCategoryPlayback)
            UIApplication.shared.beginReceivingRemoteControlEvents()
            let path = Bundle.main.path(forResource: "bgm2", ofType: "mp3")
            let soudUrl = URL(fileURLWithPath: path!)
            try audioPlayer = AVAudioPlayer(contentsOf: soudUrl)
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 1.0
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
        } catch{
            print(error)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        performSegue(withIdentifier: "ShowTitle", sender: self)
//        performSegue(withIdentifier: "ScoreboardDemo", sender: self)
    }
    
   

}

extension ARViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        Game.instance.update(at: time)
    }
}
