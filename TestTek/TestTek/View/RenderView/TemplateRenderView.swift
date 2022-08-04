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
        Drawer.drawRect(rect: rect, template: self.renderViewModel.data)
    }
}

struct TemplateRenderViewBridge: UIViewRepresentable {
    
    let viewModel: RenderViewViewModelInterface

    func makeUIView(context: Context) -> TemplateRenderView {
        TemplateRenderView(renderViewModel: viewModel)
    }

    func updateUIView(_ uiView: TemplateRenderView, context: Context) {
        uiView.renderViewModel = viewModel
    }
}
