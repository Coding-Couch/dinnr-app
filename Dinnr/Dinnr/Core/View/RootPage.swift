//
//  RootPage.swift
//  Dinnr
//
//  Created by Brent Mifsud on 2021-11-05.
//

import SwiftUI

struct RootPage: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @State var selectedSection: Section = .recipeSearch

    var body: some View {
        #warning("TODO - Handle landscape sidebar nav")
        NavigationView {
            rootView(for: sizeClass)
        }
        .navigationViewStyle(.stack)
    }

    @ViewBuilder private func rootView(for: UserInterfaceSizeClass?) -> some View {
        #warning("TODO - Handle landscape sidebar nav")
        TabBar(selectedSection: $selectedSection)
    }
}

struct RootPage_Previews: PreviewProvider {
    static var previews: some View {
        RootPage()
    }
}
