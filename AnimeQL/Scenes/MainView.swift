//
//  MainView.swift
//  AnimeQL
//
//  Created by Ivan Voloshchuk on 29/08/23.
//

import AnilistApi
import Apollo
import SwiftUI

struct MainView: View {
    @StateObject var ns = NetworkService()
    var body: some View {
        VStack(alignment: .leading) {
            CarouselView(title: "Trending", sortType: .trendingDesc, service: ns)
            Spacer()
            CarouselView(title: "Highest Score", sortType: .scoreDesc, service: ns)

            Spacer()
        }
    }
}

#Preview {
    MainView()
}

class NetworkService: ObservableObject {
    private var client = ApolloClient(url: URL(string: "https://graphql.anilist.co")!)
//    @Published var mediaList: [CarouselMediaQuery.Data.Page.Medium?] = []

    func fetchPage(numberOfElements: Int, sort: MediaSort?) -> [CarouselMediaQuery.Data.Page.Medium?] {
        var media: [CarouselMediaQuery.Data.Page.Medium?] = []
        let sortEnum: [GraphQLEnum<MediaSort>?]

        if let sortValue = sort {
            sortEnum = [.init(rawValue: sortValue.rawValue)]
        } else {
            sortEnum = []
        }

        client.fetch(query: CarouselMediaQuery(perPage: GraphQLNullable(integerLiteral: numberOfElements),
                                               type: .some(GraphQLEnum(MediaType.anime)),
                                               sort: .some(sortEnum)))
        { [weak self] result in
            switch result {
            case let .success(value):
                if let data = value.data, let page = data.page {
                    media = page.media ?? []
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
        return media
    }

    // Add different fetches for different t
}

// TEST
struct MediaVM: Identifiable, Decodable {
    let id: String
    let episodes: Int
    let title: MediaTitle
    let averageScore: Int
    let image: CoverImage

    struct MediaTitle: Decodable {
        let english: String
        let romaji: String
    }

    struct CoverImage: Decodable {
        let url: String
    }

//    init () {
//
//    }
}
