//
//  ContentView.swift
//  PreferencesPrac
//
//  Created by Park Gyurim on 2023/05/22.
//

import SwiftUI

///
/// ## Preferences
///
/// - **하위 뷰 → 상위 뷰** 로 값을 넘길때 사용
/// - `@Environment` 사용해서 정의 된 값 접근 가능
///
/// - PreferenceKey 를 사용해서 custom preference 를 정의해서 사용
///     - PreferenceKey protocol 을 confom 하는 custom PreferenceKey 등록
///
/// - 여러 하위 뷰에서 상위 뷰로 전달할때 어떤 값을 사용할지 정의 → `reduce(...)`
///
/// - 하위 뷰에서 `.preference` 로 key, value 전달
/// - 상위 뷰에서 `.onPreferenceChange` 로 값 받아 사용
///
/// With `Preferences` and `PreferencesKey`,
/// you can pass data between views **without relying on explicit data passing**
/// and maintain a shared state throughout the view hierarchy.
///
/// ### ChatGPT
/// Q. I think it doesn't work with child view in navigation link. Is that right?
/// A. You're correct. The `onPreferenceChange` modifier may not work directly with child views within a NavigationLink
///    because **the view hierarchy is different when transitioning to a new view**
///
/// ### [Preferences](https://developer.apple.com/documentation/swiftui/preferences)
/// However, unlike configuration information that flows down a view hierarchy from one container to many subviews,
/// a single container needs to **reconcile potentially conflicting preferences flowing up from its many subviews.**
/// 그니까 바인딩으로 처리할 수 있지만, 여러 하위 뷰에서 동일한 값을 다룰 수 도 있잖슴? 그러니까 `reduce` 같은 애들도 있고 해서
/// 약간 암시적으로 뷰 하이어라키 간 데이터 플로우를 정의하는 거
///

struct TitleKey: PreferenceKey {
    typealias Value = String // 명시적으로 defaultValue 타입 지정했으니까 생략 가능
    
    static var defaultValue: String = "title"
    
    static func reduce(value: inout String, nextValue: () -> String) { value = nextValue() }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            ParentView()
        }
    }
}

struct ParentView: View {
    @State var title: String = ""
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .padding()

            // NavigationLink 에서 동작 X → 새로운 뷰 하이어라키를 가지잖아
            NavigationLink(destination: ChildView()) {
                Text("Child View")
            }
            
            Spacer()
            
            ChildView()
        }.padding()
        .navigationTitle("Parent View")
        .onPreferenceChange(TitleKey.self) { newValue in title = newValue }
    }
}

struct ChildView: View {
    @State var title: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter the title", text: $title)
                .keyboardType(.webSearch)
            
            Spacer()
        }.padding()
        .navigationTitle("Child View")
        .preference(key: TitleKey.self, value: title)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
