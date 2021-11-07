//
//  IngredientSearchView.swift
//  Dinnr
//
//  Created by Vincent Romani on 2021-11-06.
//

import SwiftUI

struct IngredientSearchView: View {
    @State private var searchText = ""
    @Binding var ingredient: Ingredient
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
            NavigationView {
                List {
                    ForEach(searchResults, id: \.self) { result in
                        Text(result)
                    }
                }
                .searchable(text: $searchText)
                .onSubmit(of: .search) {
                    presentationMode.wrappedValue.dismiss()
                }
                .navigationTitle(LocalizedStringKey("ingredient_search"))
            }
        }

    var searchResults: [String] {
        return ["Eggplant"]
    }
}

struct IngredientSearchView_Previews: PreviewProvider {
    struct TestView: View {
        @State var ingredient: Ingredient = Ingredient()

        var body: some View {
            IngredientSearchView(ingredient: $ingredient)        }
    }

    static var previews: some View {
        TestView()
    }
}
