//
//  Video.swift
//  Youtube
//
//  Created by Jair Moreno Gaspar on 28/08/18.
//  Copyright © 2018 Jair Moreno Gaspar. All rights reserved.
//

import UIKit

class Video: NSObject {
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    var channel: Channel?
}


class Channel: NSObject{
    var name: String?
    var profileImageName: String?
    
}
