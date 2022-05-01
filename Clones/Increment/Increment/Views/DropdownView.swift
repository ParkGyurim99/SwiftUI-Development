//
//  DropdownView.swift
//  Increment
//
//  Created by Park Gyurim on 2021/08/24.
//

import SwiftUI

struct DropdownView<T : DropdownItemProtocol> : View {
    @Binding var viewModel : T
    
    var actionSheet : ActionSheet {
        ActionSheet(
            title: Text("Select"),
            buttons: viewModel.options.map { option in
                return ActionSheet.Button.default(
                    Text(option.formatted),
                    action : { viewModel.selectedOption = option }
                )
            }
        )
    }
    
    var body : some View {
        VStack {
            HStack {
                Text(viewModel.headerTitle)
                    .font(.system(size : 22, weight : .semibold))
                Spacer()
            }.padding(.vertical, 10)
            
            Button(action : {
                viewModel.isSelected = true
            }) {
                HStack {
                    Text(viewModel.dropdownTitle)
                        .font(.system(size : 28, weight : .semibold))
                    Spacer()
                    Image(systemName: "arrowtriangle.down.circle")
                        .font(.system(size : 24, weight : .medium))
                }
            }.buttonStyle(PrimaryButtonStyle(fillColor: .primaryButton))
        }.padding(.horizontal, 10)
        .actionSheet(isPresented: $viewModel.isSelected) {
            actionSheet
        }
    }
}