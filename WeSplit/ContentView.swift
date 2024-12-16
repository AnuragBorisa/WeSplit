//
//  ContentView.swift
//  WeSplit
//
//  Created by Anurag on 12/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0;
    @State private var noOfPeople = 0;
    @State private var tipPercentage = 20;
    @FocusState private var focus: Bool
    let tipPercentages: [Int] = [10, 15, 20, 25, 0];
    var totalPerPerson : Double{
        if checkAmount > 0 && noOfPeople > 0{
            return checkAmount * Double(tipPercentage)/100.0 / Double(noOfPeople)
        }
        return 0.0;
    }
    var body: some View {
        NavigationStack{
            Form{
                Section("Add"){
                    TextField("Check Amount", value: $checkAmount ,format : .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($focus);
                    Picker("Number of people",selection: $noOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("How much tip do you want to leave?"){
                    Picker("Tip Percentage",selection: $tipPercentage){
                        ForEach(tipPercentages,id : \.self){
                            Text($0,format: .percent)
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section("Amount Per Person"){
                    Text(totalPerPerson,format : .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("Split Across")
            .toolbar{
                if focus {
                    Button("Done"){
                        focus = false;
                    }
                }
            }
        }
      
    }
}

#Preview {
    ContentView()
}
