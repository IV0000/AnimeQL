//
//  AnimeQLApp.swift
//  AnimeQL
//
//  Created by Ivan Voloshchuk on 29/08/23.
//

import SwiftData
import SwiftUI

@main
struct AnimeQLApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MainView()
                    .applyRoutingDestination()
            }
        }
        .modelContainer(for: Item.self)
    }
}
