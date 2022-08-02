//
//  TemplateMediaContentMode.swift
//  TestTek
//
//  Created by Nicolas Bellon on 02/08/2022.
//

import Foundation

enum TemplateMediaContentMode: String {
    
    case fit
    case fill
    
    init?(str: String?) {
        switch str {
        case "fit": self = .fit
        case "fill": self = .fill
        default:
            return nil
        }
    }
}
