//
//  ScrollDetector.swift
//  AnimeQL
//
//  Created by Ivan Voloshchuk on 10/09/23.
//

import Foundation
import SwiftUI

struct ScrollDetector: UIViewRepresentable {
    var onScroll: (CGFloat) -> Void
    var onDraggingEnd: (CGFloat, CGFloat) -> Void

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIView(context _: Context) -> some UIView {
        return UIView()
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.async {
            if let scrollview = uiView.superview?.superview?.superview as? UIScrollView, !context.coordinator.isDelegateInit {
                scrollview.delegate = context.coordinator
                context.coordinator.isDelegateInit = true
            }
        }
    }

    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: ScrollDetector

        init(parent: ScrollDetector) {
            self.parent = parent
        }

        var isDelegateInit: Bool = false
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.onScroll(scrollView.contentOffset.y)
        }

        func scrollViewWillEndDragging(_: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            parent.onDraggingEnd(targetContentOffset.pointee.y, velocity.y)
        }
    }
}
