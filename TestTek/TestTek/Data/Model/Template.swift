//
//  Template.swift
//  TestTek
//
//  Created by Nicolas Bellon on 02/08/2022.
//

import Foundation


struct Template: Codable, Identifiable {
    let name: String
    let data: TemplateData
    var id: UUID
    
    private enum CodingKeys : String, CodingKey {
        case name
        case data
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.data = try container.decode(TemplateData.self, forKey: .data)
        if container.contains(.id) {
            self.id = try container.decode(UUID.self, forKey: .id)
        } else {
            self.id = UUID()
        }
    }
}


   
