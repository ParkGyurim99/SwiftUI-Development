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
    
    var body: some View {
        //ScrollView {
        VStack {
            dropdownList
            Spacer()
            HStack {
                Spacer()
//                NavigationLink(destination: RemindView(), isActive: $isActive) { // isActive 사용하는 이유가 버튼을 사용하기 때문인듯??
                    Button(action : {
                        //isActive = true
                        viewModel.send(action: .createChallenge)
                    }) {
                        Text("Next")
                            .font(.system(size : 24, weight : .medium))
                    }
                    .buttonStyle(PrimaryButtonStyle(fillColor: Color.primaryButton))
                    .padding(20)
//                }
            }
        } // VStack
        .navigationBarTitle("Create")
        .navigationBarBackButtonHidden(true)
        //} // ScrollView
    }
}
