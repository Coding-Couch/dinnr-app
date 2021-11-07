//
//  IngredientView.swift
//  Dinnr
//
//  Created by Vincent Romani on 2021-11-05.
//

import SwiftUI

struct IngredientView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @Binding var ingredient: Ingredient
    @State var isSearching: Bool = false
    
    private var iPadView: some View {
        HStack {
            AsyncImage(url: ingredient.image)
                .fixedSize()
            inputView
        }
    }
    
    private var iPhoneView: some View {
        VStack {
            AsyncImage(url: ingredient.image)
                .fixedSize()
            inputView
        }
    }
    
    private var nameInputView: some View {
        HStack {
            TextField(
                LocalizedStringKey("ingredient_name"),
                text: $ingredient.name
            ).textFieldStyle(.roundedBorder)
            Image(systemName: "camera")
        }
    }
    
    private var inputView: some View {
        VStack {
            nameInputView
            AmountView(value: $ingredient.amount, unitType: $ingredient.unit)
        }
    }
    
    @ViewBuilder private func deviceSpecificView() -> some View {
        switch sizeClass {
        case .compact:
            iPhoneView
        default:
            iPadView
        }
    }
    
    var body: some View {
        deviceSpecificView()
            .sheet(isPresented: $isSearching) {
                
            } content: {
                IngredientSearchView(ingredient: $ingredient)
            }

    }
}

struct IngredientView_Previews: PreviewProvider {
    struct TestView: View {
        @State var ingredient: Ingredient = Ingredient()
        
        var body: some View {
            IngredientView(ingredient: $ingredient)        }
    }
    
    static var previews: some View {
        TestView()
            .previewInterfaceOrientation(.portrait)
    }
}
