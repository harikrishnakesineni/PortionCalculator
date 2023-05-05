//
//  ContentView.swift
//  PortionCalculator
//
//  Created by Hari krishna on 03/05/23.
//

import SwiftUI

struct ContentView: View {
    @State private var tipPct = 0
    @State private var numPeople = 1
    @State private var total = "0"
    @State private var calculate = false
    
    var canAddDecimal: Bool {
        return total.filter{($0 == ".")}.count == 0 ? true : false
    }
    
    var canAddDigit: Bool {
        guard let decimalIndex = total.firstIndex(of: ".") else {
            return true
        }
        let index = total.distance(from: total.startIndex, to: decimalIndex)
        return (total.count - index - 1) < 2
        
    }
    var body: some View {
        NavigationStack {
            VStack {
                Text(total)
                    .font(.system(size: 70))
                    .frame(width: 260, alignment: .trailing)
                    .padding(.vertical, 1)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                
                HStack {
                    ForEach(7...9, id: \.self) { number in
                            numberButton(number: "\(number)")
                    }
                }
                
                HStack {
                    ForEach(4...6, id: \.self) { number in
                            numberButton(number: "\(number)")
                    }
                }
                
                HStack {
                    ForEach(1...3, id: \.self) { number in
                            numberButton(number: "\(number)")
                    }
                }
                
                HStack {
                    numberButton(number: "0")
                    numberButton(number: ".")
                    
                    Button {
                        if total.count == 1 {
                            total = "0"
                        } else {
                            total.removeLast()
                        }
                    } label: {
                        Image(systemName: "delete.backward.fill")
                            .font(.largeTitle)
                            .bold()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.white)
                            .background(.gray)
                            .clipShape(Circle())
                    }
                }
                
                HStack {
                    Text("Tip")
                    
                    Picker(selection: $tipPct) {
                        ForEach(0...100, id: \.self) { num in
                            Text("\(num)")
                        }
                    } label: {
                        Text("Tip")
                    }
                    .buttonStyle(.bordered)
                }
                
                HStack {
                    Text("Number of people")
                    Picker(selection: $numPeople) {
                        ForEach(1...20, id: \.self) { people in
                            Text("\(people)")
                        }
                    } label: {
                        Text("Number of people")
                    }
                    .buttonStyle(.bordered)
                }
                
                HStack {
                    Button {
                        calculate = true
                    } label: {
                        Text("Calculate")
                    }
                    .sheet(isPresented: $calculate) {
                        totalsView(tipPct: tipPct, numPeople: numPeople, total: Double(total) ?? 0)
                            .presentationDetents([.medium])
                    }
                    
                    Button {
                        total = "0"
                    } label: {
                        Text("Clear")
                     }
                }
                .disabled(Double(total) == 0)
                .buttonStyle(.borderedProminent)
                
                Spacer()
                
            }
            .navigationTitle("Portion Calculator")
        }
    }
    
    func addDigit(_ number: String) {
        if canAddDigit {
            if number == "." {
                if canAddDecimal {
                    total += number
                }
            } else {
                total = total == "0" ? number : total + number
            }
        }
    }
    
    func numberButton(number: String) -> some View {
        Button {
            addDigit(number)
        } label: {
            Text(number)
            .font(.largeTitle)
            .bold()
            .frame(width: 80, height: 80)
            .foregroundColor(.white)
            .background(.purple)
            .clipShape(Circle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .tint(.purple)
    }
}
