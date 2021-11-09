//
//  ExplorePage.swift
//  Dinnr
//
//  Created by Brent Mifsud on 2021-11-06.
//

import SwiftUI

struct ExplorePage: View {
    @ObservedObject var viewModel: Self.ViewModel

    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(viewModel.recipes) { recipe in
                        Section {
                            RecipeListCellView(recipe: recipe)
                        }
                    }
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                .listStyle(.insetGrouped)
                .searchable(
                    text: $viewModel.query,
                    placement: .navigationBarDrawer(displayMode: .automatic),
                    prompt: LocalizedStringKey("Explore.SearchBar.Prompt"),
                    suggestions: {
                        ForEach(viewModel.suggestions) { autocompleteItem in
                            Text(autocompleteItem.name)
                                .searchCompletion(autocompleteItem.name)
                        }
                    }
                )
                .onSubmit(of: .search, {
                    #warning("TODO - Submit Search")
                })
                .onReceive(viewModel.$query.debounce(for: 0.8, scheduler: RunLoop.main), perform: { query in
                    Task {
                        await viewModel.submitAutocompleteQuery(query: query)
                    }
                })
                .navigationTitle(LocalizedStringKey("Explore.NavigationBar.Title"))
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                Text(viewModel.backgroundMessage)
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .padding()
                    .ignoresSafeArea(.all, edges: .all)
            }
        }
        .isLoading(viewModel.isLoading)
    }
}

struct ExplorePage_Previews: PreviewProvider {
    static var previews: some View {
        ExplorePage(viewModel: .init(client: MockNetworkClient<[Recipe]>()))
    }
}
