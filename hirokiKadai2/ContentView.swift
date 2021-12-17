import SwiftUI

struct ContentView: View {
    @State private var num1: Double?
    @State private var num2: Double?
    @State private var total: String = "0"
    @State private var operatorNumber: Int = 1
    
    var body: some View {
        VStack {
            NumberInputView(value: $num1)
            NumberInputView(value: $num2)
            Picker(selection: $operatorNumber, label: Text("Picker")) {
                Text("+").tag(1)
                Text("-").tag(2)
                Text("×").tag(3)
                Text("÷").tag(4)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Button(action: {
                let unwrapedNum = [num1,num2].map{$0 ?? 0}
                
                if operatorNumber==1 {
                    total = String(unwrapedNum[0] + unwrapedNum[1])
                } else if operatorNumber==2 {
                    total = String(unwrapedNum[0] - unwrapedNum[1])
                } else if operatorNumber==3 {
                    total = String(unwrapedNum[0] * unwrapedNum[1])
                } else {
                    if unwrapedNum[1]==0 {
                        total = "割る数には0以外を入力してください"
                    } else {
                        total = String(unwrapedNum[0] / unwrapedNum[1])
                    }
                }
            }) {
                Text("Button")
            }
            .padding()
            
            Text(String(total))
        }
    }
}

struct NumberInputView: View {
    @Binding var value: Double?
    
    var body: some View {
        TextField("", value: $value, formatter: NumberFormatter())
            .padding()
            .keyboardType(.numberPad)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
