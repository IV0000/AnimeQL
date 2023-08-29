//
//  AnimeQLApp.swift
//  AnimeQL
//
//  Created by Ivan Voloshchuk on 29/08/23.
//

import SwiftUI
import SwiftData

@main
struct AnimeQLApp: App {

    var body: some Scene {
        WindowGroup {
            GraphQueryTestView()
        }
        .modelContainer(for: Item.self)
    }
}
