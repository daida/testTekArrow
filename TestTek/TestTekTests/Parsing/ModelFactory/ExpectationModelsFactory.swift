//
//  ExpectationModelsFactory.swift
//  TestTekTests
//
//  Created by Nicolas Bellon on 04/08/2022.
//

import Foundation
@testable import TestTek

struct ExpectationModelsFactory {
        
    static func generateRefModel() -> [ExpectationTemplate] {
        ExpectationRefFactory.generateRefExpectationModel()
    }
    
    static func generateAPIModels() -> [ExpectationTemplate] {
        return ExpectationAPIFactory.generateAPIJsonExpectationTemplateModels()
        
    }
}
