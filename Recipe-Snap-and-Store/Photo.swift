//
//  Photo.swift
//  Recipe-Snap-and-Store
//
//  Created by Michael Werbowy on 2024-04-13.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Photo: Codable, Identifiable {
    @DocumentID var id: String?
    var imageURLString = ""
    var description = ""
    var poster = Auth.auth().currentUser?.email ?? ""
    var postedDate = Date()
    
    var dictionary: [String: Any] {
        return [
            "imageURLString": imageURLString,
            "description": description,
            "poster": poster,
            "postedDate": Timestamp(date: Date())
        ]
    }
}
