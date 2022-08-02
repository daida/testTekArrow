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
    
    func drawRect(rect: CGRect, template: TemplateData) {
        var color = UIColor.black
        
        let width = CGFloat(templateData.width) * rect.size.width
        let height = CGFloat(templateData.height) * rect.size.height
        
        let x: CGFloat
        let y: CGFloat
        
        switch template.anchorX {
        case .left:
            x = rect.minX + CGFloat(templateData.x) * rect.size.width
            y = rect.minY - CGFloat(templateData.y) * rect.size.height
        case .right:
            x = width - (rect.minX + (CGFloat(templateData.x) * rect.size.width))
            y = height - (rect.minY + (CGFloat(templateData.y) * rect.size.height))
        case .center:
            x = (width / 2.0) + ((CGFloat(templateData.x) * rect.size.width))
            y = (height / 2.0) - ((CGFloat(templateData.y) * rect.size.width))
        }
        
        let paddingWidth = CGFloat(templateData.padding) * width
        let paddingHeight = CGFloat(templateData.padding) * height
        
        let destRect = CGRect(x: x + paddingWidth,
                              y: y + paddingHeight,
                              width: width - (paddingWidth * 2),
                              height: height - (paddingHeight * 2))
        
        
        if let colorStr = template.backgroundColor {
            color = UIColor(hexaString: colorStr)
        }
        
        color.setFill()
        
        
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
        } else {            
            UIRectFill(destRect)
        }
        
        for aChild in template.children {
            self.drawRect(rect: destRect, template: aChild)
        }
        
    }
    
    override func draw(_ rect: CGRect) {
        self.drawRect(rect: rect, template: self.templateData)
    }
}
