import SwiftUI

struct ContentView: View {
    @State private var isOn = false
    var viewInspectorHook: ((Self) -> Void)?

    var body: some View {
        VStack {
            Toggle(isOn: $isOn) {
                Text("Enable")
            }
            CustomButton()
                .disabled(!isOn)
        }
        .padding()
        .onAppear { self.viewInspectorHook?(self) }
    }
}

private struct CustomButton: View {
    @Environment(\.isEnabled)
    private var isEnabled: Bool

    var body: some View {
        Button(action: {
        }, label: {
            RoundedRectangle(cornerRadius: 10)
                .fill(isEnabled ? .blue : .gray)
                .frame(width: 100, height: 100)
                .overlay(
                    Text("Button")
                        .foregroundColor(.white)
                )
        })
        .tag("customButton")
    }
}

#Preview {
    ContentView()
}
