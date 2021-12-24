//
//  ContentView.swift
//  DynamicShrinkImageSizePrac
//
//  Created by Park Gyurim on 2021/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ItemView()
        }
    }
}

struct ItemView : View {
    @State private var offset = CGSize.zero
    var body : some View {
        ZStack(alignment: .bottom) {
            VStack {
                Image("testImg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.4 + offset.height)
                    
                
                Spacer()
            }
            
            
            VStack {
                Text("Item name")
                Text("Item price")
                Text("Item description")
            }
            .frame(width : UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5)
            .background(Color.yellow)
            .offset(x: 0, y: offset.height)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        if -50 < gesture.translation.height && gesture.translation.height < 100 {
                            self.offset = gesture.translation
                        }
                        print(gesture.translation)
                    }

                    .onEnded { _ in
//                        if abs(self.offset.width) > 100 {
//                            // remove the card
//                        } else {
                        withAnimation {
                            self.offset = .zero
                        }
//                        }
                    }
            )
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Text("Item info"))
    }
}

//GeometryReader { proxy in
//    Image("testImg")
//        .resizable()
//        .aspectRatio(contentMode: .fill)
//        .frame(width : proxy.size.width, height: proxy.size.height)
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
