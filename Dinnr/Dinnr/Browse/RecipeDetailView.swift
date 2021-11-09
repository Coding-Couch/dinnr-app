//
//  RecipeDetailView.swift
//  Dinnr
//
//  Created by Brent Mifsud on 2021-11-07.
//

import SwiftUI

struct RecipeDetailView: View {
    @Environment(\.dismiss) private var dismiss
    var recipe: Recipe

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .topLeading) {
                BannerView(recipe: recipe)

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Spacer().frame(height: 220)

                        VStack(alignment: .leading, spacing: 16) {
                            DragIndicator()

                            IngredientsSection(ingredients: recipe.ingredients)

                            DirectionsSection(instructions: recipe.instructions)

                            TagSection(tags: recipe.tags)

                            Spacer()
                        }
                        .frame(minHeight: proxy.size.height - 200)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                    }
                }
                .frame(width: proxy.size.width, height: proxy.size.height)

                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
                .font(.title)
                .foregroundColor(.white)
                .padding(.horizontal, 30)
                .padding(.vertical, 40)
            }
            .frame(maxHeight: .infinity)
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(.all, edges: .all)
    }
}

private struct BannerView: View {
    var recipe: Recipe

    var body: some View {
        RecipeBannerImage(url: recipe.bannerImage)
            .frame(maxWidth: .infinity, idealHeight: 260, maxHeight: 260)
            .clipShape(Rectangle())
            .overlay(Color.black.opacity(0.4))
            .overlay(
                VStack(alignment: .leading, spacing: 16) {
                    Spacer().frame(height: 30)

                    Text(recipe.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    HStack(alignment: .center, spacing: 16) {
                        TimeView(time: recipe.prepTime)
                        TimeView(time: recipe.cookTime)
                    }

                    Spacer()
                }
                    .padding(.top, 40)
                    .padding(.horizontal, 30)
                    .frame(maxHeight: 260)
                    .foregroundColor(.white),
                alignment: .topLeading
            )
    }
}

private struct DragIndicator: View {
    var body: some View {
        Color.clear
            .frame(maxWidth: .infinity)
            .frame(height: 20)
            .overlay(
                Capsule()
                    .fill(Color(uiColor: .tertiaryLabel))
                    .frame(width: 60, height: 6)
                    .cornerRadius(3)
            )
    }
}

private struct IngredientsSection: View {
    var ingredients: [Ingredient]

    var body: some View {
        Section {
            ForEach(ingredients) { ingredient in
                HStack {
                    Circle()
                        .fill(.black)
                        .frame(width: 6, height: 6)

                    Text(ingredient.displayString)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.leading, 16)
            }
        } header: {
            Text("Ingredients")
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
    }
}

private struct DirectionsSection: View {
    var instructions: [Instruction]

    var body: some View {
        Section {
            ForEach(instructions.sorted(by: {$0.step < $1.step})) { instruction in
                HStack {
                    Text(instruction.displayString)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.leading, 16)
            }
        } header: {
            Text("Directions")
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
    }
}

private struct TagSection: View {
    var tags: [String]

    var body: some View {
        Section {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Spacer().frame(width: 16)
                    ForEach(tags, id: \.self) { tag in
                        TagView(text: tag)
                    }
                    Spacer().frame(width: 16)
                }
            }
        } header: {
            Text("Tags")
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    private static let mockRecipe: Recipe = .init(
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

    static var previews: some View {
        RecipeDetailView(recipe: Self.mockRecipe)
    }
}

struct TimeView: View {
    var time: Int

    var body: some View {
        VStack(alignment: .leading) {
            Text("Prep Time")
                .bold()
            Label("\(time.formattedTime)", systemImage: "clock")
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }

}
