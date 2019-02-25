//
//  User.swift
//  SimpsonsCharacterViewer
//
//  Created by Sai Goutham  on 27/01/19.
//  Copyright © 2019 DataQ. All rights reserved.
//

import Foundation

struct User: Codable {
    
    enum CodingKeys: String, CodingKey {
        case text = "Text"
        case icon = "Icon"
    }
    
    var text: String = ""
    var icon: Image
    
}

struct Image: Codable {
    
    enum CodingKeys: String, CodingKey {
        case url = "URL"
    }
    
    var url: String = ""
}

