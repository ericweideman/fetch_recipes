//
//  RecipeListIcon.swift
//  Fetch_Recipes
//
//  Created by Eric Weideman on 10/24/24.
//

import Foundation
import SwiftUI

struct RecipeListItemIcon: View {
    var imageUrlString: String
    var imageUrl: URL? {
        return URL(string: imageUrlString)
    }
    
    var body: some View {
        if let imageUrl {
            if let cachedImage = ImageCache.getImage(url: imageUrl){
                Image(uiImage: cachedImage)
                    .RecipeIconViewModifer()
            }else {
                AsyncImage(url: imageUrl) { phase in
                    switch phase {
                    case .empty:
                        ZStack{
                            ProgressView()
                                .foregroundStyle(Color(.systemGray))
                                .frame(width: 50, height: 50)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    case .success(let image):
                        image
                            .RecipeIconViewModifer()
                            .onAppear{
                                cacheSwiftUIImage(image,imageUrl)
                            }
                    case .failure:
                        ZStack{
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundStyle(Color(.systemGray))
                                .frame(width: 50, height: 50)
                        }
                        .frame(width: 350, height: 350)
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            
        } else {
            EmptyView()
        }
    }
}

extension Image {
    func RecipeIconViewModifer() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 350, height: 350)
            .clipShape(Rectangle())
            .cornerRadius(8)
   }
}

@MainActor func cacheSwiftUIImage(_ image: Image, _ imageUrl: URL) {
    let renderer = ImageRenderer(content: image)
    if let renderedCGImage = renderer.cgImage {
        let uiImage =  UIImage(cgImage: renderedCGImage)
        DispatchQueue.global(qos: .background).async {
            try? ImageCache.writeImage(url: imageUrl, uiImage: uiImage)
            }
    }
}


