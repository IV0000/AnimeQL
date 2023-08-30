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
    @State private var number = 20
    var body: some View {
        VStack(alignment: .leading) {
            Text("Current season")
                .font(.title2)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(ns.mediaList, id: \.self) { media in
                        CardView(mediaList: media)
                    }
                }
            }
            Text("Highest score")
                .font(.title2)
            Spacer()
        }
        .refreshable {
            number += 10
            ns.fetchPage(numberOfElements: number)
        }
        .onAppear(perform: {
            ns.fetchPage(numberOfElements: number)
        })
    }
}

#Preview {
    LandingView()
}

class NetworkService: ObservableObject {
    private var apollo = ApolloClient(url: URL(string: "https://graphql.anilist.co")!)
    @Published var mediaList: [PageQuery.Data.Page.MediaList?] = []

    func fetchPage(numberOfElements: Int) {
        apollo.fetch(query: PageQuery(perPage: GraphQLNullable(integerLiteral: numberOfElements))) { [weak self] result in
            switch result {
            case let .success(value):
                print(value)
                if let data = value.data, let page = data.page {
                    self?.mediaList = page.mediaList ?? []
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
