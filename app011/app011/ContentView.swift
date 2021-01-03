//
//  ContentView.swift
//  app011
//
//  Created by 박규림 on 2021/01/03.
//

import SwiftUI

struct ContentView: View {
    @State var selectionValue = 0
    var matchedColor : [String] = ["레드", "그린", "블루"]
    
    func selectedColor(selectionValue : Int) -> Color {
        switch selectionValue {
        case 0 :
            return Color.red
        case 1 :
            return Color.green
        case 2 :
            return Color.blue
        default :
            return Color.black
        }
    }
    
    var body: some View {
        VStack(alignment : .center) {
            Circle()
                .foregroundColor(selectedColor(selectionValue: selectionValue))
                .frame(width : 50, height: 50)
            
            Text("segment value : \(selectionValue)")
            Text("선택된 색상 : \(matchedColor[selectionValue])")
            
            
            Picker("Color", selection: $selectionValue) {
                Text("레드").tag(0)
                Text("그린").tag(1)
                Text("블루").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Picker("Color", selection: $selectionValue
                   , content: {
                Text("레드").tag(0)
                Text("그린").tag(1)
                Text("블루").tag(2)
            })
                .frame(width : 100, height: 150)
                .clipped() // 튀어나오는 거 자르기
                .border(selectedColor(selectionValue: selectionValue), width: 10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
