import SwiftUI

struct ContentView: View {
    enum Operator: Int {
        case addition
        case subtraction
        case multiplication
        case division
    }

    @State private var num1: Double?
    @State private var num2: Double?
    @State private var total: String = "0"
    @State private var operatorNumber: Int = Operator.addition.rawValue
    
    var body: some View {
        VStack {
            NumberInputView(value: $num1)
            NumberInputView(value: $num2)
            Picker(selection: $operatorNumber, label: Text("Picker")) {
                Text("+").tag(Operator.addition.rawValue)
                Text("-").tag(Operator.subtraction.rawValue)
                Text("×").tag(Operator.multiplication.rawValue)
                Text("÷").tag(Operator.division.rawValue)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Button(action: {
                let unwrapedNum = [num1,num2].map{ $0 ?? 0 }

                guard let ope = Operator(rawValue: operatorNumber) else { return }

                switch ope {
                case .addition:
                    total = String(unwrapedNum[0] + unwrapedNum[1])
                case .subtraction:
                    total = String(unwrapedNum[0] - unwrapedNum[1])
                case .multiplication:
                    total = String(unwrapedNum[0] * unwrapedNum[1])
                case .division:
                    if unwrapedNum[1] == 0 {
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
