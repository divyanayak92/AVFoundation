//
//  Movie.swift
//  iMovieSample
//
//  Created by Divya Nayak on 11/12/19.
//  Copyright © 2019 Divya Nayak. All rights reserved.
//

import Foundation
import AVFoundation

class Movie {
    
    var asset: AVAsset
    var videoPath: URL
    
    init(withURL url: URL) {
        self.videoPath = url
        self.asset = AVURLAsset(url: url)
    }
}
