//
//  TemplateArchiver.swift
//  TestTek
//
//  Created by Nicolas Bellon on 04/08/2022.
//

import Foundation

struct TemplateArchiver: TemplateArchiverInterface {
    func retriveTemplate(onCompletion: @escaping ([Template]?) -> Void) {
        guard
            let dataPathURL = self.archivefilePath,
            let data = try? Data(contentsOf: dataPathURL)
        else { onCompletion(nil); return  }
        
        self.queue.async {
            do {
                let dest = try self.jsonDecoder.decode([Template].self, from: data)
                onCompletion(dest)
            } catch {
                print(error)
                onCompletion(nil)
            }
        }
    }
    
    
    private let jsonEncoder = JSONEncoder()
    private let jsonDecoder = JSONDecoder()
    
    private let queue = DispatchQueue(label: "testTek.archiver", qos: .userInitiated)
    
    private let archivePath: URL? = {
        try? FileManager.default.url(for: .documentDirectory,
                                     in: .userDomainMask,
                                     appropriateFor: nil,
                                     create: true).appendingPathComponent("templates")
    }()
    
    init() {
        self.createDirecoryIfNoPresent()
    }
    
    private var archivefilePath: URL? {
        guard let folderPath = archivePath else { return nil }
        return folderPath.appendingPathComponent("templates.json")
    }
    
    private func createDirecoryIfNoPresent() {
        
        guard let archivePath = self.archivePath else { return }
        
        if FileManager.default.fileExists(atPath: archivePath.path, isDirectory: nil) == false {
            try? FileManager.default.createDirectory(at: archivePath, withIntermediateDirectories: true)
        }
    }
    
    func save(template: [Template], onCompletion: ((Bool) -> Void)?) {
        guard let data = try? self.jsonEncoder.encode(template),
              let path = self.archivefilePath else { onCompletion?(false); return }
        
        self.queue.async {
            do {
                try data.write(to: path)
                onCompletion?(true)
            } catch {
                onCompletion?(false)
                print(error)
            }
        }
    }
}

protocol TemplateArchiverInterface {
    func save(template: [Template], onCompletion: ((Bool) -> Void)?)
    func retriveTemplate(onCompletion: @escaping ([Template]?) -> Void)
}
