import Foundation
import SwiftUI

struct Meta: Codable {
    // "limit": "int",
    // "next": "",
    // "offset": "int",
    // "previous": "",
    // "total_count": "int"
    var limit: Int
    var next: String
    var offset: Int
    var previous: String?
    var total_count: Int?
}

struct Contest: Codable, Hashable, Identifiable {
        // "id": 0,
        // "resource": "",
        // "resource_id": 0,
        // "host": "",
        // "event": "",
        // "start": "datetime",
        // "end": "datetime",
        // "parsed_at": "datetime",
        // "duration": "datetime",
        // "href": "",
        // "problems": ""
    let id: Int64
    let resource: String
    let resource_id: Int
    let host: String
    let event: String
    let start: String
    let end: String
    let parsed_at: String?
    let duration: Int
    let href: String
    let problems: String?
}

struct Response: Codable {
    var meta: Meta
    var objects: [Contest]
}
