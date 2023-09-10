//
//  Routing.swift
//  AnimeQL
//
//  Created by Ivan Voloshchuk on 10/09/23.
//

import AnilistApi
import Foundation
import SwiftUI

enum Route: Hashable {
    case detail(CarouselMediaQuery.Data.Page.Medium?)
}

private struct Routing: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: Route.self) { route in
                switch route {
                case let .detail(media):
                    CardDetailView(media: media)
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
    }
}

extension View {
    func applyRoutingDestination() -> some View {
        modifier(Routing())
    }
}
