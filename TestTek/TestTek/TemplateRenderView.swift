//
//  TemplateRenderView.swift
//  TestTek
//
//  Created by Nicolas Bellon on 02/08/2022.
//

import Foundation
import UIKit
import SwiftUI

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
    
    func drawRect(rect: CGRect, template: TemplateData, padding: Float = 0) {
        var color = UIColor.black
     
        let destRect = self.convertCoordinate(x: template.x,
                                              y: template.y,
                                              width: template.width,
                                              height: template.height,
                                              rect: rect,
                                              anchorH: template.anchorX,
                                              anchorV: template.anchorY)
        
        var paddingRect = destRect
        
        let wPadding = CGFloat(padding) * rect.width
        let hPadding = CGFloat(padding) * CGFloat(rect.height)
        
        
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
            self.drawRect(rect: destRect, template: aChild, padding: template.padding)
        }
        
    }
    
    func convertCoordinate(x:Float,
                           y: Float,
                           width: Float,
                           height: Float,
                           rect: CGRect, anchorH: TemplateAnchorH, anchorV: TemplateAnchorV) -> CGRect {

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
        
        var paddingRect = destRect
        
        let vPadding = CGFloat(padding) * rect.size.height
        let wPadding = CGFloat(padding) * rect.size.width
        
        paddingRect.origin.x += wPadding
        paddingRect.origin.y += vPadding
        paddingRect.size.width -= (wPadding * 2)
        paddingRect.size.height -= (vPadding * 2)
        
        
        color.setFill()
        UIRectFill(paddingRect)
        
        if color == .blue {
            drawSquare(rect: destRect, x: 0, y: 0, width: 1, height: 1, color: .orange, anchorH: .left, anchorV: .bottom, padding: 0.1)
         //   drawSquare(rect: destRect, x: 0.5, y: 0.5, width: 0.8, height: 0.2, color: .red, anchorH: .center, anchorV: .center)
        }
        
        if color == .orange {
            drawSquare(rect: destRect, x: 0.5, y: 0.5, width: 0.8, height: 0.2, color: .green, anchorH: .center, anchorV: .center, padding: 0)
        }
        
        if color == .green {
            drawSquare(rect: destRect, x: 0, y: 0, width: 0.4375, height: 1.0, color: .magenta, anchorH: .right, anchorV: .bottom, padding: 0.1)
            drawSquare(rect: destRect, x: 0, y: 0, width: 0.4375, height: 1.0, color: .red, anchorH: .left, anchorV: .bottom, padding: 0.1)
        }
//
//        if color == .orange {
//            drawSquare(rect: destRect, x: 0.5, y: 0, width: 0.5, height: 0.4, color: .magenta)
//        }
    }
    
    override func draw(_ rect: CGRect) {
        self.drawSquare(rect: rect, x: 0, y: 0.0, width: 1, height: 1, color: .blue, anchorH: .left, anchorV: .bottom, padding: 0)
      
//       self.drawRect(rect: rect, template: self.templateData)
    }
}
