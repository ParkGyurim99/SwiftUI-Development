//
//  closetView.swift
//  WIT_combine
//
//  Created by Park Gyurim on 2021/05/24.
//

import SwiftUI

var products : [Product] = [
    Product(name: "코듀로이 오버 칼라 아노락 스웨트셔츠", cate: "upper", subCate: "short", image : "product1", brand: "라퍼지스토어", price: 26535),
    Product(name: "CREW NECK RIB KNIT SWEATER_BROWN", cate: "upper", subCate: "short", image : "product2", brand: "BLOND9", price: 30000),
    Product(name: "Half-neck Sweat L/beige", cate: "upper", subCate: "short", image : "product3", brand: "JEEP", price: 59000),
    Product(name: "아치 로고 맨투맨 네이비", cate: "upper", subCate: "short", image : "product4", brand: "COVERNOT", price: 57000),
    Product(name: "SIGNATURE HOODIE_lemon", cate: "upper", subCate: "short", image : "product5", brand: " 5252BYOIOI", price: 43371),
    Product(name: "SIGNATURE HOODIE_light purple", cate: "upper", subCate: "hoodie", image : "product6", brand: "5252BYOIOI", price: 43371),
    Product(name: "Basic Logo Hood D/Pink", cate: "upper", subCate: "hoodie", image : "product7", brand: "JEEP", price: 89000),
    Product(name: "purple 맨투맨", cate: "upper", subCate: "short", image : "product8", brand: "라퍼지스토어", price: 28000),
    Product(name: "purple 맨투맨", cate: "upper", subCate: "long", image : "product9", brand: "라퍼지스토어", price: 28000),
    Product(name: "purple 맨투맨", cate: "upper", subCate: "long", image : "product10", brand: "라퍼지스토어", price: 28000),
    Product(name: "purple 맨투맨", cate: "upper", subCate: "long", image : "product11", brand: "라퍼지스토어", price: 28000),
    Product(name: "purple 맨투맨", cate: "upper", subCate: "long", image : "product12", brand: "라퍼지스토어", price: 28000),
    Product(name: "purple 맨투맨", cate: "upper", subCate: "short", image : "product13", brand: "라퍼지스토어", price: 28000),

    Product(name : "코스모 밴딩 쇼츠", cate : "bottom", subCate : "Shorts", image : "bottom1", brand : "제멋", price : 29800),
    Product(name : "그라미치", cate : "bottom", subCate : "Chino", image : "bottom2", brand : "그라미치", price : 119000),
    Product(name : "스티치 포인트 데님 팬츠", cate : "bottom", subCate : "Jean", image : "bottom3", brand : "알디브이제트", price : 10900),
    Product(name : "카고 조거 팬츠", cate : "bottom", subCate : "Jean", image : "bottom4", brand : "스컬프터", price : 82800),
    Product(name : "인디고 데님 쇼츠", cate : "bottom", subCate : "Shorts", image : "bottom5", brand : "유니폼브릿지", price : 53000),
    Product(name : "에센셜 숏 팬츠", cate : "bottom", subCate : "Shorts", image : "bottom6", brand : "아디아스", price : 37900),
    Product(name : "루즈테이퍼드 팬츠", cate : "bottom", subCate : "Chino", image : "bottom7", brand : "그라미치", price : 119000),
    Product(name : "Twill Pants", cate : "bottom", subCate : "Chino", image : "bottom8", brand : "예스아이씨", price : 99000),
    Product(name : "Mine worker ST", cate : "bottom", subCate : "Jean", image : "bottom9", brand : "피스워크", price : 80100),
    Product(name : "Pin tuck wide denim", cate : "bottom", subCate : "Jean", image : "bottom10", brand : "유니폼브릿지", price : 62000),
    
    Product(name: "올드스쿨 - 블랙 / VN000D3HY281", cate: "shoes", subCate: "sneakers", image : "shoes1", brand: "vans", price: 69000),
    Product(name: "어센틱 44 DX - 클래식 화이트 ", cate: "shoes", subCate: "sneakers", image : "shoes2", brand: "vans", price: 85000),
    Product(name: "척테일러 올스타 블랙 하이 M9160C", cate: "shoes", subCate: "sneakers", image : "shoes3", brand: "converse", price: 59000),
    Product(name: "척테일러 올스타 무브 블랙 570256C", cate: "shoes", subCate: "sneakers", image : "shoes4", brand: "converse", price: 79000),
    Product(name: "올드스쿨 뮬 - 클래식화이트/트루화이트", cate: "shoes", subCate: "sneakers", image : "shoes5", brand: "vans", price: 51800),
    Product(name: " 올드스쿨 - 레드 / VN000VOKDIC1 ", cate: "shoes", subCate: "sneakers", image : "shoes6", brand: "vans", price: 69000),
    Product(name: "취리히 SFB 타우페", cate: "shoes", subCate: "slipper",  image : "shoes7", brand: "BIRKENSTOCK", price: 92000),
    Product(name: "제로비티 플립플랍", cate: "shoes", subCate: "slipper", image : "shoes8", brand: "Taw&Toe", price: 38000),
]

struct closetView: View {
    let category : String
    @State var showingSheet = false
    
    var body: some View {
        ScrollView {
            Spacer().frame(height : 10)
            
            LazyVGrid(columns: [
                GridItem(.flexible(maximum: 140)),
                GridItem(.flexible(maximum: 140))
            ], spacing : 15) {
                ForEach(products, id : \.self) { product in
                    if (product.cate == category) {
                        NavigationLink(destination: itemInfo(product : product)) {
                            Image(product.image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width : UIScreen.main.bounds.width * 0.3456)
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(radius: 5)
                        }
                    }
                }
            }
            //.background(Color.secondary)
            
        } // scrollview
        .navigationBarTitle(Text(category), displayMode: .inline)
    }
}

struct itemInfo : View {
    @State var product: Product
    @State var isClicked : Bool = false
    @State private var scaleValue = CGFloat(1)
    @State private var heartBtnColor : Color = Color.white

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Image(product.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: 360)
                        // tap effect
                        .scaleEffect(self.scaleValue)
                        .onTapGesture {
                            withAnimation { self.scaleValue = 1.05 }
                            withAnimation(Animation.linear.delay(0.2)) { self.scaleValue = 1.0 }
                        }
                        .padding(.top, 10)
                    Spacer()
                }
                .overlay(
                    Rectangle()
                        .frame(width : UIScreen.main.bounds.width)
                        .background(LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom))
                        .opacity(0.1)
                )
                
                VStack {
                    Spacer()
                    // Text Information
                    VStack {
                        Spacer()
                            .frame(height : 30)
                        
                        HStack {
                            Text(product.name)
//                                .font(.custom("Roboto Regular", size: 30))
                                .font(.system(size : 30))
                                .bold()
                                .padding(.horizontal, 20)
                            Spacer()
                        }
                        
                        HStack {
                            Text("\(product.cate) > \(product.subCate)")
                                .font(.custom("Roboto Regular", size: 20))
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)

                        
                        HStack {
                            Spacer()
                            Text("₩\(product.price)")
                                .font(.custom("Roboto Regular", size: 30))
                        }
                        .padding(.horizontal, 20)

                        Spacer()
                        HStack {
                            Button(action: {
                                product.isBookmarked.toggle()
                            }, label: {
                                Image(systemName: "suit.heart.fill")
                                    .font(.system(size : 30))
                                    .frame(width : 70, height : 70)
                                    .foregroundColor(product.isBookmarked ? Color.red : Color.white)
                                    .background(Color.secondary)
                                    .cornerRadius(15)
                            })
                            
                            Text("이 옷과 어울리는 옷 보기")
                                .frame(width: geometry.size.width * 0.7, height: 70)
                                .foregroundColor(Color.white)
                                .background(Color.secondary)
                                .cornerRadius(15)
                                .onTapGesture {
                                    isClicked = true
                                }
                        } // HStack
                        .shadow(radius: 5)
                        .padding(.bottom, 40)
                    } // VStack
                    .background(product.avgColor)
                    .background(LinearGradient(gradient: Gradient(colors: [product.avgColor, product.avgColor.opacity(0.7)]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(30)
                    .frame(height : geometry.size.height / 2)
                    // Text Information
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle(Text(product.brand), displayMode: .inline)//, displayMode: .inline)
            .sheet(isPresented: $isClicked) {
                recommendItemView(product: product, isClicked: $isClicked)
            }
        }

    }
}

struct recommendItemView : View {
    let product : Product
    @Binding var isClicked : Bool
    
    var body : some View {
        VStack {
            Text("이 옷과 어울리는 아이템")
                .font(.system(size : 30))
                .bold()
                .frame(width : UIScreen.main.bounds.width, height : UIScreen.main.bounds.height * 0.3)
                .background(product.avgColor)
                .overlay(Rectangle()
                            .background(LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom)
                                )
                            .opacity(0.1)
            )
        }
        .frame(width : UIScreen.main.bounds.width)
        
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible(maximum: 140)),
                GridItem(.flexible(maximum: 140))
            ]) {
                ForEach(recommendMethod(avgColor: product.avgColor), id : \.self) { rcmdClothes in
                    if ((product.name != rcmdClothes.name) && (product.cate != rcmdClothes.cate)) {
                        VStack {
                            Image(rcmdClothes.image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .padding(12)
                            Text(rcmdClothes.name)
                        }
                        .frame(width : UIScreen.main.bounds.width / 4)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .padding()
                    }
                }
            }.padding()
        } // scrollview
    }
    
    func recommendMethod(avgColor : Color) -> [Product] {
        var recommendClothes : [Product] = []
        let compareColor = UIColor(avgColor)
        let rgbColor = compareColor.cgColor
        let rgbColors = rgbColor.components // array element
        print("\(rgbColors![0]) \(rgbColors![1]) \(rgbColors![2])")
        for i in 0..<products.count {
            let thisColor = UIColor(products[i].avgColor)
            let thisRgbColor = thisColor.cgColor
            let thisRgbColors = thisRgbColor.components
            
            if ((abs(thisRgbColors![0] - rgbColors![0]) < 0.35) && (abs(thisRgbColors![1] - rgbColors![1]) < 0.35) && (abs(thisRgbColors![2] - rgbColors![2]) < 0.35)) {
                recommendClothes.append(products[i])
            }
        }
        return recommendClothes
    }
}
