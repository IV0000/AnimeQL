//
//  Item.swift
//  AnimeQL
//
//  Created by Ivan Voloshchuk on 29/08/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
