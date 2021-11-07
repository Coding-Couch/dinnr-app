//
//  TabBar.swift
//  Dinnr
//
//  Created by Brent Mifsud on 2021-11-06.
//

import SwiftUI

struct TabBar: View {
    @Binding var selectedSection: Tab

    var body: some View {
        TabView(selection: $selectedSection) {
            CreatePage()
                .tabItem {
                    Label(Tab.recipeCreation.localizationKey, systemImage: Tab.recipeCreation.icon)
                }
                .tag(Tab.recipeCreation)

            #warning("TODO - Add search page")
            Text(selectedSection.localizationKey)
                .tabItem {
                    Label(Tab.recipeSearch.localizationKey, systemImage: Tab.recipeSearch.icon)
                }
                .tag(Tab.recipeSearch)
            
            #warning("TODO - Add Settings page")
            Text(selectedSection.localizationKey)
                .tabItem {
                    Label(Tab.settings.localizationKey, systemImage: Tab.settings.icon)
                }
                .tag(Tab.settings)
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(selectedSection: .constant(.recipeSearch))
    }
}
