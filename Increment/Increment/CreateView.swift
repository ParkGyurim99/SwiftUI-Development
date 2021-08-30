//
//  CreateView.swift
//  Increment
//
//  Created by Park Gyurim on 2021/08/24.
//

import SwiftUI

struct CreateView: View {
    @StateObject var viewModel = CreateChallengeViewModel()
    //@State private var isActive : Bool = false

    var dropdownList : some View {
//        ForEach(viewModel.dropdowns.indices, id : \.self) { index in
//            DropdownView(viewModel : $viewModel.dropdowns[index])
//        }
        Group {
            DropdownView(viewModel: $viewModel.exerciseDropdown)
            DropdownView(viewModel: $viewModel.startAmountDropdown)
            DropdownView(viewModel: $viewModel.increaseDropdown)
            DropdownView(viewModel: $viewModel.lengthDropdown)
        }
    }
    
    var mainContentView : some View {
        //ScrollView {
        VStack {
            dropdownList
            Spacer()
            HStack {
                Spacer()
                //NavigationLink(destination: RemindView(), isActive: $isActive) { // isActive 사용하는 이유가 버튼을 사용하기 때문인듯??
                Button(action : {
                    //isActive = true
                    viewModel.send(action: .createChallenge)
                }) {
                    Text("Create")
                        .font(.system(size : 24, weight : .medium))
                }
                .buttonStyle(PrimaryButtonStyle(fillColor: Color.primaryButton))
                .padding(20)
                //}
            }
        } // VStack
        //} // ScrollView
    }
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                mainContentView
            }
        }
        .alert(isPresented: Binding<Bool>.constant($viewModel.error.wrappedValue != nil)) {
            Alert(
                title : Text("Error"),
                message : Text($viewModel.error.wrappedValue?.localizedDescription ?? ""),
                dismissButton: Alert.Button.default(Text("OK"), action : { viewModel.error = nil })
            )
        } 
        .navigationBarTitle("Create")
        .navigationBarBackButtonHidden(true)
    }
}
