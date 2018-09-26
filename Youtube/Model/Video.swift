//
//  Video.swift
//  Youtube
//
//  Created by Jair Moreno Gaspar on 28/08/18.
//  Copyright © 2018 Jair Moreno Gaspar. All rights reserved.
//

import UIKit

struct Video: Decodable {
    var thumbnail_image_name: String?
    var title: String?
    var number_of_views: Int?
    var uploadDate: Date?
    var duration: Int?
    var channel: Channel?
}


struct Channel: Decodable {
    var name: String?
    var profile_image_name: String?
    
}
