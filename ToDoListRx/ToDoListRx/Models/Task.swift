//
//  Task.swift
//  ToDoListRx
//
//  Created by Paweł Brzozowski on 24/01/2022.
//

import Foundation

enum Priority: Int {
    case high
    case medium
    case low
}

struct Task {
    var title: String
    var priority: Priority
}
