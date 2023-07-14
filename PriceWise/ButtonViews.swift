//
//  ButtonViews.swift
//  PriceWise
//
//  Created by Asa Barton on 7/13/23.
//

import SwiftUI

struct CompareItemsButton: View
{
    @Binding var item1Price: String
    @Binding var item2Price: String
    @Binding var item1Weight: String
    @Binding var item2Weight: String
    @Binding var message: String
    
    var textColor: Color
    var backgroundColor: Color
    var shadowRadius: CGFloat
    var buttonSize: CGFloat
    
    struct Item: Equatable
    {
        var price: Double
        var weight: Double
    }
    
    func findBetterDeal(item1: Item, item2: Item) -> Item?
    {
        let item1PricePerWeight = item1.price / item1.weight
        let item2PricePerWeight = item2.price / item2.weight
        if item1PricePerWeight == item2PricePerWeight
        {
            return nil
        }
        else
        {
            return item1PricePerWeight < item2PricePerWeight ? item1 : item2
        }
    }

    func vibrateDevice()
    {
        let feedbackGenerator = UINotificationFeedbackGenerator()
        feedbackGenerator.prepare()
        feedbackGenerator.notificationOccurred(.success)
    }
    
    var body: some View
    {
        Button(action:
        {
            guard let item1Price = Double(item1Price),
                  let item1Weight = Double(item1Weight),
                  let item2Price = Double(item2Price),
                  let item2Weight = Double(item2Weight)
            else
            {
                message = "Please enter valid numbers for both items"
                
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                return
            }
            
            let item1 = Item(price: item1Price, weight: item1Weight)
            let item2 = Item(price: item2Price, weight: item2Weight)
            
            guard let betterDeal = findBetterDeal(item1: item1, item2: item2)
            else
            {
                message = "The two items have the same value per weight"

                vibrateDevice()
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                
                return
            }
            
            message = "\(betterDeal == item1 ? "Item 1" : "Item 2") is a better deal"

            vibrateDevice()
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        })
        {
            Text("Compare Items")
                .fontWeight(.semibold)
                .font(.system(size: 18))
                .foregroundColor(textColor)
                .padding(buttonSize)
                .background(backgroundColor)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(backgroundColor, lineWidth: 2)
                )
        }
        .shadow(radius: shadowRadius)
        .padding()
    }
}




struct ClearValButton: View
{
    @Binding var item1Price: String
    @Binding var item2Price: String
    @Binding var item1Weight: String
    @Binding var item2Weight: String
    @Binding var message: String
    
    var textColor: Color
    var backgroundColor: Color
    var shadowRadius: CGFloat
    
    var body: some View
    {
        // Button responsible for clearing all values within the text field
        Button(action: {
            item1Price = ""
            item1Weight = ""
            item2Price = ""
            item2Weight = ""
            message = ""
        })
        {
            Text("Clear Values")
                .foregroundColor(textColor)
                .font(.headline)
                .padding()
                .background(backgroundColor)
                .cornerRadius(10)
        }
        .shadow(radius: shadowRadius)
    }
}




