//
//  RootPage.swift
//  Dinnr
//
//  Created by Brent Mifsud on 2021-11-05.
//

import SwiftUI

struct RootPage: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @StateObject var exploreViewModel = ExplorePage.ViewModel(client: DefaultNetworkClient())
    @State var selectedSection: Tab = .recipeSearch

    var body: some View {
        #warning("TODO - Handle landscape sidebar nav")
        rootView(for: sizeClass)
            .environmentObject(exploreViewModel)
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
