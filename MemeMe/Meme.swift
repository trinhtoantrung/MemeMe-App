//
//  Meme.swift
//  MemeMe
//
//  Created by  Trung Trinh on 9/9/15.
//  Copyright (c) 2015 Trung Trinh. All rights reserved.
//

import Foundation
import UIKit

class Meme {
    var topString:String?
    var bottomString: String?
    var originImage: UIImage!
    var memeImage: UIImage!
    
    init(memeImage: UIImage, originImage: UIImage, topString: String, bottomString: String){
        self.memeImage = memeImage
        self.originImage = originImage
        self.topString = topString
        self.bottomString = bottomString
    }
}
