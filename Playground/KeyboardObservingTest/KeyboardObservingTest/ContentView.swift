//
//  ContentView.swift
//  KeyboardObservingTest
//
//  Created by Park Gyurim on 2023/07/07.
//

import SwiftUI

enum TextFieldType {
    case text1
    case text2
}

struct ContentView: View {
    @StateObject private var viewModel = SomeViewModel()
    @FocusState var isFocused: TextFieldType?
    
    var body: some View {
        VStack {
            Text("Keyboard Height Prac")
                .font(.title2)
            Text("\(viewModel.keyboardHeight)")
                .fontWeight(.bold)
                .padding()
            
            TextField("", text: $viewModel.text1)
                .padding(.vertical, 8)
                .padding(.horizontal)
                .background(Color.black.opacity(0.2))
                .cornerRadius(12)
                .focused($isFocused, equals: .text1)
            
            TextField("", text: $viewModel.text2)
                .padding(.vertical, 8)
                .padding(.horizontal)
                .background(Color.black.opacity(0.2))
                .cornerRadius(12)
                .focused($isFocused, equals: .text2)
        }.padding()
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button(isFocused == .text1 ? "Next" : "Done") {
                    if isFocused == .text1 { isFocused = .text2 }
                    else { isFocused = nil }
                }
            }
        }
        .onAppear { isFocused = .text1 }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
