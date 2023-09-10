//
//  CardDetailView.swift
//  AnimeQL
//
//  Created by Ivan Voloshchuk on 02/09/23.
//

import AnilistApi
import SwiftUI

private enum HeaderSection {
    case about
    case reviews
}

struct CardDetailView: View {
    @State private var section: HeaderSection = .about

    private var sectionOffset: CGFloat {
        switch section {
        case .about:
            return 0
        case .reviews:
            return 1
        }
    }

    @State private var offsetY: CGFloat = 0
    let mockUrlImage = "https://s4.anilist.co/file/anilistcdn/media/manga/cover/large/nx31706-8NapvUJrWR3C.png"
    let media: PageQuery.Data.Page.Medium?

    var body: some View {
        GeometryReader {
            let size: CGSize = $0.size
            let safeArea: EdgeInsets = $0.safeAreaInsets
            ScrollViewReader { scrollProxy in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        let headerHeight = (size.height * 0.3) + safeArea.top
                        let minimumHeaderHeight = 65 + safeArea.top
                        let progress = max(min(-offsetY / (headerHeight - minimumHeaderHeight), 1), 0)
                        GeometryReader { _ in
                            ZStack {
                                AsyncImage(url: URL(string: media?.coverImage?.extraLarge ?? ""),
                                           transaction: .init(animation: .easeIn(duration: 0.3)))
                                { phase in
                                    switch phase {
                                    case .empty:
                                        asyncImagePlaceholder()
                                            .transition(.opacity.combined(with: .move(edge: .trailing)))
                                    case let .success(image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .transition(.opacity.combined(with: .move(edge: .leading)))
                                            .overlay {
                                                LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom)
                                                    .opacity(0.8)
                                                    .blendMode(.multiply)
                                            }
//                                            .offset(y: 200) // Adding offset breaks everything
                                    case .failure:
                                        asyncImagePlaceholder(error: "Error image loading")
                                    @unknown default:
                                        asyncImagePlaceholder()
                                    }
                                }
                                .clipped()

                                VStack(alignment: .leading, spacing: 0) {
                                    GeometryReader {
                                        let _ = $0.frame(in: .global)
                                    }
                                    Spacer()
                                    ZStack(alignment: .leading) {
                                        HStack {
                                            Spacer()
                                            Text("Anime title")
                                                .font(.title2)
                                                .fontWeight(.medium)
                                                .foregroundStyle(.white)
                                            Spacer()
                                        }
                                        .opacity(progress)

                                        VStack(alignment: .leading) {
                                            Text("Anime title")
                                                .font(.title)
                                                .fontWeight(.medium)
                                                .foregroundStyle(.white)

                                            Text("Season Episodes Status")
                                                .font(.title3)
                                                .fontWeight(.regular)
                                                .foregroundStyle(.white)
                                        }
                                        .padding(.leading, 5)
                                        .padding(.bottom, 5)
                                        .opacity(1 - progress)
                                    }
                                }
//                                .frame(width: proxy.size.width, height: proxy.size.height, alignment: .leading)
//                                .padding(.top,safeArea.top)
                            }
                            .frame(height: (headerHeight + offsetY) < minimumHeaderHeight ? minimumHeaderHeight : (headerHeight + offsetY),
                                   alignment: .bottom)
                            .offset(y: -offsetY)
                        }
                        .frame(height: headerHeight)
                        .zIndex(1000)

                        SectionSwitchView()

                        if section == .about {
                            AboutView()
//                                .padding(.horizontal,10)
                        } else {
                            Text("Reviews wip")
                        }
                    }
                    .id("ScrollView")
                    .background {
                        ScrollDetector { offset in
                            offsetY = -offset
                        } onDraggingEnd: { offset, velocity in
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

                // Floating Button
                Button(action: {}, label: {
                    Text("Add to favorite")
                        .padding()
                        .foregroundColor(.white)
                        .background {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 350, height: 45)
                        }
                })
                .frame(maxWidth: .infinity)
                // TODO: Add related shows
            }
            .ignoresSafeArea(.all, edges: .top)
        }
    }

    @ViewBuilder
    func SectionSwitchView() -> some View {
        GeometryReader { proxy in
            ZStack {
                HStack(alignment: .firstTextBaseline, spacing: 10) {
                    Button(action: {
                        section = .about
                    }, label: {
                        Text("About")
                    })
                    .frame(minWidth: 0, maxWidth: .infinity)
                    Button(action: {
                        section = .reviews
                    }, label: {
                        Text("Reviews")
                    })
                    .frame(minWidth: 0, maxWidth: .infinity)
                }
                VStack {
                    Spacer()
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(.gray)
                            .frame(width: proxy.size.width / 2.0, height: 5.0, alignment: .leading)
                            .offset(x: sectionOffset * proxy.size.width / 2.0, y: 5)
                            .animation(.linear, value: sectionOffset)
                        Rectangle()
                            .fill(.clear)
                            .frame(width: proxy.size.width, height: 4.0, alignment: .leading)
                    }
                    .frame(height: 2.0)
                }
            }
        }
        .frame(height: 40)
    }
}

struct AboutView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    @State private var lineLimit: Int? = 6

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Anime info")
                .font(.title3)

            HStack {
                Text("Winter 2018")
                Text("- Action,Drama")
            }
            Text("Score: 4/5")
            VStack(alignment: .leading) {
                Text("Gintoki, Shinpachi, and Kagura return as the fun-loving but broke members of the Yorozuya team! Living in an alternate-reality Edo, where swords are prohibited and alien overlords have conquered Japan, they try to thrive on doing whatever work they can get their hands on. However, Shinpachi and Kagura still haven't been paid... Does Gin-chan really spend all that cash playing pachinko?\n\n.... Gintoki, Shinpachi, and Kagura return as the fun-loving but broke members of the Yorozuya team! Living in an alternate-reality Edo, where swords are prohibited and alien overlords have conquered Japan, they try to thrive on doing whatever work they can get their hands on. However, Shinpachi and Kagura still haven't been paid... Does Gin-chan really spend all that cash playing pachinko?\n\n....")
                    .lineLimit(lineLimit)
                Button(lineLimit == nil ? "Show less" : "Show more") {
                    if lineLimit == nil {
                        lineLimit = 6
                    } else {
                        lineLimit = nil
                    }
                }
            }
            .animation(.easeOut(duration: 0.2), value: lineLimit)

            Divider()
            LazyVGrid(columns: columns, alignment: .leading, content: {
                HStack {
                    Image(systemName: "list.clipboard")
                    Text("Watching: 20%")
                }
                HStack {
                    Image(systemName: "list.clipboard")
                    Text("Planning: 10%")
                }
                HStack {
                    Image(systemName: "list.clipboard")
                    Text("Completed: 40%")
                }
                HStack {
                    Image(systemName: "list.clipboard")
                    Text("Dropped: 15%")
                }
                HStack {
                    Image(systemName: "list.clipboard")
                    Text("Paused: 15%")
                }
            })
        }
        .padding(.top, 10)
        .padding(.horizontal, 10)
    }
}

#Preview {
    CardDetailView(media: nil)
}
