//
//  ExplorePage+ViewModel.swift
//  Dinnr
//
//  Created by Brent Mifsud on 2021-11-06.
//

import SwiftUI
import Combine

extension ExplorePage {
    @MainActor class ViewModel: ObservableObject {
        struct AutocompleteItem: Identifiable {
            let id: UUID
            let name: String
        }

        enum ExploreError: Error {
            case empty
            case error(error: Error)
        }

        var client: NetworkClient

        @Published var selectedRecipe: Recipe?
        @Published var recipes: [Recipe] = []
        @Published var suggestions: [AutocompleteItem] = []
        @Published var query: String = ""
        @Published var error: ExploreError?
        @Published var isLoading: Bool = false

        private var offset: Int = 0
        private var totalCount: Int = 0

        private var autocompleteTask: Task<Void, Never>?

        private var canLoadMorePages: Bool {
            offset < totalCount && !query.isEmpty
        }

        var backgroundMessage: LocalizedStringKey {
            switch error {
            case let .error(error: error):
                return .init("Explore.EmptyMessage.Error \(String(describing: error))")
            case .empty:
                return .init("Explore.EmptyMessage.Empty")
            case .none:
                if query.isEmpty && recipes.isEmpty {
                    return .init("Explore.EmptyMessage.InitialState")
                } else {
                    return .init("")
                }
            }
        }

        init(client: NetworkClient = DefaultNetworkClient()) {
            self.client = client
        }

        func submitAutocompleteQuery(query: String) async {
            guard !query.isEmpty else { return }

            isLoading = true

            autocompleteTask?.cancel()

            autocompleteTask = Task(priority: .userInitiated) {
                let request = NetworkRequest<[Recipe]>(
                    pathItems: Endpoint.recipeSearch,
                    headers: [:],
                    queryParms: ["limit": "\(10)", "offset": "\(0)"],
                    body: nil,
                    httpMethod: .get
                )

                do {
                    let response = try await client.request(with: request, decodingInto: RecipeResponseDTO.self)
                    suggestions = response.recipes.map {AutocompleteItem(id: $0.id, name: $0.title)}
                } catch {
                    print(String(describing: error))
                }

                if !Task.isCancelled {
                    isLoading = false
                }
            }
        }
    }
}
