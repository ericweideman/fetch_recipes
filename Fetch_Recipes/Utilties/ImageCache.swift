//
//  ImageStore.swift
//  Fetch_Recipes
//
//  Created by Eric Weideman on 10/24/24.
//

import UIKit
import SwiftUI
import os.log

enum ImageCacheError: Error {
    case imageNotFound
    case imageWriteFailed
    case imageDataFailed
    case unsupportedImageFormat
    case directoryCreationFailed
}

class ImageCache {
    static private let logger = Logger(subsystem: "com.Fetch_Recipes", category: "imageCache")
    
    static func writeImage (url: URL, uiImage: UIImage) throws {
        
        guard let imageFileName = getUUIDForImage(fileName: url.absoluteString) else {
            logger.log("Failed to get UUID for image \(url.absoluteString)")
            throw ImageCacheError.imageWriteFailed
        }
            
        let imageFileType = url.pathExtension
        var imageData: Data?
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let fileURL = documentsDirectory.appendingPathComponent("images/\(imageFileName).\(imageFileType)")
        
        let imagesDirectory = documentsDirectory.appendingPathComponent("images")
        if !FileManager.default.fileExists(atPath: imagesDirectory.path) {
              do {
                  try FileManager.default.createDirectory(at: imagesDirectory, withIntermediateDirectories: true, attributes: nil)
              } catch {
                  throw ImageCacheError.directoryCreationFailed
              }
          }
        
        
        switch imageFileType.lowercased() {
        case "png":
              imageData = uiImage.pngData()
            break
        case "jpg", "jpeg":
            imageData = uiImage.jpegData(compressionQuality: 1.0)
        default:
            throw ImageCacheError.unsupportedImageFormat
        }
        
        guard let data = imageData else {
            throw ImageCacheError.imageDataFailed
        }
    
        do {
            try data.write(to: fileURL)
            logger.log("Image written to \(fileURL), file name: \(imageFileName).\(imageFileType)")
        } catch {
            throw ImageCacheError.imageWriteFailed
        }
    }
    
    static func getImage (url: URL) -> UIImage? {
        
        guard let imageFileName = getUUIDForImage(fileName: url.absoluteString) else {
            return nil
        }
        
        let imageFileType = url.pathExtension
      
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let fileURL = documentsDirectory.appendingPathComponent("images/\(imageFileName).\(imageFileType)")
        
        if let imageData = try? Data(contentsOf: fileURL) {
            let returnedImage = UIImage(data: imageData)
            guard let returnedImage else {
                return nil
            }
            logger.log("Image retrieved successfully from \(fileURL), file name: \(imageFileName).\(imageFileType)")
            return returnedImage
        }

        return nil
    }
    
    static func getUUIDForImage(fileName: String) -> String? {
        
        let guidPattern = "[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}"
        
        if let range = fileName.range(of: guidPattern, options: .regularExpression) {
            let guid = String(fileName[range])
            return guid
        } else {
            return nil
        }
    }
}

