//
//  ContentView.swift
//  CouponInfo
//
//  Created by Park Gyurim on 2022/02/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var showNavigationBar : Bool = false
    
    //@GestureState private var dragOffset = CGSize.zero
    //var navigationController : UINavigationController?
    
    init() {
        //navigationController?.interactivePopGestureRecognizer?.delegate = nil
//        //UINavigationBar.appearance().backgroundColor = .clear
//        //UINavigationBar.appearance().isTranslucent = false
//        //UINavigationBar.appearance().barTintColor = .white
//        //UINavigationBar.appearance().barStyle = .black
//        UINavigationBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment : .top) {
            ScrollView {
                VStack {
                   Color.blue
                       .frame(width : UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.35)
                   ForEach(0..<50) { i in
                       Text("Item \(i)")
                           .padding()
                   }
                }.frame(maxWidth : .infinity)
                .background(
                    GeometryReader {
                       Color.clear.preference(key: ScrollViewOffsetKey.self, value: -$0.frame(in: .named("scroll")).origin.y)
                   }
                )
                .onPreferenceChange(ScrollViewOffsetKey.self) {
                   print($0)
                    if $0 > 295.4 { withAnimation(.linear(duration: 0.5)) { showNavigationBar = true } }
                   else { withAnimation(.linear(duration: 0.5)) { showNavigationBar = false } }
                }
            }
            
            if showNavigationBar {
                VStack {
                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label : {
                            Image(systemName: "arrow.backward")
                                .font(.system(size : 20))
                                .foregroundColor(.black)
                        }
                        Spacer()
                        Text("Navigation Bar")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.vertical)
                        Spacer()
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size : 20))
                            .foregroundColor(.black)
                            .opacity(0)
                    }.padding(.horizontal)
                    Divider()
                }
                .frame(maxWidth : .infinity)
                .background(Color.white)
                .padding(.top, UIDevice.current.hasNotch ? UIScreen.main.bounds.height * 0.05 : UIScreen.main.bounds.height * 0.03)
            }
        }.edgesIgnoringSafeArea(.top)
        .coordinateSpace(name: "scroll")
        .navigationBarHidden(true)
    }
}

struct ScrollViewOffsetKey: PreferenceKey {
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

extension UINavigationController : UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    // MARK :  Navigation Stack에 쌓인 뷰가 1개를 초과해야 제스처가 동작 하도록
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
            return viewControllers.count > 1
    }

}
extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
    // EX) SomeView().background(UIDevice.current.hasNotch ? Color.red : Color.yellow)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
