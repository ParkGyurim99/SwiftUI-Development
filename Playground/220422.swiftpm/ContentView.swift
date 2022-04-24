import SwiftUI

struct NumberCard : View {
    let number : Int
    
    init(_ number : Int) { self.number = number }
    
    var body : some View {
        VStack {
            Text("\(number)")
                .foregroundColor(.black)
                .font(.system(size: 50, weight: .semibold, design: .monospaced))
                .padding()
                .background(Color.blue.opacity(0.3))
                .cornerRadius(10)
        }
    }
}

struct ContentView: View {
    @Binding var onGame : Bool
    @StateObject private var viewModel : ContentViewModel
    
    init(onGame : Binding<Bool>, viewModel : ContentViewModel) {
        self._onGame = onGame
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        HStack(spacing : 0) {
            // Left side
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    GeometryReader { geometry in
                        Text(viewModel.operationType.title() + " " + viewModel.operationType.emoji())
                            .font(.system(size: 25, weight: .bold, design: .monospaced))
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 7)
                        
                        ForEach(0..<viewModel.countOfCards) { n in
                            NumberCard(viewModel.cards[n].number)
                                .scaleEffect(viewModel.cards[n].scale)
                                .gesture(
                                    DragGesture(coordinateSpace : .named("main"))
                                        .onChanged { gesture in
                                            withAnimation(.linear(duration: 0.1) ) {
                                                viewModel.cards[n].scale = 1.5
                                                viewModel.cards[n].position = .init(width: gesture.location.x, height: gesture.location.y)
                                            }
                                        }
                                        .onEnded { gesture in
                                            withAnimation {
                                                viewModel.cards[n].scale = 1.0
                                                if gesture.location.x > (Device.halfWidth) {
                                                    viewModel.cards[n].opacity = 0
                                                    viewModel.targetNumber -= viewModel.cards[n].number
                                                    
                                                    if viewModel.targetNumber == 0 {
                                                        viewModel.alertType = .Success
                                                        viewModel.showAlert = true
                                                    } else if viewModel.targetNumber < 0 {
                                                        viewModel.alertType = .Fail
                                                        viewModel.showAlert = true
                                                    }
                                                } else {
                                                    if let x = viewModel.checkThePoint(
                                                        current: CGPoint(x: viewModel.cards[n].position.width,
                                                                         y: viewModel.cards[n].position.height),
                                                        currentIndex : n
                                                    ) {
                                                        switch viewModel.operationType {
                                                            case .Plus :
                                                                viewModel.cards[x].number += viewModel.cards[n].number
                                                                viewModel.cards[n].opacity = 0
                                                            case .Minus :
                                                                viewModel.cards[x].number -= viewModel.cards[n].number
                                                                viewModel.cards[n].opacity = 0
                                                            case .Multiply :
                                                                viewModel.cards[x].number *= viewModel.cards[n].number
                                                                viewModel.cards[n].opacity = 0
                                                            case .Divide :
                                                                if viewModel.cards[n].number == 0 {
                                                                    viewModel.cards[n].position = viewModel.cardsBackup[n].position
                                                                } else {
                                                                    viewModel.cards[x].number /= viewModel.cards[n].number
                                                                    viewModel.cards[n].opacity = 0
                                                                }
                                                        }
                                                        
                                                    } else {
                                                        viewModel.cards[n].position = viewModel.cardsBackup[n].position
                                                    }
                                                }
                                            }
                                        }
                                )
                                .opacity(viewModel.cards[n].opacity)
                                .position(x: viewModel.cards[n].position.width, y: viewModel.cards[n].position.height)
                        }
                    }.coordinateSpace(name: "main")
                }
            }.frame(width : Device.halfWidth)
            Divider()
            // Right side
            VStack {
                Text("\(viewModel.targetNumber)")
                    .font(.system(size: 50, weight: .semibold, design: .monospaced))
            }.frame(width : Device.halfWidth)
            .background(
                VStack {
                    Spacer()
                    Color.blue.opacity(0.1)
                        .animation(.easeInOut(duration: 1.0), value : viewModel.targetNumber)
                        .frame(height : Device.height * CGFloat(Float(viewModel.targetNumber) / Float(viewModel.targetNumberBackup)))
                }.frame(height : Device.height)
            )
        }.animation(.default, value: UIScreen.main.bounds)
        .overlay(
            VStack {
                HStack {
                    Spacer()
                    Button {
                        viewModel.resetCards()
                    } label : {
                        Text(TextSet.Reset.rawValue)
                            .font(.system(size: 16, weight: .semibold, design: .monospaced))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    
                    Button {
                        onGame.toggle()
                    } label : {
                        Text(TextSet.Exit.rawValue)
                            .font(.system(size: 16, weight: .semibold, design: .monospaced))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }.padding()
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
        .alert(isPresented: $viewModel.showAlert) {
            switch viewModel.alertType {
                case .Success :
                    return Alert(title: Text(TextSet.SuccessCaseAlert.rawValue),
                                 message: Text(TextSet.SuccessCaseMessage.rawValue),
                                 dismissButton: .default(Text(TextSet.OK.rawValue)))
                case .Fail :
                    return Alert(title : Text(TextSet.FailCaseAlert.rawValue),
                                 message: Text(TextSet.FailCaseMessage.rawValue),
                                 dismissButton: .destructive(Text(TextSet.Retry.rawValue)) { viewModel.resetCards() }
                    )
                    
            }
        }
        .sheet(isPresented: $viewModel.showGuide) { GuideView(isPresented: $viewModel.showGuide) }
    }
}
