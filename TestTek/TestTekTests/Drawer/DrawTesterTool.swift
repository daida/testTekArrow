//
//  DrawTesterTool.swift
//  TestTekTests
//
//  Created by Nicolas Bellon on 04/08/2022.
//

import Foundation
import UIKit

@testable import TestTek

struct DrawTesterTool {
    
   static func computeFrame(data: TemplateDataInterface, rect: CGRect, destRects: inout [CGRect]) {
        
        let dest = Drawer.convertCoordinate(x: data.x,
                                            y: data.y,
                                            width: data.width,
                                            height: data.height,
                                            rect: rect,
                                            anchorH: data.anchorX,
                                            anchorV: data.anchorY)
        destRects.append(dest)
        
        for child in data.children {
            self.computeFrame(data: child, rect: dest, destRects: &destRects)
        }
    }
    
   static func computeFrame(templates: [TemplateInterface], rect: CGRect) -> [String: [CGRect]] {
        
        var dest = [String : [CGRect]]()
        
        for aTemplate in templates {
            var frames = [CGRect]()
            computeFrame(data: aTemplate.data, rect: rect, destRects: &frames)
            dest[aTemplate.name] = frames
        }
        return dest
    }
    
    static func prettyPrint(frames: [String : [CGRect]]) {

        guard let data = try? JSONEncoder().encode(frames),
              let destStr = String(data: data, encoding: .utf8) else { return }
       print(destStr)
    }
}
