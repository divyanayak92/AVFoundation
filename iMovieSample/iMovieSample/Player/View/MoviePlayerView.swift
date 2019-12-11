//
//  MoviePlayerView.swift
//  iMovieSample
//
//  Created by Divya Nayak on 11/12/19.
//  Copyright © 2019 Divya Nayak. All rights reserved.
//

import UIKit
import AVFoundation

class MoviePlayerView: UIView {
    
    // callback for player being ready
    var playerDidBecomeReady: (() -> ())?
    
    // asset that is to be played
    var movie: Movie? {
        didSet {
            addPlayer()
        }
    }
    
    // use view's layer as AVPlayerLayer to play the movie
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }

    // player here should be AVPlayerLayer's player
    var player: AVPlayer? {
        get { return playerLayer.player }
        set { playerLayer.player = newValue  }
    }
    
    // let this layers class work as AVPlayerLayer than normal CALayer
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    // observer for keys
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" {
            playerDidBecomeReady?()
        }
    }
    
    func playerStateChanged() {
        if player?.timeControlStatus == .playing {
            pause()
        } else {
            play()
        }
    }
    
    func seek(toSecond seconds: Int) {
        let time = CMTime(seconds: Double(seconds), preferredTimescale: movie!.asset.duration.timescale)
        player?.seek(to: time)
    }
    
}

private extension MoviePlayerView {
    
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
    func addPlayer()  {
        guard let _movie = movie else { return }
        let playerItem = AVPlayerItem(asset: _movie.asset)
        player = AVPlayer(playerItem: playerItem)
        addPlayerObservers(playerItem: playerItem)
    }
    
    func addPlayerObservers(playerItem: AVPlayerItem) {
        playerItem.addObserver(self, forKeyPath: "status", options: [], context: nil)
    }
     
}
