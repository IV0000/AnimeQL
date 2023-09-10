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
    var medium: PageQuery.Data.Page.Medium?

    var title: String {
        if let englishTitle = medium?.title?.english {
            return englishTitle
        } else {
            return medium?.title?.romaji ?? ""
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            AsyncImage(url: URL(string: medium?.coverImage?.extraLarge ?? ""),
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
            .frame(width: 180, height: 220)
            .clipped()

            VStack(alignment: .leading) {
                Text(title)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                Spacer()
                HStack {
                    Image(systemName: "tv")
                    Text("\(medium?.episodes ?? 0)")
                    Spacer()
                    Text(medium?.averageScore?.scoreFormatter() ?? "")
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
            .fill(Color.black)
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
        String(format: "%.1f", Float(self) / 20.0)
    }
}
