//
//  TabBar.swift
//  Dinnr
//
//  Created by Brent Mifsud on 2021-11-06.
//

import SwiftUI

struct TabBar: View {
    @EnvironmentObject var exploreViewModel: ExplorePage.ViewModel
    @Binding var selectedSection: Tab

    var body: some View {
        TabView(selection: $selectedSection) {
            CreatePage()
                .tabItem {
                    Label(Tab.recipeCreation.localizationKey, systemImage: Tab.recipeCreation.icon)
                }
                .tag(Tab.recipeCreation)

            ExplorePage(viewModel: exploreViewModel)
                .tabItem {
                    Label(Tab.recipeSearch.localizationKey, systemImage: Tab.recipeSearch.icon)
                }
                .tag(Tab.recipeSearch)
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(selectedSection: .constant(.recipeSearch))
    }
}
