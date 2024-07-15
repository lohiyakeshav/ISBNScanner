// BookModel.swift
// DemoLogin
// Created by Keshav Lohiya on 11/07/24.

import Foundation

struct ScannedBook: Codable {
    let items: [ScannedItem]
    
    struct ScannedItem: Codable {
        let volumeInfo: ScannedVolumeInfo
        let saleInfo: ScannedSaleInfo
        
        struct ScannedVolumeInfo: Codable {
            let title: String
            let authors: [String]?
            let description: String?
            let publisher: String?
            let averageRating: Double?
            let previewLink: String?
            let imageLinks: ScannedImageLinks?
            
            struct ScannedImageLinks: Codable {
                let smallThumbnail: String
                let thumbnail: String
            }
        }
        
        struct ScannedSaleInfo: Codable {
            let retailPrice: ScannedPrice?
            
            struct ScannedPrice: Codable {
                let amount: Double
                let currencyCode: String
            }
        }
    }
}
