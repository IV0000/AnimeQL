//
//  GraphQueryTestView.swift
//  AnimeQL
//
//  Created by Ivan Voloshchuk on 29/08/23.
//

import SwiftUI
import AnilistApi
import Apollo

struct GraphQueryTestView: View {
    @StateObject var ns = NetworkService()
    @State private var number = 20
    var body: some View {
        VStack(alignment: .leading){
            List {
                ForEach(ns.mediaList,id: \.self) { media in
                    VStack(alignment: .leading){
                        Text(media?.media?.title?.romaji ?? "")
                        Text(media?.media?.title?.english ?? "")
                        Text("Score: \(media?.media?.averageScore ?? 0)")
                    }
                }
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

}

#Preview {
    GraphQueryTestView()
}


class NetworkService : ObservableObject {
    
    private var apollo = ApolloClient(url: URL(string:"https://graphql.anilist.co")!)
    @Published var mediaList : [PageQuery.Data.Page.MediaList?] = []
    
    func fetchPage(numberOfElements: Int) {
        apollo.fetch(query: PageQuery(perPage: GraphQLNullable( integerLiteral: numberOfElements))) { [weak self] result in
            switch result {
            case .success(let value):
                print(value)
                if let data = value.data, let page = data.page {
                    self?.mediaList = page.mediaList ?? []
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
