//
//  ViewController.swift
//  iMovieSample
//
//  Created by Divya Nayak on 11/12/19.
//  Copyright © 2019 Divya Nayak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var playerButton: PlayerButton!
    @IBOutlet weak var playerView: MoviePlayerView!
    var activity: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.url(forResource: "spring", withExtension: ".mov")
        playerView.movie = Movie(withURL: path!)
        showActivity()
        playerButton.isEnabled = false
        playerView.playerDidBecomeReady = { [weak self] () -> () in
            self?.playerView.playerStateChanged()
            self?.showActivity()
            self?.playerButton?.isEnabled = true
        }
    }
    
    @IBAction func didTapPlayerButton(_ sender: Any) {
        playerButton.playerState.tap()
        playerView.playerStateChanged()
    }
    
}

private extension ViewController {
    
    func showActivity() {
        view.addSubview(playerView)
        activity.frame = playerView.frame
        activity.startAnimating()
    }
    
    func hideActivity() {
        activity.stopAnimating()
        activity.removeFromSuperview()
    }
}
