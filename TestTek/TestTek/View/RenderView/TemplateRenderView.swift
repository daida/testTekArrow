//
//  TemplateRenderView.swift
//  TestTek
//
//  Created by Nicolas Bellon on 02/08/2022.
//

import Foundation
import UIKit
import SwiftUI
import CoreGraphics

class TemplateRenderView: UIView {
    
    var renderViewModel: RenderViewViewModelInterface {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    init(renderViewModel: RenderViewViewModelInterface) {
        self.renderViewModel = renderViewModel
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        Drawer.drawRect(rect: rect, template: self.renderViewModel.template.data)
    }
    
    override func layoutSubviews() {
        self.setNeedsDisplay()
    }
}

class TemplateRendererViewController: UIViewController {
    
    private let templateRenderView: TemplateRenderView
    private let viewModel: RenderViewViewModelInterface
    
    init(viewModel: RenderViewViewModelInterface) {
        self.viewModel = viewModel
        self.templateRenderView = TemplateRenderView(renderViewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
        self.templateRenderView.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        constraints.append(self.templateRenderView.topAnchor.constraint(equalTo: self.view.topAnchor))
        constraints.append(self.templateRenderView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor))
        constraints.append(self.templateRenderView.leftAnchor.constraint(equalTo: self.view.leftAnchor))
        constraints.append(self.templateRenderView.rightAnchor.constraint(equalTo: self.view.rightAnchor))
        self.view.addSubview(self.templateRenderView)
        NSLayoutConstraint.activate(constraints)
        self.setupGesture()
    }
    
    func makeTemplateScreenShot() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: self.templateRenderView.bounds)
        return renderer.image { (context) in
            self.templateRenderView.layer.render(in: context.cgContext)
        }
    }
    
    @objc private func userDidLongPress() {
        let image = self.makeTemplateScreenShot()
        
        let fileURL = FileManager.default.temporaryDirectory.self.appendingPathComponent(self.templateRenderView.renderViewModel.template.name).appendingPathExtension("jpeg")
        
        if FileManager.default.fileExists(atPath: fileURL.path) == true {
            try? FileManager.default.removeItem(at: fileURL)
        }
        
        let data = image.jpegData(compressionQuality: 1.0)
        try? data?.write(to: fileURL)
        
        let items = [fileURL]
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        self.present(activityViewController, animated: true)
    }
    
    private func setupGesture() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(userDidLongPress))
        self.view.addGestureRecognizer(gesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct TemplateRenderViewBridge: UIViewControllerRepresentable {

    typealias UIViewControllerType = TemplateRendererViewController
    
    let viewModel: RenderViewViewModelInterface
    
    func makeUIViewController(context: Context) -> TemplateRendererViewController {
        TemplateRendererViewController(viewModel: viewModel)
    }
    
    func updateUIViewController(_ uiViewController: TemplateRendererViewController, context: Context) {
        
    }
}
