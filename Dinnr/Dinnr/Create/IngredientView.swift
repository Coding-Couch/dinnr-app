//
//  IngredientView.swift
//  Dinnr
//
//  Created by Vincent Romani on 2021-11-05.
//

import SwiftUI

struct IngredientView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @StateObject var ingredient: Ingredient = Ingredient()
    
    var iPadView: some View {
        HStack {
            Image(systemName: "photo")
            inputView
        }
    }
    
    var iPhoneView: some View {
        VStack {
            Image(systemName: "photo")
            inputView
        }
    }
    
    var inputView: some View {
        VStack {
            TextField(
                LocalizedStringKey("ingredient_name"),
                text: $ingredient.name
            )
            AmountView(value: $ingredient.amount, unitType: $ingredient.unit)
        }
    }
    
    var body: some View {
        switch sizeClass {
        case .compact:
            iPhoneView
        default:
            iPadView
        }
    }
}

struct IngredientView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientView()
.previewInterfaceOrientation(.portrait)

    }
}
