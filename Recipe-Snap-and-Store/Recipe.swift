//
//  Recipe.swift
//  Recipe-Snap-and-Store
//
//  Created by Michael Werbowy on 2024-04-13.
//

import Foundation
import FirebaseFirestoreSwift

struct Recipe: Codable, Identifiable {
    @DocumentID var id: String?
    var name = ""
    var description = ""
    
    var dictionary: [String: Any] {
        return [
            "name": name,
            "description": description
        ]
    }
}
