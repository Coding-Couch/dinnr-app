//
//  Sidebar.swift
//  Dinnr
//
//  Created by Brent Mifsud on 2021-11-06.
//

import SwiftUI

struct Sidebar: View {
    @Binding var selectedSection: Section?

    var body: some View {
        List {
            ForEach(Section.allCases) { section in
                NavigationLink(
                    destination: viewForSection(section: section),
                    tag: section,
                    selection: $selectedSection
                ) {
                    Label(section.localizationKey, systemImage: section.icon)
                }
            }
        }
        .listStyle(.sidebar)
        .navigationTitle(LocalizedStringKey("Sidebar.Button.Back.Title"))
        .navigationBarHidden(true)
    }

    @ViewBuilder func viewForSection(section: Section?) -> some View {
        switch section {
        case .some(let section) where section == .recipeCreation:
            #warning("TODO - Add creation page")
            Text(section.localizationKey)
        case .some(let section) where section == .recipeSearch:
            #warning("TODO - Add search page")
            Text(section.localizationKey)
        case .some(let section) where section == .settings:
            #warning("TODO - Add Settings page")
            Text(section.localizationKey)
        case .none, .some:
            EmptyView()
        }
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar(selectedSection: .constant(.recipeSearch))
    }
}
