//
//  FileManagerService.swift
//  Drink&Water
//
//  Created by Виктория Серикова on 27.03.2024.
//

import UIKit

class FileManagerService {
    static let shared = FileManagerService()

    private init() {}

    func saveImageToFileSystem(_ image: UIImage) -> String? {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return nil
        }
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = UUID().uuidString + ".jpg" 
        let fileURL = directory.appendingPathComponent(fileName)
        
        do {
            try data.write(to: fileURL)
            return fileName
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    func loadImageFromFileSystem(fileName: String) -> UIImage? {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = directory.appendingPathComponent(fileName)
        
        if let imageData = try? Data(contentsOf: fileURL) {
            return UIImage(data: imageData)
        } else {
            return nil
        }
    }
    
    
    func deleteImageFromFileSystem(fileName: String) {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = directory.appendingPathComponent(fileName)

        do {
            try FileManager.default.removeItem(at: fileURL)
            print("Successfully deleted old profile image.")
        } catch {
            print("Failed to delete old profile image: \(error)")
        }
    }
}

