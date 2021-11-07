//
//  TagView.swift
//  Dinnr
//
//  Created by Brent Mifsud on 2021-11-07.
//

import SwiftUI

struct TagView: View {
    var text: String
    var color: Color = Color(uiColor: .secondarySystemFill)
    var tintColor: Color = .black
    var icon: Image?

    private var tagLabel: Text {
        guard let icon = icon else {
            return Text(text)
        }

        return Text(icon) + Text(text)
    }

    var body: some View {
        tagLabel
            .fontWeight(.semibold)
            .padding(8)
            .padding(.horizontal, 8)
            .foregroundColor(tintColor)
            .background(Capsule().fill(color))
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(text: "Test Tag")
            .padding()
            .previewLayout(.sizeThatFits)
        TagView(text: "Test Tag", color: .red, tintColor: .blue, icon: Image(systemName: "clock"))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
