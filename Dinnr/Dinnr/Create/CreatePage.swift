//
//  CreatePage.swift
//  Dinnr
//
//  Created by Vincent Romani on 2021-11-05.
//

import SwiftUI

struct CreatePage: View {
    @State var recipe: Recipe = Recipe()
    @State var isDisplayingConfirmation: Bool = false

    @ViewBuilder private func addButton(_ text: LocalizedStringKey, action: @escaping () -> Void) -> some View {
        Button {
            withAnimation {
                action()
            }
        } label: {
            Label(
                text,
                systemImage: "plus.circle.fill"
            )
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding()
    }

    @ViewBuilder private func instructionView(instruction: Binding<Instruction>) -> some View {
        HStack {
            Text("\(instruction.step.wrappedValue).")
            TextField(LocalizedStringKey("create.instruction.textfield"), text: instruction.description)
        }
    }

    private func saveRecipe() {
        print(recipe)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(LocalizedStringKey("create.section.info")) {
                    TextField(
                        LocalizedStringKey("create.recipe.title.placeholder"),
                        text: $recipe.title
                    )

                    HStack {
                        TextField(
                            LocalizedStringKey("create.recipe.servings.placeholder"),
                            value: $recipe.servings,
                            format: .number
                        )
                            .multilineTextAlignment(.trailing)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        Text(LocalizedStringKey("create.recipe.servings"))

                    }

                    HStack {
                        Text(LocalizedStringKey("create.recipe.preptime.label"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        TimePickerView(seconds: $recipe.prepTime)
                    }
                    .frame(maxWidth: .infinity)

                    HStack {
                        Text(LocalizedStringKey("create.recipe.cooktime.label"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        TimePickerView(seconds: $recipe.cookTime)
                    }
                    .frame(maxWidth: .infinity)
                }

                Section(LocalizedStringKey("create.section.ingredients")) {
                    ForEach($recipe.ingredients) { ingredient in
                        IngredientView(ingredient: ingredient)
                            .padding()
                    }
                    .onDelete { indexSet in
                        recipe.removeIngredient(indexSet: indexSet)
                    }
                    addButton(LocalizedStringKey("create.button.ingredient")) {
                        recipe.addIngredient()
                    }
                }

                Section(LocalizedStringKey("create.section.instructions")) {
                    ForEach($recipe.instructions) { instruction in
                        instructionView(instruction: instruction)
                            .padding()
                    }
                    .onDelete { indexSet in
                        recipe.removeInstruction(indexSet: indexSet)
                    }
                    addButton(LocalizedStringKey("create.button.instruction")) {
                        recipe.addInstruction()
                    }
                }

                Section(LocalizedStringKey("create.section.tags")) {
                    ForEach($recipe.tags, id: \.self) { tag in
                        TextField("Beginner, Vegan, Spicy, etc...", text: tag)
                    }
                    .onDelete { indexSet in
                        recipe.tags.remove(atOffsets: indexSet)
                    }
                    addButton(LocalizedStringKey("create.button.tag")) {
                        recipe.tags.append("")
                    }
                }

            }
            .frame(maxHeight: .infinity, alignment: .top)
            .navigationTitle(LocalizedStringKey("create.navigationbar.title"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button(LocalizedStringKey("create.navigationbar.button.save")) {
                    isDisplayingConfirmation = true
                }
            }
            .alert(LocalizedStringKey("create.alert.confirmation.title"),
                   isPresented: $isDisplayingConfirmation,
                   actions: {
                Button(
                    LocalizedStringKey("create.alert.confirmation.button.save")
                ) {
                    saveRecipe()
                }
                Button(
                    LocalizedStringKey("create.alert.confirmation.button.cancel"),
                    role: .cancel,
                    action: {}
                )
            }, message: {
                Text(
                    LocalizedStringKey("create.alert.confirmation.message")
                )
            }
            )
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePage()
    }
}
