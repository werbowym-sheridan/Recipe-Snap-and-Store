//
//  Line.swift
//  Recipe-Snap-and-Store
//
//  Created by Winsome Tang on 2024-04-17.
//

import SwiftUI

struct Line: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(Color("Egg yellow"))
            .padding(.horizontal)
    }}

#Preview {
    Line()
}
