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
                        NavigationLink {
                            RecipeDetailView(recipe: recipe)
                        } label: {
                            RecipeListCellView(recipe: recipe)
                        }
                    }
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                .listStyle(.insetGrouped)
                .searchable(
                    text: $viewModel.query,
                    placement: .navigationBarDrawer(displayMode: .automatic),
                    prompt: LocalizedStringKey("Explore.SearchBar.Prompt")
                )
                .onSubmit(of: .search, {
                    viewModel.submitQuery()
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
        .onAppear {
            #if DEBUG
            viewModel.setupMockClient()
            #endif
        }
    }
}

struct ExplorePage_Previews: PreviewProvider {
    static var previews: some View {
        ExplorePage(viewModel: .init(client: MockNetworkClient<[Recipe]>()))
    }
}
