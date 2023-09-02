//
//  CardDetailView.swift
//  AnimeQL
//
//  Created by Ivan Voloshchuk on 02/09/23.
//

import SwiftUI

struct CardDetailView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Anime Title")
                .font(.title)
            AsyncImage(url: URL(string: "https://s4.anilist.co/file/anilistcdn/media/manga/cover/large/nx31706-8NapvUJrWR3C.png"),
                       transaction: .init(animation: .easeIn(duration: 0.3)))
            { phase in
                switch phase {
                case .empty:
                    asyncImagePlaceholder()
                        .transition(.opacity.combined(with: .slide))
                case let .success(image):
                    image
                        .resizable()
                        .scaledToFill()
                        .transition(.opacity.combined(with: .slide))
                case let .failure(error):
                    asyncImagePlaceholder(error: error.localizedDescription)
                @unknown default:
                    asyncImagePlaceholder()
                }
            }
            .frame(width: .infinity, height: 220)
            .clipped()
            Text("Genres")
            Text("Description")
            Spacer()
        }
    }
}

#Preview {
    CardDetailView()
}
