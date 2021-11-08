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
        enum ExploreError: Error {
            case empty
            case error(error: Error)
        }

        var client: NetworkClient

        @Published var selectedRecipe: Recipe?
        @Published var recipes: [Recipe] = []
        @Published var query: String = ""
        @Published var error: ExploreError?
        @Published var isLoading: Bool = false

        private var offset: Int = 0
        private var totalCount: Int = 0
        private var cancellables: Set<AnyCancellable> = []

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

            $query
                .handleEvents(receiveOutput: {[self] _ in
                    self.offset = 0
                    self.totalCount = 0
                    self.error = nil
                })
                .debounce(for: 0.2, scheduler: RunLoop.main)
                .sink(receiveValue: { [self] query in
                    guard !query.isEmpty else {
                        return
                    }
                    submitQuery()
                })
                .store(in: &cancellables)
        }

        func nextPage() async {
            guard canLoadMorePages else {
                return
            }

            let request = NetworkRequest<String>(
                baseUrl: URL(string: "https://dinnr.ca/")!,
                pathItems: [
                    "recipes",
                    "search"
                ],
                headers: [
                    "Accept": "application/json",
                    "Content-Type": "application/json",
                    "Accept-Language": Locale.current.identifier
                ],
                queryParms: [
                    "query": self.query,
                    "limit": "\(10)",
                    "offset": "\(self.offset)"
                ],
                body: nil,
                httpMethod: .get
            )

            defer {
                isLoading = false
            }

            do {
                self.isLoading = true
                self.recipes = try await client.request(with: request, decodingInto: [Recipe].self)
            } catch {
                self.error = .error(error: error)
            }
        }

        func submitQuery() {
            $query
                .handleEvents(receiveOutput: { [self] query in
                    if !query.isEmpty {
                        isLoading = true
                    }
                })
                .flatMap { [weak self] query -> AnyPublisher<[Recipe], Error> in
                    guard let self = self else {
                        return Empty(completeImmediately: true).eraseToAnyPublisher()
                    }

                    guard !query.isEmpty else {
                        self.isLoading = false
                        return Empty(completeImmediately: true).eraseToAnyPublisher()
                    }

                    let request = NetworkRequest<String>(
                        baseUrl: URL(string: "https://dinnr.ca/")!,
                        pathItems: [
                            "recipes",
                            "search"
                        ],
                        headers: [
                            "Accept": "application/json",
                            "Content-Type": "application/json",
                            "Accept-Language": Locale.current.identifier
                        ],
                        queryParms: [
                            "query": self.query,
                            "limit": "\(10)",
                            "offset": "\(self.offset)"
                        ],
                        body: nil,
                        httpMethod: .get
                    )

                    return self.client.publisher(of: request, decodingInto: [Recipe].self)
                }
                .prefix(1)
                .sink { [weak self] completion in
                    if case let Subscribers.Completion.failure(error) = completion {
                        self?.error = .error(error: error)
                    }

                    self?.isLoading = false
                } receiveValue: { [weak self] recipes in
                    self?.recipes = recipes
                    self?.offset = recipes.count
                    self?.isLoading = false
                }
                .store(in: &cancellables)
        }

        #if DEBUG
        func setupMockClient() {
            guard let client = client as? MockNetworkClient<[Recipe]> else {
                return
            }

            client.mockResponse = Array(repeating: Recipe.createMock(), count: 10)
        }
        #endif
    }
}

// swiftling:disable line_length
fileprivate extension Recipe {
    static func createMock() -> Recipe {
        .init(
            id: .init(),
            servings: 2,
            bannerImage: URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/04/Pound_layer_cake.jpg")!,
            title: "Birthday Cake",
            prepTime: 1800,
            cookTime: 3600,
            ingredients: [
                .init(name: "Egg", amount: 12, unit: .count, image: nil),
                .init(name: "Egg", amount: 1, unit: .volume(volumeUnit: .cups), image: nil),
                .init(name: "Egg", amount: 2, unit: .volume(volumeUnit: .cups), image: nil),
                .init(name: "Egg", amount: 250, unit: .volume(volumeUnit: .milliliters), image: nil)
                ],
            instructions: [
                .init(step: 1, image: nil, description: "Mix eggs into flour"),
                .init(step: 2, image: nil, description: "Put it in an oiled baking pan."),
                .init(step: 3, image: nil, description: "Bake on 325 f for 1 hour. Periodically checking consistency."),
                .init(step: 4, image: nil, description: "Take out of the oven when desired consistency is achieved."),
                .init(step: 5, image: nil, description: "Let cool!"),
                .init(step: 6, image: nil, description: "Apply frosting and decorations!")
            ],
            tags: ["dessert", "good-for-parties"]
        )
    }
}
// swiftling:disable line_length
