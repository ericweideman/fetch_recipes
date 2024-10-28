//
//  ImageCache_Tests.swift
//  Fetch_Recipes
//
//  Created by Eric Weideman on 10/26/24.
//

import XCTest
@testable import Fetch_Recipes

class ImageCacheTests: XCTestCase {
    
    var testURL: URL!
    var testImage: UIImage!
    
    override func setUpWithError() throws {
        // Create a temporary URL for testing
        testURL = URL(string: "testUUID-123e4567-e89b-12d3-a456-426614174000.png")
        testImage = UIImage(systemName: "star") // Sample image
    }
    
    override func tearDownWithError() throws {
        // Remove any test images created in the directory after each test
        if let fileURL = ImageCache.getImageFileURL(url: testURL) {
            try? FileManager.default.removeItem(at: fileURL)
        }
        testURL = nil
        testImage = nil
    }
    
    func testWriteImage() throws {
        // Test that writeImage successfully writes an image
        XCTAssertNoThrow(try ImageCache.writeImage(url: testURL, uiImage: testImage))
        
        let fileURL = ImageCache.getImageFileURL(url: testURL)
        XCTAssertTrue(FileManager.default.fileExists(atPath: fileURL?.path ?? ""), "Image file should exist after writing.")
    }
    
    func testWriteImageWithUnsupportedFormat() throws {
        // Test that unsupported image format throws an error
        let unsupportedURL = URL(string: "testUUID-123e4567-e89b-12d3-a456-426614174000.bmp")!
        
        XCTAssertThrowsError(try ImageCache.writeImage(url: unsupportedURL, uiImage: testImage)) { error in
            XCTAssertEqual(error as? ImageCacheError, ImageCacheError.unsupportedImageFormat)
        }
    }
    
    func testGetImage() throws {
        // Test that getImage retrieves a previously written image
        try ImageCache.writeImage(url: testURL, uiImage: testImage)
        
        let retrievedImage = ImageCache.getImage(url: testURL)
        XCTAssertNotNil(retrievedImage, "Retrieved image should not be nil.")
    }
    
    func testGetImageNotFound() throws {
        // Test that getImage returns nil for an image that doesn't exist
        let nonExistentURL = URL(string: "testUUID-1111-2222-3333-444444444444.png")!
        
        let retrievedImage = ImageCache.getImage(url: nonExistentURL)
        XCTAssertNil(retrievedImage, "Retrieved image should be nil for a non-existent image.")
    }
}

extension ImageCache {
    static func getImageFileURL(url: URL) -> URL? {
        guard let imageFileName = getUUIDForImage(fileName: url.absoluteString) else {
            return nil
        }
        let imageFileType = url.pathExtension
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory.appendingPathComponent("images/\(imageFileName).\(imageFileType)")
    }
}
