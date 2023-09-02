//
//  GraphQueryTestView.swift
//  AnimeQL
//
//  Created by Ivan Voloshchuk on 29/08/23.
//

import AnilistApi
import Apollo
import SwiftUI

struct LandingView: View {
    @StateObject var ns = NetworkService()
    @State private var number = 10
    var body: some View {
        VStack(alignment: .leading) {
            Text("Highest score")
                .font(.title2)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(ns.mediaList, id: \.self) { media in
                        CardView(medium: media)
                    }
                }
            }
            Text("Current Season")
                .font(.title2)
            Spacer()
        }
        .onAppear(perform: {
            ns.fetchPage(numberOfElements: number, sort: .scoreDesc)
        })
    }
}

#Preview {
    LandingView()
}

class NetworkService: ObservableObject {
    private var apollo = ApolloClient(url: URL(string: "https://graphql.anilist.co")!)
    @Published var mediaList: [PageQuery.Data.Page.Medium?] = []

    func fetchPage(numberOfElements: Int, sort: MediaSort?) {
        let sortEnum: [GraphQLEnum<MediaSort>?]

        if let sortValue = sort {
            sortEnum = [.init(rawValue: sortValue.rawValue)]
        } else {
            sortEnum = []
        }

        apollo.fetch(query: PageQuery(perPage: GraphQLNullable(integerLiteral: numberOfElements),
                                      sort: .some(sortEnum),
                                      type: .some(GraphQLEnum(MediaType.anime))))
        { [weak self] result in
            switch result {
            case let .success(value):
                print(value)
                if let data = value.data, let page = data.page {
                    self?.mediaList = page.media ?? []
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    // Add different fetches for different t
}
