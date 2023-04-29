import SwiftUI
import Alamofire
import Combine
import Kingfisher
import AdvancedScrollView

public struct MyView: View {
    @StateObject private var viewModel = MyViewModel()
    
    public init() { }
    
    public var body: some View {
        Button("Hello, Tuist!") {
            viewModel.fetch()
        }.padding()
        
    
        VStack {
            if let data = viewModel.data {
                if viewModel.loading {
                    ProgressView()
                } else {
                    Text(data.title)
                        .font(.title2)
                        .padding()
                }
            } else {
                NavigationLink(destination:
                    AdvancedScrollView()
                        .navigationBarHidden(true)
                               
                ) {
                    KFImage(URL(string: "https://images.unsplash.com/photo-1481349518771-20055b2a7b24?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cmFuZG9tfGVufDB8fDB8fA%3D%3D&w=1000&q=80"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)
                }
            }
        }.frame(height: UIScreen.main.bounds.height * 0.125)
        
        Button{
            viewModel.data = nil
        } label: {
            Image(systemName: "xmark")
                .padding()
        }
    }
}

fileprivate final class MyViewModel: ObservableObject {
    @Published var data: Response?
    @Published var loading: Bool = false
    
    private let url = "https://jsonplaceholder.typicode.com/todos/"
    
    private var num = 1
    private var subscription = Set<AnyCancellable>()
    
    func fetch() {
        loading = true
        
        AF.request(
            url + "\(num)",
            method: .get
        ).publishDecodable(type: Response.self)
        .compactMap { $0.value }
            .sink {  completion in
                self.loading = false
                
                switch completion {
                    case .failure(_):
                        print("Fetch failed")
                    case .finished:
                        print("Fetch finished")
                        self.num += 1
                }
            } receiveValue: {
                self.data = $0
            }.store(in: &subscription)
    }
}

fileprivate struct Response: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
