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

        constraints.append(self.templateRenderView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor))
        constraints.append(self.templateRenderView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor))
        
        constraints.append(self.templateRenderView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.9))
        
        constraints.append(self.templateRenderView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8))
        
        self.view.addSubview(self.templateRenderView)
        NSLayoutConstraint.activate(constraints)
        self.setupGesture()
        self.templateRenderView.clipsToBounds = true
    }
    
    func makeTemplateScreenShot() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: self.templateRenderView.bounds)
        return renderer.image { (context) in
            self.templateRenderView.layer.render(in: context.cgContext)
        }
    }
    
    @objc private func userDidLongPress(_ gesture: UILongPressGestureRecognizer) {
        let image = self.makeTemplateScreenShot()
        
        let fileURL = FileManager.default.temporaryDirectory.self.appendingPathComponent(self.templateRenderView.renderViewModel.template.name).appendingPathExtension("jpeg")
        
        if FileManager.default.fileExists(atPath: fileURL.path) == true {
            try? FileManager.default.removeItem(at: fileURL)
        }
        
        let data = image.jpegData(compressionQuality: 1.0)
        try? data?.write(to: fileURL)
        
        let items = [fileURL]
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
       
        if UIDevice.current.userInterfaceIdiom == .pad {
            activityViewController.popoverPresentationController?.sourceView = self.view
            activityViewController.popoverPresentationController?.sourceRect = CGRect(origin: gesture.location(in: self.templateRenderView), size: CGSize(width: 1, height: 1))
            }
        
        self.present(activityViewController, animated: true)
    }
    
    private func setupGesture() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(userDidLongPress(_:)))
        self.view.addGestureRecognizer(gesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      //  self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        self.templateRenderView.layer.cornerRadius = self.view.frame.width * 0.04
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
