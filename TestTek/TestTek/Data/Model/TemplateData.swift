//
//  TemplateData.swift
//  TestTek
//
//  Created by Nicolas Bellon on 02/08/2022.
//

import Foundation

struct TemplateData: Codable {
    
    private static func isOutOfBound(_ toCheck: Float) -> Bool {
        if toCheck < 0 || toCheck > 1 { return true }
        return false
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.width = try container.decode(Float.self, forKey: .width)
        self.height = try container.decode(Float.self, forKey: .height)
        
        
        // If a properties is out ouf bound and has no default value was specified
        // an error is throwed
        if TemplateData.isOutOfBound(self.width) == true {
            throw TemplateSerializationError.outOfBounds
        }
        
        if TemplateData.isOutOfBound(self.height) {
            throw TemplateSerializationError.outOfBounds
        }

        // Here we handle default value
        
        if container.contains(.backgroundColor) == true {
            self.backgroundColor = try container.decode(String.self, forKey: .backgroundColor)
        } else {
            self.backgroundColor = nil
        }
        
        // If the background color string exist BUT is not a hex string
        // an error is throwed
        if let back = self.backgroundColor, back.isHex == false {
            throw TemplateSerializationError.wrongStringFormat
        }
        
        let tempPadding: Float
        
        if container.contains(.padding) == true {
            tempPadding = try container.decode(Float.self, forKey: .padding)
        } else {
            tempPadding = 0
        }
        
        if TemplateData.isOutOfBound(tempPadding) {
            self.padding = 0
        } else {
            self.padding = tempPadding
        }
        
        let tempX: Float
        
        if container.contains(.x) == true {
            tempX = try container.decode(Float.self, forKey: .x)
        } else {
            tempX = 0
        }
        
        if TemplateData.isOutOfBound(tempX) == true {
            self.x = 0
        } else {
            self.x = tempX
        }
        
        let tempY: Float
        
        if container.contains(.y) == true {
            tempY = try container.decode(Float.self, forKey: .y)
        } else {
            tempY = 0
        }
        
        if TemplateData.isOutOfBound(tempY) == true {
            self.y = 0
        } else {
            self.y = tempY
        }
                
        if container.contains(.media) == true {
            self.media = try container.decode(String.self, forKey: .media)
        } else {
            self.media = nil
        }
      
        if container.contains(.anchorX) {
            self.anchorX = TemplateAnchorH(str: try container.decode(String.self, forKey: .anchorX))
        } else {
            self.anchorX = TemplateAnchorH()
        }

        if container.contains(.anchorY) {
            self.anchorY = TemplateAnchorV(str: try container.decode(String.self, forKey: .anchorY))
        } else {
            self.anchorY = TemplateAnchorV()
        }

        if container.contains(.mediaContentMode) {
            self.mediaContentMode = TemplateMediaContentMode(str: try container.decode(String.self, forKey: .mediaContentMode))
        } else {
            self.mediaContentMode = nil
        }
        
        if container.contains(.children) == true {
            self.children = try container.decode([TemplateData].self, forKey: .children)
        } else {
            self.children = []
        }
        
        if container.contains(.paddingTop) == true {
            self.paddingTop = try container.decode(Float.self, forKey: .paddingTop)
        } else {
            self.paddingTop = nil
        }
        
        if container.contains(.paddingLeft) == true {
            self.paddingLeft = try container.decode(Float.self, forKey: .paddingLeft)
        } else {
            self.paddingLeft = nil
        }
        
        if container.contains(.paddingRight) == true {
            self.paddingRight = try container.decode(Float.self, forKey: .paddingRight)
        } else {
            self.paddingRight = nil
        }
        
        if container.contains(.paddingBottom) == true {
            self.paddingBottom = try container.decode(Float.self, forKey: .paddingBottom)
        } else {
            self.paddingBottom = nil
        }
    }
    
    func encode(to encoder: Encoder) throws {
       var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.x, forKey: .x)
        try container.encode(self.y, forKey: .y)
        
        try container.encode(self.width, forKey: .width)
        try container.encode(self.height, forKey: .height)
        
        try container.encode(self.padding, forKey: .padding)
        try container.encode(self.backgroundColor, forKey: .backgroundColor)
        
        try container.encode(self.anchorX.rawValue, forKey: .anchorX)
        try container.encode(self.anchorY.rawValue, forKey: .anchorY)
        
        try container.encode(self.media, forKey: .media)
        try container.encode(self.children, forKey: .children)
        
        try container.encode(self.mediaContentMode?.rawValue, forKey: .mediaContentMode)
        
        try container.encode(self.paddingBottom, forKey: .paddingBottom)
        try container.encode(self.paddingLeft, forKey: .paddingLeft)
        try container.encode(self.paddingRight, forKey: .paddingRight)
        try container.encode(self.paddingTop, forKey: .paddingTop)
    }
    
    // MARK: CodingKeys
    private enum CodingKeys : String, CodingKey {
        case x
        case y
        case width
        case height
        case padding
        case backgroundColor = "background_color"
        case children
        case anchorX = "anchor_x"
        case anchorY = "anchor_y"
        case media
        case mediaContentMode = "media_content_mode"
        
        case paddingLeft = "padding_left"
        case paddingRight = "padding_right"
        case paddingBottom = "padding_bottom"
        case paddingTop = "padding_top"
    }
    
    
    let x: Float
    let y: Float
    let width: Float
    let height: Float
    
    let padding: Float
    let paddingLeft: Float?
    let paddingRight: Float?
    let paddingTop: Float?
    let paddingBottom: Float?
    
    var children: [TemplateData]

    var anchorX: TemplateAnchorH
    var anchorY: TemplateAnchorV
    
 
    let backgroundColor: String?
    var media: String?
    var mediaContentMode: TemplateMediaContentMode?
}

enum TemplateSerializationError: Error {
    case outOfBounds
    case wrongStringFormat
}
