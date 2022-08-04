//
//  ExpectationModelsFactoryAPIJSON.swift
//  TestTekTests
//
//  Created by Nicolas Bellon on 04/08/2022.
//

import Foundation
@testable import TestTek

struct ExpectationAPIFactory {
    
    static func generateAPIJsonExpectationTemplateModels() -> [ExpectationTemplate] {
        return [self.generateFirstAPIJsonTemplate(),
                self.generateSecondAPIJsonTemplate()]
    }
    
    // MARK: First Template
    
    private static func generateFistAPIJSonDataChild() -> ExpectationData {
        return ExpectationData(id: UUID(),
                               x: 0,
                               y: 0,
                               width: 1,
                               height: 1,
                               padding: 0,
                               paddingLeft: nil,
                               paddingRight: nil,
                               paddingTop: nil,
                               paddingBottom: nil,
                               children: [],
                               anchorX: .left,
                               anchorY: .bottom,
                               backgroundColor: nil,
                               media: "media1",
                               mediaContentMode: .fit)
    }
    
    private static func generateFistAPIJSonData() -> ExpectationData {
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
                               children: [self.generateFistAPIJSonDataChild()],
                               anchorX: .left,
                               anchorY: .bottom,
                               backgroundColor: "#73D3A2",
                               media: nil,
                               mediaContentMode: nil)
    }
    
    private static func generateFirstAPIJsonTemplate() -> ExpectationTemplate {
       return  ExpectationTemplate(name: "My first template",
                            data: self.generateFistAPIJSonData(),
                            id: UUID())
    }

    // MARK: Secound API Template
    
    private static func generateSecondAPIJsonTemplateSubChild1() -> ExpectationData {
        return ExpectationData(id: UUID(),
                               x: 0,
                               y: 0,
                               width: 0.5,
                               height: 0.25,
                               padding: 0.0,
                               paddingLeft: nil,
                               paddingRight: nil,
                               paddingTop: nil,
                               paddingBottom: nil,
                               children: [],
                               anchorX: .left,
                               anchorY: .bottom,
                               backgroundColor: "#2980b9",
                               media: nil,
                               mediaContentMode: nil)
    }
    
    private static func generateSecondAPIJsonTemplateSubChild2() -> ExpectationData {
        return ExpectationData(id: UUID(),
                               x: 1,
                               y: 0,
                               width: 0.5,
                               height: 0.5,
                               padding: 0.0,
                               paddingLeft: nil,
                               paddingRight: nil,
                               paddingTop: nil,
                               paddingBottom: nil,
                               children: [],
                               anchorX: .right,
                               anchorY: .bottom,
                               backgroundColor: "#27ae60",
                               media: nil,
                               mediaContentMode: nil)
    }
    
    private static func generateSecondAPIJsonTemplateSubChild3() -> ExpectationData {
        return ExpectationData(id: UUID(),
                               x: 0,
                               y: 0.25,
                               width: 0.5,
                               height: 0.5,
                               padding: 0.0,
                               paddingLeft: nil,
                               paddingRight: nil,
                               paddingTop: nil,
                               paddingBottom: nil,
                               children: [],
                               anchorX: .left,
                               anchorY: .bottom,
                               backgroundColor: "#e67e22",
                               media: nil,
                               mediaContentMode: nil)
    }
    
    private static func generateSecondAPIJsonTemplateSubChild4() -> ExpectationData {
        return ExpectationData(id: UUID(),
                               x: 0.5,
                               y: 0.5,
                               width: 0.5,
                               height: 0.25,
                               padding: 0.0,
                               paddingLeft: nil,
                               paddingRight: nil,
                               paddingTop: nil,
                               paddingBottom: nil,
                               children: [],
                               anchorX: .left,
                               anchorY: .bottom,
                               backgroundColor: "#8e44ad",
                               media: nil,
                               mediaContentMode: nil)
    }
    
    private static func generateSecondAPIJsonTemplateSubChild5() -> ExpectationData {
        return ExpectationData(id: UUID(),
                               x: 0.0,
                               y: 0.75,
                               width: 1.0,
                               height: 0.25,
                               padding: 0.0,
                               paddingLeft: nil,
                               paddingRight: nil,
                               paddingTop: nil,
                               paddingBottom: nil,
                               children: [],
                               anchorX: .left,
                               anchorY: .bottom,
                               backgroundColor: "#f1c40f",
                               media: nil,
                               mediaContentMode: nil)
    }
    
    private static func generateSecondAPIJsonTemplateFirstChild() -> ExpectationData {
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
                               children: [
                                    self.generateSecondAPIJsonTemplateSubChild1(),
                                    self.generateSecondAPIJsonTemplateSubChild2(),
                                    self.generateSecondAPIJsonTemplateSubChild3(),
                                    self.generateSecondAPIJsonTemplateSubChild4(),
                                    self.generateSecondAPIJsonTemplateSubChild5()
                               ],
                               anchorX: .left,
                               anchorY: .bottom,
                               backgroundColor: "#000000",
                               media: nil,
                               mediaContentMode: nil)
    }
    
    private static func generateSecondAPIJsonTemplate() -> ExpectationTemplate {
        return ExpectationTemplate(name: "My second template",
                                   data: self.generateSecondAPIJsonTemplateFirstChild(),
                                   id: UUID())
    }
    
    
}
