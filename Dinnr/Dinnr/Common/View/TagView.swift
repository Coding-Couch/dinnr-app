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

    private var tagLabel: some View {
        Label {
            Text(text)
        } icon: {
            icon
        }
    }

    var body: some View {
        tagLabel
            .font(Font.system(size: 17, weight: .semibold, design: .default))
            .padding(8)
            .padding(.horizontal, 8)
            .foregroundColor(tintColor)
            .background(Capsule().fill(color))
            .fixedSize(horizontal: false, vertical: true)
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
