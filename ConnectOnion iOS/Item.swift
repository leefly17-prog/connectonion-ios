//
//  Item.swift
//  ConnectOnion iOS
//
//  Created by Junhua Di on 2026/6/12.
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
