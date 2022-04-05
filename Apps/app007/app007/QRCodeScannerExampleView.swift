import SwiftUI

struct QRCodeScannerExampleView: View {
    @State var isPresentingScanner = false
    @State var scannedCode: String?

    var body: some View {
        ZStack(alignment: .bottom) {
            if self.scannedCode != nil {
                myWebView(urlToLoad : self.scannedCode!)
//                Text(self.scannedCode!)
            }
//            else {
//                myWebView(urlToLoad : "https://www.apple.com")
//            }
            
            Button(action : {
                self.isPresentingScanner = true
            }){
                HStack(spacing : 0) {
                    Image("qrcode")
                        .resizable()
                        .frame(width : 50, height: 50)
                    Text("QR Code Scan")
                        .foregroundColor(.black)
                        .font(.system(size : 20))
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
//                        .overlay(RoundedRectangle(cornerRadius: 12)
//                                    .stroke(lineWidth: 5)
//                                    .foregroundColor(.yellow)
//                        )
                }
                .overlay(RoundedRectangle(cornerRadius: 12)
                            .stroke(lineWidth: 5)
                            .foregroundColor(.yellow)
                )
            }.padding()
            .sheet(isPresented: $isPresentingScanner) { // 아래에서 위로 올라오는 뷰
                self.scannerSheet
            }
        }
    }

    var scannerSheet : some View {
        ZStack {
            CodeScannerView(
                codeTypes: [.qr],
                completion: { result in
                    if case let .success(code) = result {
                        self.scannedCode = code
                        self.isPresentingScanner = false
                    } // 클로저 ,, 뷰 파라미터로 코드타입, 컴플레이션 들어감
                }
            )
            
            QRCodeGuideLineView() // 스캔 가이드라인 (네모칸) 만들어주는 것
                .foregroundColor(.yellow)
        }
    }
}
