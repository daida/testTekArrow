//
//  TemplateRenderView.swift
//  TestTek
//
//  Created by Nicolas Bellon on 02/08/2022.
//

import Foundation
import UIKit
import SwiftUI
import CoreGraphics

struct TemplateRenderViewBridge: UIViewRepresentable {
    var data: TemplateData

    func makeUIView(context: Context) -> TemplateRenderView {
        TemplateRenderView(templateData: data)
    }

    func updateUIView(_ uiView: TemplateRenderView, context: Context) {
        uiView.templateData = data
    }
}


class TemplateRenderView: UIView {
    
    var templateData: TemplateData {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    init(templateData: TemplateData) {
        self.templateData = templateData
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func handleImageDrawingIfNeeded(template: TemplateData, destRect: CGRect) {
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
    
    func drawRect(rect: CGRect, template: TemplateData) {
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
            self.handleImageDrawingIfNeeded(template: template, destRect: destRect)
        } else {
            color.setFill()
            UIRectFill(destRect)
        }
        
        for aChild in template.children {
            self.drawRect(rect: destRect, template: aChild)
        }
        
        self.dramPading(rect: destRect, pading: template.padding, color: color)

    }
    
    func convertCoordinate(x:Float,
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
            destX = (rect.maxX - destWidth) - (CGFloat(x) * rect.size.width)
            destX = abs(destX)
        }
        
        switch anchorV {
        case .top:
            destY = (CGFloat(y) * rect.height) + rect.minY
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
    
    func drawSquare(rect: CGRect,
                    x: Float,
                    y: Float,
                    width: Float,
                    height: Float,
                    color: UIColor, anchorH: TemplateAnchorH, anchorV: TemplateAnchorV, padding: Float = 0) {
        

        let destRect = self.convertCoordinate(x: x,
                                              y: y,
                                              width: width,
                                              height: height,
                                              rect: rect,
                                              anchorH: anchorH,
                                              anchorV: anchorV)
        
       
        
        color.setFill()
        UIRectFill(destRect)
        
        if color == .blue {
            self.dramPading(rect: destRect, pading: 0.2, color: .red)
            self.drawSquare(rect: destRect, x: 0.5, y: 0.5, width: 0.5, height: 0.5, color: .green, anchorH: .center, anchorV: .center)
        }
        
        if color == .green {
            self.drawSquare(rect: destRect, x: 0.5, y: 0.5, width: 0.5, height: 0.5, color: .yellow, anchorH: .center, anchorV: .center)
            self.dramPading(rect: destRect, pading: 0.1, color: .orange)
        }
        
 

    }
    
    func drawHairline(in context: CGContext, scale: CGFloat, color: CGColor, point1: CGPoint, point2: CGPoint) {

        // pick which row/column of pixels to treat as the "center" of a point
        // through which to draw lines -- favor true center for odd scales, or
        // offset to the side for even scales so we fall on pixel boundaries
        let center: CGFloat
        if Int(scale) % 2 == 0 {
            center = 1 / (scale * 2)
        } else {
            center = 0
        }

        let offset = 0.5 - center // use the "center" choice to create an offset
        let p1 = CGPoint(x: 50 + offset, y: 50 + offset)
        let p2 = CGPoint(x: 50 + offset, y: 75 + offset)

        // draw line of minimal stroke width
        let width = 1 / scale
        context.setLineWidth(width)
        context.setStrokeColor(color)
        context.beginPath()
        context.move(to: p1)
        context.addLine(to: p2)
        context.strokePath()
    }
    
    func dramPading(rect: CGRect, pading: Float, color: UIColor = .black) {
      
        if let context = UIGraphicsGetCurrentContext() {
            color.set()
            
            let vPadding = (rect.size.height * (CGFloat(pading)))
            let hPadding = rect.size.width * (CGFloat(pading))
            
            context.setLineWidth(vPadding)
            context.setLineCap(.square)

            // Vertical padding
            
            context.move(to: CGPoint(x: rect.minX, y: rect.minY))
            context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            
            context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            
            // Horizontal padding

            context.setLineWidth(hPadding)
            
            context.move(to: CGPoint(x: rect.minX, y: rect.minY))
            context.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            
            context.move(to: CGPoint(x: rect.maxX, y: rect.minY))
            context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            
            
            context.strokePath()
          }
    }
    
    override func draw(_ rect: CGRect) {
//        self.drawSquare(rect: rect, x: 0, y: 0.0, width: 1, height: 1, color: .blue, anchorH: .left, anchorV: .bottom, padding: 0.5)
      
       self.drawRect(rect: rect, template: self.templateData)
     //   self.drawAllPaddings(template: templateData, rect: rect)
        
       // self.dramPading(rect: rect, pading: 0.3)
        
    }
}
