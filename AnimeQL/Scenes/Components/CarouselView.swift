//
//  CarouselView.swift
//  AnimeQL
//
//  Created by Ivan Voloshchuk on 10/09/23.
//

import AnilistApi
import SwiftUI

struct CarouselView: View {
    let title: String
    let sortType: MediaSort
    @State var mediaList: [CarouselMediaQuery.Data.Page.Medium?]? // TODO: FIX
    let service: NetworkService
    var body: some View {
        Text(title)
            .font(.title2)
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(mediaList ?? [], id: \.self) { media in
                    NavigationLink(value: Route.detail(media), label: {
                        CardView(medium: media)
                    })
                    .buttonStyle(.plain)
                }
            }
        }
        .onAppear {
            mediaList = service.fetchPage(numberOfElements: 10, sort: sortType)
        }
    }
}

#Preview {
    CarouselView(title: "Popular", sortType: .scoreDesc, mediaList: [], service: NetworkService())
}
