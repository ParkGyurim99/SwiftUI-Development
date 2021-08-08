//
//  ContentView.swift
//  DataCaching
//
//  Created by Park Gyurim on 2021/08/08.
//
// ref : https://www.youtube.com/watch?v=yXSC6jTkLP4
//

import SwiftUI

class CacheManager {
    static let instance = CacheManager() // singleton pattern
    /* when we create singleton , it basically means that this is going to be the only instance of this cachemanager and in entire app */
    
    // private init -> we can 'only' initialize this class within the class
    private init() { }
    
    var imageCache : NSCache<NSString, UIImage> // <key type, value type>
        = {
            let cache = NSCache<NSString, UIImage>()
            // made this so that we can customize this cache before return
            cache.countLimit = 100
            cache.totalCostLimit = 1024 * 1024 * 100 // 100MB
            return cache
        }()
    
    func add(uiImage : UIImage, name : String) -> String {
        imageCache.setObject(uiImage, forKey: name as NSString)
        return "Added to cache!"
    }
    func remove(name : String) -> String {
        imageCache.removeObject(forKey: name as NSString)
        return "Removed from cache!"
    }
    func get(name : String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
}

class CacheViewModel : ObservableObject {
    @Published var startingImage : UIImage?
    @Published var cachedImage : UIImage?
    @Published var infoMessage = ""
    
    let imageName : String = "image1"
    let manager = CacheManager.instance
     
    init() {
        getImageFromAssetsFolder()
    }
    
    func getImageFromAssetsFolder() {
        startingImage = UIImage(named : imageName)
    }
    
    func saveToCache() {
        guard let image = startingImage else {return} // unwrapping
        infoMessage = manager.add(uiImage: image, name: imageName)
    }
    func removeFromCache() {
        infoMessage = manager.remove(name: imageName)
    }
    func getFromCache() {
        if let returnedImage = manager.get(name : imageName) {
            cachedImage = returnedImage
            infoMessage = "Got Image from Cache"
        } else {
            cachedImage = nil
            infoMessage = "Image not found in Cache "
        }
    }
}

struct ContentView: View {
    @StateObject var viewmodel = CacheViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                if let image = viewmodel.startingImage {
                    //Image("image1")
                    Image(uiImage : image)
                        .resizable()
                        .scaledToFill()
                        .frame(width : 200, height : 200)
                        .clipped()
                        .cornerRadius(10)
                }
                Text(viewmodel.infoMessage)
                    .font(.headline)
                    .foregroundColor(.purple)
                
                HStack {
                    Button {
                        viewmodel.saveToCache()
                    } label : {
                        Text("Save to Cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    Button {
                        viewmodel.removeFromCache()
                    } label : {
                        Text("Delete from Cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }
                Button {
                    viewmodel.getFromCache()
                } label : {
                    Text("Get from Cache")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                if let image = viewmodel.cachedImage {
                    //Image("image1")
                    Image(uiImage : image)
                        .resizable()
                        .scaledToFill()
                        .frame(width : 200, height : 200)
                        .clipped()
                        .cornerRadius(10)
                }
                Spacer()
            }
            .navigationTitle("Data Caching")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
