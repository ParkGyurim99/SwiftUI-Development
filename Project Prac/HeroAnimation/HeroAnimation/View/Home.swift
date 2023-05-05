//
//  Home.swift
//  HeroAnimation
//
//  Created by Park Gyurim on 2023/05/04.
//

import SwiftUI

fileprivate enum HeroModalType: Hashable {
    case fullScreen
    case partial(type: ModalSize)
    
    func size() -> CGSize {
        switch self {
        case .fullScreen:
            return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        case .partial(let type):
            return CGSize(width: UIScreen.main.bounds.width * type.size.0, height: UIScreen.main.bounds.height * type.size.1)
        }
    }
    
    enum ModalSize: Hashable {
        case half
        case threeFourth
        case custom(width: CGFloat, height: CGFloat)
        
        var size: (CGFloat, CGFloat) {
            switch self {
            case .half: return (0.85, 0.5)
            case .threeFourth: return (0.9, 0.75)
            case .custom(width: let width, height: let height): return (width, height)
            }
        }
    }
}

struct Home: View {
    @State var currentItem: ColorValue?
    
    @State var expandCard: Bool = false
    @State var moveCardDown: Bool = false
    @State var animateContent: Bool = false
    @State var dragVerticalOffset: CGFloat = 0
    
    @State private var heroModalType: HeroModalType = .fullScreen
    private var size: CGSize { heroModalType.size() }
    
    @Namespace var animation
    
    private func getRGBValue(hex: String) -> (CGFloat, CGFloat, CGFloat) {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0
        let scanner = Scanner(string: hex)
        var hexNumber: UInt64 = 0

        if scanner.scanHexInt64(&hexNumber) {
            red = CGFloat((hexNumber & 0xff0000) >> 16) / 255
            green = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
            blue = CGFloat(hexNumber & 0x0000ff) / 255
        }
        
        return (red, green, blue)
    }
    
    private func present() {
        withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.4)) {
            moveCardDown = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 1, blendDuration: 1)) {
                expandCard = true
            }
        }
    }
    
    private func dismiss() {
        withAnimation(.easeInOut(duration: 0.2)) { animateContent = false }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeInOut(duration: 0.4)) {
                expandCard = false
                moveCardDown = false
            }
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                Picker("Modal Type", selection: $heroModalType) {
                    Text("Full").tag(HeroModalType.fullScreen)
                    Text("1/2").tag(HeroModalType.partial(type: .half))
                    Text("3/4").tag(HeroModalType.partial(type: .threeFourth))
                    Text("Custom").tag(HeroModalType.partial(type: .custom(width: 0.8, height: 0.4)))
                }.pickerStyle(.segmented)
                
                ScrollView(showsIndicators: false) {
                    ForEach(ColorValue.colors, id: \.id) { CardView(item: $0) }
                }
            }.padding()
            .padding(.top, 40)
            
            if let currentItem, expandCard {
                Color.black.opacity(0.5)
                
                DetailView(item: currentItem, rectSize: size)
                    .scaleEffect(1 - abs(dragVerticalOffset * 0.0003))
                    .animation(.default, value: dragVerticalOffset)
                    .offset(y: dragVerticalOffset)
                    .transition(.asymmetric(insertion: .identity, removal: .offset(y: 10)))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if abs(value.translation.height) > 70 { dismiss() }
                                else { dragVerticalOffset = value.translation.height }
                            }
                            .onEnded { _ in
                                DispatchQueue.main.async { dragVerticalOffset = 0 }
                            }
                    )
                    .onDisappear { dragVerticalOffset = 0 }
                    .zIndex(1000)
            }
        }.edgesIgnoringSafeArea(.all)
    }
    
    @ViewBuilder
    func DetailView(item: ColorValue, rectSize: CGSize) -> some View {
        VStack {
            ColorDetails(item: item)
            DetailViewContents(item: item)
        }.padding(.top, heroModalType == .fullScreen ? 40 : 0)
        .frame(width: rectSize.width, height: rectSize.height)
        .background(ColorView(item: item).shadow(radius: 4))
        .onTapGesture { dismiss() }
    }
    
    @ViewBuilder
    func DetailViewContents(item: ColorValue) -> some View {
        let (red, green, blue) = getRGBValue(hex: item.colorCode)
        
        VStack(spacing: 0) {
            Rectangle()
                .fill(.white)
                .frame(height: 1)
                .scaleEffect(x: animateContent ? 1 : 0.001, anchor: .leading)
            
            VStack {
                VStack (spacing: 30) {
                    CustomProgressView(value: red, label: "Red")
                    CustomProgressView(value: green, label: "Green")
                    CustomProgressView(value: blue, label: "Blue")
                }.padding()
                .background(
                    RoundedRectangle(cornerRadius: 15.0, style: .continuous)
                        .fill(.ultraThinMaterial)
                        .environment(\.colorScheme, .dark)
                )
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.white)
                        .padding()
                }.padding(.top)
            }.padding()
            .opacity(animateContent ? 1 : 0)
            .offset(y: animateContent ? 0 : 100)
            .animation(.easeInOut(duration: 0.5).delay(animateContent ? 0.2 : 0), value: animateContent)
        }.padding(.horizontal)
        .frame(maxHeight: .infinity, alignment: .top)
        .onAppear { withAnimation(.easeInOut.delay(0.2)) { animateContent = true } }
    }
 
    @ViewBuilder
    func CustomProgressView(value: CGFloat, label: String) -> some View {
        HStack(spacing: 15) {
            Text(label)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(width: 60)
            
            GeometryReader {
                let size = $0.size
                
                ZStack(alignment: .leading) {
                    Rectangle().fill(.black.opacity(0.75))
                    
                    Rectangle().fill(.white)
                        .frame(width: animateContent ? size.width * value : 0)
                }
            }.frame(height: 8)
            
            Text("\(Int(value * 255.0))")
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
    }
    
    @ViewBuilder
    func CardView(item: ColorValue) -> some View {
        let tappedCard = item.id == currentItem?.id && moveCardDown
        
        if !(item.id == currentItem?.id && expandCard) { // → Multiple views with same ID should be avoided
            ColorView(item: item)
                .overlay(ColorDetails(item: item))
                .frame(height: 110)
                .offset(y: tappedCard ? 30 : 0)
                .zIndex(tappedCard ? 100 : 0)
                .onTapGesture {
                    currentItem = item
                    present()
                }
        } else {
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 110)
        }
    }
    
    @ViewBuilder
    func ColorView(item: ColorValue) -> some View {
        Rectangle()
            .overlay(
                Rectangle().fill(item.color.gradient)
            )
            .overlay(
                Rectangle().fill(item.color.opacity(0.5).gradient)
                    .rotationEffect(Angle.degrees(180))
            )
            .matchedGeometryEffect(id: item.id.uuidString, in: animation)
    }
     
    @ViewBuilder
    func ColorDetails(item: ColorValue) -> some View {
        HStack {
            Text("#\(item.colorCode)")
                .font(.title.bold())
            Spacer()
            Text(item.title)
                .font(.system(size: 15, weight: .medium))
        }.foregroundColor(.white)
        .padding()
        .matchedGeometryEffect(id: item.id.uuidString + "_Title", in: animation)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
