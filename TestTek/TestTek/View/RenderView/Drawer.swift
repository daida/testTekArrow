//
//  Drawer.swift
//  TestTek
//
//  Created by Nicolas Bellon on 03/08/2022.
//

import Foundation
import UIKit

class Drawer: DrawerInterface {
    
    // MARK: Public methods
    
    // Main draw method should be called from UIView draw rect
    static func drawRect(rect: CGRect, template: TemplateDataInterface) {
        var color = UIColor.black
     
        let destRect = self.convertCoordinate(x: template.x,
                                              y: template.y,
                                              width: template.width,
                                              height: template.height,
                                              rect: rect,
                                              anchorH: template.anchorX,
                                              anchorV: template.anchorY)
                
        if let colorStr = template.backgroundColor {
            color = UIColor(hexaString: colorStr)
        }
        
        if template.media != nil {
            Drawer.handleImageDrawingIfNeeded(template: template, destRect: destRect)
        } else {
            color.setFill()
            UIRectFill(destRect)
        }
        
        // Each child will be draw by recursive call of this method with the parent RECT
        for aChild in template.children {
            self.drawRect(rect: destRect, template: aChild)
        }
        
        // The padding is draw line by line on top of the childrens
        Drawer.drawPading(rect: destRect,
                        pading: template.padding,
                        paddingTop: template.paddingTop,
                        paddingBottom: template.paddingBottom,
                        paddingLeft: template.paddingRight,
                        paddingRight: template.paddingRight, color: color)

    }
    
    // Debug method usefull to test rectangle frames
    static func drawSquare(rect: CGRect,
                    x: Float,
                    y: Float,
                    width: Float,
                    height: Float,
                    color: UIColor, anchorH: TemplateAnchorH, anchorV: TemplateAnchorV, padding: Float = 0) {
        

        let destRect = Drawer.convertCoordinate(x: x,
                                              y: y,
                                              width: width,
                                              height: height,
                                              rect: rect,
                                              anchorH: anchorH,
                                              anchorV: anchorV)
        
       
        
        color.setFill()
        UIRectFill(destRect)
    }
    
    // MARK: Private methods
    
    // MOST IMPORTANT METHOD !!!!
    // Compute size and position by using x, y, width, height and anchorH and V (the hardest part !!)
    static func convertCoordinate(x:Float,
                           y: Float,
                           width: Float,
                           height: Float,
                           rect: CGRect,
                           anchorH: TemplateAnchorH,
                           anchorV: TemplateAnchorV) -> CGRect {

        let destWidth = CGFloat(width) * rect.width
        let destHeight = CGFloat(height) * rect.height

        var destX: CGFloat
        let destY: CGFloat
        
        switch anchorH {
        case .left:
            destX = (CGFloat(x) * rect.width) + rect.minX
        case .center:
            destX =  rect.minX - (destWidth / 2.0) + (CGFloat(x) * rect.size.width)
        case .right:
            destX = (rect.minX - destWidth) + (CGFloat(x) * rect.size.width)
        }
        
        switch anchorV {
        case .top:
            destY = (rect.maxY) - (CGFloat(y) * rect.size.height)
        case .center:
            destY =  rect.maxY - (destHeight / 2.0) - (CGFloat(y) * rect.size.height)
        case .bottom:
            destY = rect.maxY - destHeight - (CGFloat(y) * rect.size.height)
        }
        
        let destRect = CGRect(x: destX,
                              y: destY,
                              width: destWidth,
                              height: destHeight)
        return destRect
    }
    
    // Draw one line with start and endPoint
    // usefull for padding
    static func drawLine(start: CGPoint, end: CGPoint, color: UIColor, lineSize: CGFloat) {
        
//        if let context = UIGraphicsGetCurrentContext() {
//                context.setLineCap(.square)
//                context.setLineWidth(lineSize)
//                color.set()
//                context.move(to: start)
//                context.addLine(to: end )
//                context.strokePath()
//        }
        
        var crop: CGRect
        
        color.setFill()
    
        
        if end.x > start.x {
            crop = CGRect(x: start.x, y: start.y, width: (end.x - start.x), height: lineSize)
            UIRectFill(crop)
        } else if end.x < start.x {
            crop = CGRect(x: end.x, y: end.y, width: (start.x - end.x), height: lineSize)
            UIRectFill(crop)
        } else if end.y > start.y {
            crop = CGRect(x: start.x, y: start.y, width: lineSize, height: (end.y - start.y))
            UIRectFill(crop)
        } else if end.y < start.y {
            crop = CGRect(x: end.x, y: end.y, width: lineSize, height: (start.y - end.y))
            UIRectFill(crop)
        }
        

    }
    
    // Draw a padding rectangle
    static func drawPading(rect: CGRect, pading: Float,
                    paddingTop:Float? = nil,
                    paddingBottom: Float? = nil,
                    paddingLeft: Float? = nil,
                    paddingRight: Float? = nil,
                    color: UIColor = .black) {
      
        

        // Width
        
        let lineSizeWidth = CGFloat(pading) * rect.size.width
        
    
        if let paddingTop = paddingTop {
            drawLine(start: CGPoint(x: rect.minX , y: rect.minY), end: CGPoint(x: rect.maxX + lineSizeWidth, y: rect.minY), color: color, lineSize: CGFloat(paddingTop) * rect.size.width)
        } else {
            drawLine(start: CGPoint(x: rect.minX , y: rect.minY), end: CGPoint(x: rect.maxX + lineSizeWidth, y: rect.minY), color: color, lineSize: lineSizeWidth)
        }
        
        if let paddingBottom = paddingBottom {
            drawLine(start: CGPoint(x: rect.minX, y: rect.maxY - lineSizeWidth), end: CGPoint(x: rect.maxX, y: rect.maxY), color: color, lineSize: CGFloat(paddingBottom) * lineSizeWidth)
        } else {
            drawLine(start: CGPoint(x: rect.minX, y: rect.maxY - lineSizeWidth), end: CGPoint(x: rect.maxX, y: rect.maxY), color: color, lineSize: lineSizeWidth)
        }

        
        // height
        
        let lineSizeHeight = CGFloat(pading) * rect.size.height
        
        if let paddingLeft = paddingLeft {
            drawLine(start: CGPoint(x: rect.minX, y: rect.minY), end: CGPoint(x: rect.minX, y: rect.maxY), color: color, lineSize: CGFloat(paddingLeft) * lineSizeHeight)
        } else {
            drawLine(start: CGPoint(x: rect.minX, y: rect.minY), end: CGPoint(x: rect.minX, y: rect.maxY), color: color, lineSize: lineSizeHeight)
        }
        
//        drawLine(start: CGPoint(x: rect.minX, y: rect.minY), end: CGPoint(x: rect.minX, y: rect.maxY), color: color, lineSize: lineSizeHeight)
        
        if let paddingRight = paddingRight {
            drawLine(start: CGPoint(x: rect.maxX - lineSizeHeight, y: rect.minY),
                     end: CGPoint(x: rect.maxX - lineSizeHeight, y: rect.maxY), color: color, lineSize: CGFloat(paddingRight) * rect.size.height)
        } else {
            drawLine(start: CGPoint(x: rect.maxX - lineSizeHeight, y: rect.minY),
                     end: CGPoint(x: rect.maxX - lineSizeHeight, y: rect.maxY), color: color, lineSize: lineSizeHeight)
        }
    
    }
    
    // Draw the template image it there is some
    private static func handleImageDrawingIfNeeded(template: TemplateDataInterface, destRect: CGRect) {
        if let imageStr = template.media,
           let image = UIImage(named: imageStr) {
            let scaledImage: UIImage
            if let contentMode = template.mediaContentMode {
                switch contentMode {
                case .fit:
                    scaledImage = image.scaled(to: destRect.size, scalingMode: .aspectFit)
                case .fill:
                    scaledImage = image.scaled(to: destRect.size, scalingMode: .aspectFill)
                }
            } else {
                scaledImage = image.scaled(to: destRect.size, scalingMode: .aspectFit)
            }
            scaledImage.draw(in: destRect)
        }
    }
    
}

// MARK: Protocol

protocol DrawerInterface {
    static func drawRect(rect: CGRect, template: TemplateDataInterface)

    static func drawSquare(rect: CGRect,
                    x: Float,
                    y: Float,
                    width: Float,
                    height: Float,
                    color: UIColor,
                           anchorH: TemplateAnchorH,
                           anchorV: TemplateAnchorV,
                           padding: Float)
}
