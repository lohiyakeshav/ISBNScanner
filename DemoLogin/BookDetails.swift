// BookDataController.swift
// DemoLogin
// Created by Keshav Lohiya on 11/07/24.

import Foundation
import Combine

class ScannedBookDataController: ObservableObject {
    @Published var book: ScannedBook?

    func fetchBookDetails(isbn: String) {
        self.book = nil // Clear the current book details

        let urlString = "https://www.googleapis.com/books/v1/volumes?q=isbn:\(isbn)"
        guard let url = URL(string: urlString) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let book = try? JSONDecoder().decode(ScannedBook.self, from: data) {
                DispatchQueue.main.async {
                    self.book = book
                }
            } else {
                DispatchQueue.main.async {
                    self.book = nil
                }
            }
        }

        task.resume()
    }
}
