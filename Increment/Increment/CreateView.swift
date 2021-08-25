//
//  CreateView.swift
//  Increment
//
//  Created by Park Gyurim on 2021/08/24.
//

import SwiftUI

struct CreateView: View {
    @StateObject var viewModel = CreateChallengeViewModel()
    @State private var isActive : Bool = false

    var dropdownList : some View {
        ForEach(viewModel.dropdowns.indices, id : \.self) { index in
            DropdownView(viewModel : $viewModel.dropdowns[index])
        }
    }
    
    var actionSheet : ActionSheet {
        ActionSheet(
            title: Text("Select"),
            buttons: viewModel.displayOptions.indices.map { index in
                let option = viewModel.displayOptions[index]
                return ActionSheet.Button.default(
                    Text(option.formatted),
                    action : { viewModel.send(action : .selectOption(index: index)) }
                )
            }
        )
    }
    
    var body: some View {
        //ScrollView {
        VStack {
            dropdownList
            Spacer()
            HStack {
                Spacer()
                NavigationLink(destination: RemindView(), isActive: $isActive) { // isActive 사용하는 이유가 버튼을 사용하기 때문인듯??
                    Button(action : {
                        isActive = true
                    }) {
                        Text("Next")
                            .font(.system(size : 24, weight : .medium))
                    }
                    .actionSheet(isPresented: Binding<Bool>(get : { viewModel.hasSelectedDropdown }, set : { _ in }))
                        { actionSheet }
                    .buttonStyle(PrimaryButtonStyle(fillColor: Color.primaryButton))
                    .padding(20)
                }
            }
        } // VStack
        .navigationBarTitle("Create")
        .navigationBarBackButtonHidden(true)
        //} // ScrollView
    }
}
