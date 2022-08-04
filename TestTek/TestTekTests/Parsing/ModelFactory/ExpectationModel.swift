//
//  ExpectationModel.swift
//  TestTekTests
//
//  Created by Nicolas Bellon on 04/08/2022.
//

import Foundation
@testable import TestTek

struct ExpectationTemplate: TemplateInterface {
    var name: String
    var data: TemplateDataInterface
    var id: UUID
}

struct ExpectationData: TemplateDataInterface {
    var id: UUID
    var x: Float
    var y: Float
    var width: Float
    var height: Float
    var padding: Float
    var paddingLeft: Float?
    var paddingRight: Float?
    var paddingTop: Float?
    var paddingBottom: Float?
    var children: [TemplateDataInterface]
    var anchorX: TemplateAnchorH
    var anchorY: TemplateAnchorV
    var backgroundColor: String?
    var media: String?
    var mediaContentMode: TemplateMediaContentMode?
}

