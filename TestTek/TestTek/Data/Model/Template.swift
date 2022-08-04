//
//  Template.swift
//  TestTek
//
//  Created by Nicolas Bellon on 02/08/2022.
//

import Foundation

struct Template: TemplateInterface, Codable {
   
    let name: String
    let data: TemplateDataInterface
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
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: CodingKeys.name)
        try container.encode(id, forKey: CodingKeys.id)
        
        if let data = data as? TemplateData {
            try container.encode(data, forKey: .data)
        }
    }
}


protocol TemplateInterface {
    var name: String { get }
    var data: TemplateDataInterface { get }
    var id: UUID { get }
}
