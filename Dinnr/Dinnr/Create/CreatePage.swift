//
//  CreatePage.swift
//  Dinnr
//
//  Created by Vincent Romani on 2021-11-05.
//

import SwiftUI

struct CreatePage: View {
    @State var recipe: Recipe = Recipe()
    
    @ViewBuilder private func addIngredientView() -> some View {
        ForEach($recipe.ingredients) { ingredient in
            IngredientView(ingredient: ingredient)
                .padding()
        }
        
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
    
    var body: some View {
        Form {
            Section(LocalizedStringKey("info")) {
                Text("Hello")
            }
            Section(LocalizedStringKey("ingredients")) {
                addIngredientView()
            }
            Section(LocalizedStringKey("instructions")) {
                addInstructionsView()
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .navi
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePage()
    }
}
