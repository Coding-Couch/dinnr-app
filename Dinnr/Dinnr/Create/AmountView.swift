//
//  AmountView.swift
//  Dinnr
//
//  Created by Vincent Romani on 2021-11-05.
//

import SwiftUI

struct AmountView: View {
    @Binding var value: Double
    @Binding var unitType: IngredientAmountType
    
    var amountTypePicker: some View {
        Picker(
            selection: $unitType,
            label: Text("Picker")
        ) {
            ForEach(IngredientAmountType.allMassUnits) { type in
                Text(type.description).tag(type)
            }
            
            Divider()
            
            ForEach(IngredientAmountType.allVolumeUnits) { type in
                Text(type.description).tag(type)
            }
            
            Divider()
            
            Text(IngredientAmountType.count.description).tag(IngredientAmountType.count)

        }
        .pickerStyle(.menu)
    }
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        HStack(spacing: 5) {
            TextField(LocalizedStringKey("Value"), value: $value, format: .number)
                .textFieldStyle(.roundedBorder)
            amountTypePicker
        }
    }
}

struct AmountView_Previews: PreviewProvider {
    struct TestView: View {
        @State var value: Double = 0.0
        @State var amount: IngredientAmountType = .count
        
        var body: some View {
            AmountView(value: $value, unitType: $amount)
        }
    }
    
    static var previews: some View {
        TestView()
    }
}
