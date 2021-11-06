//
//  TabBar.swift
//  Dinnr
//
//  Created by Brent Mifsud on 2021-11-06.
//

import SwiftUI

struct TabBar: View {
    @Binding var selectedSection: Section

    var body: some View {
        TabView(selection: $selectedSection) {
            #warning("TODO - Add creation page")
            Text(selectedSection.localizationKey)
                .tabItem {
                    Label(Section.recipeCreation.localizationKey, systemImage: Section.recipeCreation.icon)
                }
                .tag(Section.recipeCreation)

            #warning("TODO - Add search page")
            Text(selectedSection.localizationKey)
                .tabItem {
                    Label(Section.recipeSearch.localizationKey, systemImage: Section.recipeSearch.icon)
                }
                .tag(Section.recipeSearch)
            
            #warning("TODO - Add Settings page")
            Text(selectedSection.localizationKey)
                .tabItem {
                    Label(Section.settings.localizationKey, systemImage: Section.settings.icon)
                }
                .tag(Section.settings)
        }
        .navigationBarHidden(true)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(selectedSection: .constant(.recipeSearch))
    }
}
