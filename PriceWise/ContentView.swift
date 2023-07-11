import SwiftUI
import UIKit

struct ContentView: View
{
    @State private var item1Price = ""
    @State private var item1Weight = ""
    @State private var item2Price = ""
    @State private var item2Weight = ""
    @State private var message = ""
    
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
        VStack
        {
            HStack
            {
                VStack(alignment: .leading)
                {
                    Text("Item 1")
                    TextField("Price", text: $item1Price)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    TextField("Weight", text: $item1Weight)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }
                Spacer()
                VStack(alignment: .leading)
                {
                    Text("Item 2")
                    TextField("Price", text: $item2Price)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    TextField("Weight", text: $item2Weight)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }
            }
            Button(action:
            {
                guard let item1Price = Double(item1Price),
                      let item1Weight = Double(item1Weight),
                      let item2Price = Double(item2Price),
                      let item2Weight = Double(item2Weight)
                else
                {
                    message = "Please enter valid numbers for both items"
                    return
                }
                
                let item1 = Item(price: item1Price, weight: item1Weight)
                let item2 = Item(price: item2Price, weight: item2Weight)
                
                guard let betterDeal = findBetterDeal(item1: item1, item2: item2)
                else
                {
                    message = "The two items have the same value per weight"
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
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 2)
                    )
            }
            .padding()

            Text(message)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.70, green: 0.2, blue: 0.4)) // Set the background color to red
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView()
    }
}

