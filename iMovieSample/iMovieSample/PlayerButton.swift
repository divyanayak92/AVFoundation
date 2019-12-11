//
//  PlayerButton.swift
//  iMovieSample
//
//  Created by Divya Nayak on 11/12/19.
//  Copyright © 2019 Divya Nayak. All rights reserved.
//

import UIKit

class PlayerButton: UIButton {
    
    
    enum PlayerState {
        case play
        case pause
        case unknown // if player is not ready to play
        
        // tap will switch the state of the player
        mutating func tap() {
            switch self {
            case .play: self = .pause
            case .pause: self = .play
            case .unknown: break
            }
        }
        
    }
    
    // set the images based on play/pause states of the player
    var playerState: PlayerState = .unknown {
        didSet {
            switch self.playerState {
            case .pause: pause()
            case .play: play()
            default: break
            }
        }
    }
    
    // set player state to play when only it is ready to play
    override var isEnabled: Bool {
        didSet {
            self.playerState =  self.isEnabled ? .play : .unknown
        }
    }

    func play() { setImage(#imageLiteral(resourceName: "pause"), for: .normal) }
    func pause() { setImage(#imageLiteral(resourceName: "play"), for: .normal) }
}

