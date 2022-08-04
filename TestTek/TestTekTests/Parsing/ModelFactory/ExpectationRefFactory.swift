//
//  ExpectationRefFactory.swift
//  TestTekTests
//
//  Created by Nicolas Bellon on 04/08/2022.
//

import Foundation
@testable import TestTek

struct ExpectationRefFactory {
    
    
    static func generateRefExpectationModel() -> [ExpectationTemplate] {
       return [ExpectationTemplate(name: "My first template",
                                   data: self.generateRefDataModel(),
                                   id: UUID())]
    }
    

    private static func generateRefSecoundSubChild() -> ExpectationData {
        return ExpectationData(id: UUID(),
                               x: 1,
                               y: 0,
                               width: 0.4375,
                               height: 1,
                               padding: 0.0,
                               paddingLeft: nil,
                               paddingRight: nil,
                               paddingTop: nil,
                               paddingBottom: nil,
                               children: [],
                               anchorX: .right,
                               anchorY: .bottom,
                               backgroundColor: "#73D3A2",
                               media: nil,
                               mediaContentMode: nil)
    }
    
    private static func generateRefFirstSubChild() -> ExpectationData {
        return ExpectationData(id: UUID(),
                               x: 0,
                               y: 0,
                               width: 0.4375,
                               height: 1,
                               padding: 0.0,
                               paddingLeft: nil,
                               paddingRight: nil,
                               paddingTop: nil,
                               paddingBottom: nil,
                               children: [],
                               anchorX: .left,
                               anchorY: .bottom,
                               backgroundColor: "#73D3A2",
                               media: nil,
                               mediaContentMode: nil)
    }
    
    private static func generateRefFistChild() -> ExpectationData {
        return ExpectationData(id: UUID(),
                               x: 0,
                               y: 0,
                               width: 1,
                               height: 1,
                               padding: 0.0,
                               paddingLeft: nil,
                               paddingRight: nil,
                               paddingTop: nil,
                               paddingBottom: nil,
                               children: [],
                               anchorX: .left,
                               anchorY: .bottom,
                               backgroundColor: "#73D3A2",
                               media: nil,
                               mediaContentMode: nil)
    }
    
    private static func generateRefSecondChild() -> ExpectationData {
        return ExpectationData(id: UUID(),
                               x: 0.5,
                               y: 0.5,
                               width: 0.8,
                               height: 0.2,
                               padding: 0.1,
                               paddingLeft: nil,
                               paddingRight: nil,
                               paddingTop: nil,
                               paddingBottom: nil,
                               children: [self.generateRefFirstSubChild(),
                                          self.generateRefSecoundSubChild()],
                               anchorX: .center,
                               anchorY: .center,
                               backgroundColor: "#6BA2F7",
                               media: nil,
                               mediaContentMode: nil)
    }
    
    private static func generateRefDataModel() -> ExpectationData {
        return ExpectationData(id: UUID(),
                                   x: 0,
                                   y: 0,
                                   width: 1,
                                   height: 1,
                                   padding: 0.1,
                                   paddingLeft: nil,
                                   paddingRight: nil,
                                   paddingTop: nil,
                                   paddingBottom: nil,
                                   children: [self.generateRefFistChild(), self.generateRefSecondChild()],
                                   anchorX: .left,
                                   anchorY: .bottom,
                                   backgroundColor: "#6BA2F7",
                                   media: nil,
                                   mediaContentMode: nil)
    }
    
}
