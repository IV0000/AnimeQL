//
//  HomeTest.swift
//  AnimeQL
//
//  Created by Ivan Voloshchuk on 05/09/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets

            HomeTest(size: size, safeArea: safeArea)
                .ignoresSafeArea(.all, edges: .top)
        }
    }
}

struct HomeTest: View {
    var size: CGSize
    var safeArea: EdgeInsets
    @State private var offsetY: CGFloat = 0
    var body: some View {
        ScrollViewReader { scrollProxy in
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    HeaderView()
                        .zIndex(1000)
                    mocks()
                }
                .id("ScrollView")
                .background {
                    ScrollDetector { offset in
                        offsetY = -offset
                    } onDraggingEnd: { offset, velocity
                        in
                        let headerHeight = (size.height * 0.3) + safeArea.top
                        let minimumHeaderHeight = 65 + safeArea.top
                        let targetEnd = offset * (velocity * 45)
                        if targetEnd < (headerHeight - minimumHeaderHeight) && targetEnd > 0 {
                            withAnimation(.interactiveSpring(response: 0.55, dampingFraction: 0.65, blendDuration: 0.65)) {
                                scrollProxy.scrollTo("ScrollView", anchor: .top)
                            }
                        }
                    }
                }
            }
        }
    }

    @ViewBuilder
    func HeaderView() -> some View {
        let headerHeight = (size.height * 0.3) + safeArea.top
        let minimumHeaderHeight = 65 + safeArea.top
        let progress = max(min(-offsetY / (headerHeight - minimumHeaderHeight), 1), 0)
        GeometryReader { _ in
            ZStack {
                Rectangle()
                    .fill(.red)
                VStack {
                    GeometryReader {
                        let rect = $0.frame(in: .global)
                        Image(systemName: "tv")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: rect.width, height: rect.height)
                            .clipShape(Circle())
                    }
                    .frame(width: headerHeight * 0.5, height: headerHeight * 0.5)

                    Text("\(progress)")
                        .foregroundStyle(.black)
                }
                .padding(.top, safeArea.top)
                .padding(.bottom, 15)
            }
            .frame(height: (headerHeight + offsetY) < minimumHeaderHeight ? minimumHeaderHeight : (headerHeight + offsetY), alignment: .bottom)
            .offset(y: -offsetY)
        }
        .frame(height: headerHeight)
    }

    @ViewBuilder
    func mocks() -> some View {
        VStack(spacing: 10) {
            ForEach(1 ... 10, id: \.self) { _ in
                RoundedRectangle(cornerRadius: 10)
                    .fill(.black.opacity(0.3))
                    .frame(height: 70)
                    .padding(.horizontal, 5)
            }
        }
    }
}

#Preview {
    MainView()
}

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
