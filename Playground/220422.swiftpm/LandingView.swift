//
//  LandingView.swift
//  220422
//
//  Created by Park Gyurim on 2022/04/23.
//

import SwiftUI

struct LandingView : View {
    @StateObject private var viewModel = LandingViewModel()
    
    var body : some View {
        VStack {
            Text(TextSet.TitleText.rawValue)
                .font(.system(size: 70, weight: .bold, design: .monospaced))
                .foregroundColor(.white)
                .padding(Device.height * 0.05)
            
            VStack(spacing : 20) {
                VStack(alignment : .leading, spacing : 20) {
                    Text(TextSet.OperationHintText.rawValue)
                        .font(.system(.body, design: .monospaced))
                        .fontWeight(.semibold)
                        .foregroundColor(.white.opacity(0.7))
                    ForEach(OperationType.allCases, id : \.self) { type in
                        Button {
                            viewModel.selectedType = type
                        } label : {
                            HStack {
                                Image(systemName: viewModel.selectedType == type ? ImageNameSet.selectedBox.rawValue : ImageNameSet.unselectedBox.rawValue)
                                Text(type.title()).fontWeight(.semibold)
                            }.font(.system(.title2, design: .monospaced))
                            .foregroundColor(.white)
                        }
                    }
                }
                
                Button {
                    viewModel.showWheel.toggle()
                } label : {
                    HStack {
                        Text(TextSet.CardCountText.rawValue + " : ").fontWeight(.semibold)
                        Text("\(viewModel.selectedNumberOfCard)").fontWeight(.bold)
                    }.font(.system(.title2, design: .monospaced))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                }.popover(isPresented: $viewModel.showWheel) {
                    VStack(alignment : .trailing) {
                        HStack {
                            Spacer()
                            Text(TextSet.CardCountText.rawValue)
                                .font(.system(.body, design: .monospaced))
                            Spacer()
                            Button {
                                viewModel.showWheel.toggle()
                            } label : {
                                Text(TextSet.Done.rawValue)
                                    .fontWeight(.semibold)
                            }
                        }
                        
                        Picker("", selection: $viewModel.selectedNumberOfCard) {
                            ForEach(2..<10, id : \.self) { Text("\($0)") }
                        }.pickerStyle(WheelPickerStyle())
                    }.padding()
                    .preferredColorScheme(.light)
                }.padding(Device.height * 0.05)
                
                Button {
                    viewModel.onGame.toggle()
                } label : {
                    Text(TextSet.StartButtonText.rawValue)
                        .font(.system(.largeTitle, design: .monospaced))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(.blue.opacity(0.5))
                        .cornerRadius(10)
                }.fullScreenCover(isPresented: $viewModel.onGame) {
                    ContentView(onGame : $viewModel.onGame,
                                viewModel: ContentViewModel(n: viewModel.selectedNumberOfCard, operation: viewModel.selectedType))
                }
            }
        }.background(Image(ImageNameSet.background.rawValue).aspectRatio(contentMode: .fill))
        .animation(.default, value: UIScreen.main.bounds)
        .frame(maxWidth : .infinity, maxHeight: .infinity)
        .overlay(
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        viewModel.showGuide.toggle()
                    } label : {
                        Image(systemName: ImageNameSet.guidButton.rawValue)
                            .font(.system(size : 45))
                            .foregroundColor(.gray.opacity(0.5))
                    }.padding()
                }
            }
        )
        .sheet(isPresented: $viewModel.showGuide) { GuideView(isPresented: $viewModel.showGuide) }
    }
}
