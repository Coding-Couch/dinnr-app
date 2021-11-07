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
    @State var prepTime: Date = .now {
        didSet {
            print(prepTime)
        }
    }
    
    @ViewBuilder private func addIngredientView() -> some View {
        Button {
            withAnimation {
                recipe.addIngredient()
            }
        } label: {
            Label(
                LocalizedStringKey("add_ingredient"),
                systemImage: "plus.circle.fill"
            )
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding()
    }
    
    @ViewBuilder private func addInstructionsView() -> some View {
        Button {
            withAnimation {
                recipe.addInstruction()
            }
        } label: {
            Label(
                LocalizedStringKey("add_instruction"),
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
        
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(LocalizedStringKey("info")) {
                    TextField(
                        LocalizedStringKey("create.recipe.title"),
                        text: $recipe.title
                    )
                    
                    TextField(
                        LocalizedStringKey("create.recipe.servings.default"),
                        value: $recipe.servings,
                        format: .number
                    )
                    
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
                
                Section(LocalizedStringKey("ingredients")) {
                    ForEach($recipe.ingredients) { ingredient in
                        IngredientView(ingredient: ingredient)
                            .padding()
                    }
                    .onDelete { indexSet in
                        recipe.removeIngredient(indexSet: indexSet)
                    }
                    addIngredientView()
                }
                
                Section(LocalizedStringKey("instructions")) {
                    ForEach($recipe.instructions) { instruction in
                        instructionView(instruction: instruction)
                            .padding()
                    }
                    .onDelete { indexSet in
                        recipe.removeInstruction(indexSet: indexSet)
                    }
                    addInstructionsView()
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .navigationTitle(LocalizedStringKey("create_recipe"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button(LocalizedStringKey("save")) {
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
            })
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePage()
    }
}
