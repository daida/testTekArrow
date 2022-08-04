//
//  DrawerFrameExpectationFactory.swift
//  TestTekTests
//
//  Created by Nicolas Bellon on 04/08/2022.
//

import Foundation
import UIKit

struct DrawerFrameExpectationFactory {
    
    private struct DeviceResolution {
        static let iPhone13ProMax = CGRect(x: 0, y: 0, width: 428, height: 926)
    }
    
    static func refFrameForIphone13ProMax() -> (frames: [String: [CGRect]],
                                         screenRect: CGRect) {
        self.frameFor(jsonName: "refIphone13ProMax",
                      rect: DeviceResolution.iPhone13ProMax)
    }
    
    static func ApiFrameForIphone13ProMax() -> (frames: [String: [CGRect]],
                                                screenRect: CGRect) {
        self.frameFor(jsonName: "apiIPhone13ProMax",
                      rect: DeviceResolution.iPhone13ProMax)
    }
    
    static func frameFor(jsonName: String, rect: CGRect) -> (frames: [String: [CGRect]],
                                                             screenRect: CGRect) {
        guard let url = Bundle(for: DrawerTest.self)
            .url(forResource: jsonName, withExtension: "json") else { fatalError("No JSON")}
        guard let data = try? Data(contentsOf: url) else { fatalError("No JSON") }
        
        let destFrames = try? JSONDecoder().decode([String: [CGRect]].self, from: data)
        
        guard let destFrames = destFrames else { fatalError("No JSON")}
        
        return (frames: destFrames, screenRect: rect)
    }
    
}
