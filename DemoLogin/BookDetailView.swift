// BookDetailView.swift
// DemoLogin
// Created by Keshav Lohiya on 11/07/24.

import SwiftUI

struct ScannedBookDetailView: View {
    @ObservedObject var dataController: ScannedBookDataController
    let isbn: String
    
    var body: some View {
        VStack {
            if let book = dataController.book {
                if let item = book.items.first {
                    HStack(alignment: .top, spacing: 10) {
                        if let imageLinks = item.volumeInfo.imageLinks, let thumbnailURL = URL(string: imageLinks.thumbnail) {
                            AsyncImage(url: thumbnailURL) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image.resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 150)
                                case .failure:
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 150)
                                @unknown default:
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 150)
                                }
                            }
                            .cornerRadius(10)
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 150)
                                .cornerRadius(10)
                        }

                        VStack(alignment: .leading, spacing: 10) {
                            Text(item.volumeInfo.title)
                                .font(.title)
                                .fontWeight(.bold)

                            if let authors = item.volumeInfo.authors {
                                Text("Author(s): \(authors.joined(separator: ", "))")
                                    .font(.subheadline)
                            }

                            if let rating = item.volumeInfo.averageRating {
                                Text("Rating: \(rating)/5")
                                    .font(.subheadline)
                            }

                            if let retailPrice = item.saleInfo.retailPrice {
                                Text("Price: \(retailPrice.amount) \(retailPrice.currencyCode)")
                                    .font(.subheadline)
                            }

                            if let publisher = item.volumeInfo.publisher {
                                Text("Publisher: \(publisher)")
                                    .font(.subheadline)
                            }
                        }
                    }
                    .padding()

                    if let description = item.volumeInfo.description {
                        Text(description)
                            .padding()
                    }
                } else {
                    Text("No book details available")
                }
            } else {
                Text("Fetching book details...")
                    .onAppear {
                        dataController.fetchBookDetails(isbn: isbn)
                    }
            }
        }
        .padding()
    }
}
