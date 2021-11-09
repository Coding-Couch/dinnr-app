//
//  RecipeListCellView.swift
//  Dinnr
//
//  Created by Brent Mifsud on 2021-11-07.
//

import SwiftUI

struct RecipeListCellView: View {
    var recipe: Recipe

    var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 16) {
                Text(recipe.title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)

                RecipeBannerImage(url: recipe.bannerImage)
                    .frame(maxWidth: .infinity, idealHeight: 240, maxHeight: 240)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .frame(maxWidth: .infinity)
            .padding(16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    TagView(
                        text: "\((recipe.prepTime + recipe.cookTime).formattedTime)",
                        icon: Image(systemName: "clock")
                    )

                    ForEach(recipe.tags, id: \.self) { tag in
                        TagView(text: tag)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding([.bottom, .horizontal], 16)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .background(
            NavigationLink {
                RecipeDetailView(recipe: recipe)
            } label: {
                EmptyView()
            }.opacity(0)
        )
    }
}

// swiftlint:disable line_length
struct RecipeListCellView_Previews: PreviewProvider {
    static let mockRecipe: Recipe = .init(
        id: .init(),
        servings: 2,
        bannerImage: URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/04/Pound_layer_cake.jpg")!,
        title: "Birthday Cake",
        prepTime: 30,
        cookTime: 30,
        ingredients: [
            .init(name: "Egg", amount: 12, unit: .volume(volumeUnit: .tablespoons), image: nil)
        ],
        instructions: [
            .init(step: .init(), image: nil, description: "Mix eggs into flour"),
            .init(step: .init(), image: nil, description: "Put it in an oiled baking pan."),
            .init(step: .init(), image: nil, description: "Bake on 325 f for 1 hour. Periodically checking consistency."),
            .init(step: .init(), image: nil, description: "Take out of the oven when desired consistency is achieved."),
            .init(step: .init(), image: nil, description: "Let cool!"),
            .init(step: .init(), image: nil, description: "Apply frosting and decorations!")
        ],
        tags: ["dessert", "good-for-parties"]
    )

    static var previews: some View {
        RecipeListCellView(recipe: Self.mockRecipe)
            .previewLayout(.sizeThatFits)
    }
}
// swiftlint:enable line_length
