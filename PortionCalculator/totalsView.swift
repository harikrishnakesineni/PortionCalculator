//
//  totalsView.swift
//  PortionCalculator
//
//  Created by Hari krishna on 04/05/23.
//

import SwiftUI

struct totalsView: View {
    let tipPct: Int
    let numPeople: Int
    let total: Double
    
    var portion: Double {
        return total / Double(numPeople)
    }
    
    var tipAmount: Double {
        return (Double(tipPct) / 100) * total
    }
    
    var totalAmount: Double {
        return total + tipAmount
    }
    
    let identifier = Locale.current.currency?.identifier ?? ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Grid(horizontalSpacing: 20) {
                    GridRow {
                        Text("Original Bill")
                            .gridColumnAlignment(.leading)
                        Text("\(total, format: .currency(code: identifier))")
                            .gridColumnAlignment(.trailing)
                    }
                    
                    GridRow {
                        Text("Tip")
                        Text("\(tipAmount, format: .currency(code: identifier))")
                    }
                    
                    GridRow {
                        Text("Total Amount")
                        Text("\(totalAmount, format: .currency(code: identifier))")
                    }
                    
                    GridRow {
                        Text("Portion")
                        Text("\(portion, format: .currency(code: identifier))")
                    }
                    
                }
                .font(.title)
                Image("wallet")
                    .resizable()
                    .scaledToFit()
                
                
                Spacer()
            }
            
            .navigationTitle("Amount Owing")
            .navigationBarTitleDisplayMode(.inline)
            
            
        }
    }
}

struct totalsView_Previews: PreviewProvider {
    static var previews: some View {
        totalsView(tipPct: 1, numPeople: 20, total: 145.6)
    }
}
