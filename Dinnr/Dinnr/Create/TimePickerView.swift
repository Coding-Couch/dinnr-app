//
//  TimePickerView.swift
//  Dinnr
//
//  Created by Vincent Romani on 2021-11-06.
//

import SwiftUI
import Combine
import Foundation

struct TimePickerView: View {
    class ViewModel: ObservableObject {
        @Published var hours: Int = 0
        @Published var minutes: Int = 0
    }
    
    @ObservedObject private var viewModel: ViewModel = ViewModel()
    
    @Binding var seconds: Int
    
    var hourRange: ClosedRange<Int> = 0...48
    let minuteRange: ClosedRange<Int> = 0...60
    
    func convertToSeconds(hours: Int, minutes: Int) -> Int {
        let hoursMeasurement = Measurement<UnitDuration>(value: Double(hours), unit: .hours)
        let minutesMeasurement = Measurement<UnitDuration>(value: Double(minutes), unit: .minutes)
        
        let hoursInSeconds = hoursMeasurement.converted(to: .seconds).value
        let minutesInSeconds = minutesMeasurement.converted(to: .seconds).value
        
        let seconds = hoursInSeconds + minutesInSeconds
        
        return Int(seconds)
    }
    
    @ViewBuilder func timePicker(_ stringKey: LocalizedStringKey, selection: Binding<Int>, range: ClosedRange<Int>) -> some View {
        HStack {
            Picker(stringKey, selection: selection) {
                ForEach(range, id: \.self) { number in
                    Text("\(number)")
                }
            }
            .padding(.paddingSmall)
            .pickerStyle(.menu)
            .onReceive(Publishers.CombineLatest(viewModel.$hours, viewModel.$minutes)) { (hours, minutes) in
                seconds = convertToSeconds(hours: hours, minutes: minutes)
            }
            
            Text(stringKey)
        }
        .padding([.horizontal], .paddingMedium)
        .background(Color.tertiaryBackground)
        .foregroundColor(.tertiaryForeground)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
    
    var body: some View {
        VStack(alignment: .trailing) {
            timePicker("Hours", selection: $viewModel.hours, range: hourRange)
            
            timePicker("Minutes", selection: $viewModel.minutes, range: minuteRange)
        }
        .frame(alignment: .trailing)
    }
}

struct TimePickerView_Previews: PreviewProvider {
    struct TestView: View {
        @State var seconds: Int = 0
        
        var body: some View {
            TimePickerView(seconds: $seconds)
            
        }
    }
    
    static var previews: some View {
        TestView()
    }
}
