import SwiftUI
import UIKit

struct ContentView: View
{
    @State private var item1Price = ""
    @State private var item1Weight = ""
    @State private var item2Price = ""
    @State private var item2Weight = ""
    @State private var message = ""
    
    var body: some View
    {
        let SHADOW_RADIUS: CGFloat = 10
        let FONT_SIZE: CGFloat = 20
        let COMPARE_BUTTON_SIZE: CGFloat = 40
        
        VStack
        {
            HStack
            {
                VStack(alignment: .leading)
                {
                    Text("Item 1")
                        .bold()
                        .font(.system(size: FONT_SIZE))
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
                        .bold()
                        .font(.system(size: FONT_SIZE))
                    TextField("Price", text: $item2Price)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    TextField("Weight", text: $item2Weight)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }
            }
            
            Text("")
            Text("")
            
            // Button responsible for clearing all values within the four text fields
            ClearValButton(item1Price: $item1Price, item2Price: $item2Price, item1Weight: $item1Weight, item2Weight: $item2Weight, message: $message, textColor: Color(.red), backgroundColor: Color(.black), shadowRadius: SHADOW_RADIUS)
            
            // Button responsible for comparing the two items
            CompareItemsButton(item1Price: $item1Price, item2Price: $item2Price, item1Weight: $item1Weight, item2Weight: $item2Weight, message: $message, textColor: Color(.white), backgroundColor: Color(.blue), shadowRadius: SHADOW_RADIUS, buttonSize: COMPARE_BUTTON_SIZE)
            
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

