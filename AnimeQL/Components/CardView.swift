//
//  CardView.swift
//  AnimeQL
//
//  Created by Ivan Voloshchuk on 30/08/23.
//

import AnilistApi
import SwiftUI

// mediaList?.media?.coverImage?.medium ?? ""

struct CardView: View {
    var mediaList: PageQuery.Data.Page.MediaList?

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            AsyncImage(url: URL(string: mediaList?.media?.coverImage?.extraLarge ?? ""),
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
                        .clipped()
                case let .failure(error):
                    asyncImagePlaceholder(error: error.localizedDescription)
                @unknown default:
                    asyncImagePlaceholder()
                }
            }
            .frame(width: 180, height: 220)

            VStack(alignment: .leading) {
                Text(mediaList?.media?.title?.english ?? "")
                    .lineLimit(2)
                Spacer()
                HStack {
                    Image(systemName: "tv")
                    Text("\(mediaList?.media?.episodes ?? 0)")
                    Spacer()
                    Text(mediaList?.media?.averageScore?.scoreFormatter() ?? "")
                    Image(systemName: "star")
                }
            }
        }
        .frame(width: 180, height: 300)
    }
}

#Preview {
    CardView()
}

extension View {
    func asyncImagePlaceholder(error: String = "") -> some View {
        Rectangle()
            .fill(Color.gray)
            .opacity(0.2)
            .overlay {
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .opacity(0.3)
                    Text(error)
                        .opacity(0.5)
                        .font(.caption)
                }
                .padding(10)
            }
    }
}

extension Int {
    func scoreFormatter() -> String {
        String(format: "%.1f", Float(self / 20))
    }
}
