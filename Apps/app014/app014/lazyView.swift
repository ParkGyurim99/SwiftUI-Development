//
//  lazyView.swift
//  app014
//
//  Created by 박규림 on 2021/01/07.
//

import SwiftUI

enum layoutType : CaseIterable {
    case table, grid, multiple
}

extension layoutType {
    // 레이아웃 타입에 대한 컬럼이 자동으로 설정되도록 한다.
    var columns : [GridItem] {
        switch self {
        case .table :
            return [
                //flexible 하나로 한줄로 표현
                GridItem(.flexible())
            ]
        case .grid :
            return [
                // flexible 두개를 넣어서 두개 아이템 들어가게 만듦
                GridItem(.flexible()),
                GridItem(.flexible())
            ]
        case .multiple :
            return [
                // adaptive를 통해 크기 닿는데 까지 아이템 여러개 넣기
                GridItem(.adaptive(minimum: 100))
            ]
        }
    }
}

struct lazyView : View {
    @State var selectedValue : Int = 1
    
    var body : some View {
        VStack {
            Picker(selection: $selectedValue, label: Text("Picker"), content: {
                Image(systemName: "list.dash").tag(1)
                Image(systemName: "square.grid.2x2.fill").tag(2)
                Image(systemName: "square.grid.3x3.fill").tag(3)
            })
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 50)
        
            Spacer().frame(height : 30)
            
            ScrollView {
                switch selectedValue {
                    case 1:
                        VStack (spacing : 15) {
                            ForEach(Range(1...100)) { _ in
                                HStack(spacing : 20) {
                                    Image(systemName: "book.fill")
                                        .font(.system(size : 30))
                                    VStack(alignment: .leading, spacing : 0){
                                        Text("Reading Book")
                                            .font(.system(size: 20))
                                            .fontWeight(.bold)
                                        Divider()
                                            .frame(height : 0)
                                            .opacity(0)
                                        Text("1PM - 3PM")
                                    }
                                }
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(20)
                            }
                        }
                        
                        case 2:
                            LazyVGrid(columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ], content: {
                                ForEach(Range(1...100)) { index in
                                    VStack{
                                        Circle()
                                            .foregroundColor(.black)
                                            .frame(width : 80, height: 80)
                                        Text("타이틀 : \(index)")
                                        Text("서브 타이틀 : \(index)")
                                    }
                                    .frame(width : 150, height: 150)
                                    .padding()
                                    .background(Color.init(#colorLiteral(red: 0.9893075824, green: 0.5173201561, blue: 0.4637610912, alpha: 1)))
                                    .cornerRadius(20)
                                }
                            })
                        case 3:
                            LazyVGrid(columns: [
                                GridItem(.adaptive(minimum: 100))
                            ], content: {
                                ForEach(Range(1...100)) { _ in
                                    Rectangle().background(Color.black)
                                        .frame(height : 110)
                                }
                            })
                            
                        default:
                            Text("")
                } // switch
                
            } // scrollView
            .animation(.easeInOut)
            .padding(.horizontal, 10)
        } // VStack
        
        
    } // body
}
