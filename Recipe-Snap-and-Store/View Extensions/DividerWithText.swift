//
//  DividerWithText.swift
//  Recipe-Snap-and-Store
//
//  Created by Winsome Tang on 2024-04-17.
//

import SwiftUI

struct DividerWithText: View {
    var body: some View {
        HStack {
            Line()
            Text("or")
                .bold()
                .foregroundColor(Color("Egg yellow"))
            Line()
        }
    }
}

#Preview {
    DividerWithText()
}
