//
//  TemplateAnchor.swift
//  TestTek
//
//  Created by Nicolas Bellon on 02/08/2022.
//

import Foundation

enum TemplateAnchorH: String {
    case left
    case center
    case right
    
    init() {
        self = .left
    }
    
    init(str: String?) {
        switch str {
        case "left": self = .left
        case "center": self = .center
        case "right": self = .right
        default:
            self = .left
        }
    }
}

enum TemplateAnchorV: String {
    
    case bottom
    case center
    case top
    
    init() {
        self = .top
    }
    
    init(str: String?) {
        switch str {
        case "bottom": self = .bottom
        case "center": self = .center
        case "top": self = .top
        default:
            self = .top
        }
    }
}
