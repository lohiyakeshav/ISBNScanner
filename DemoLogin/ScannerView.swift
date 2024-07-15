// ScannerView.swift
// DemoLogin
// Created by Keshav Lohiya on 03/07/24.

import SwiftUI

struct ScannerView: View {
    @State private var scannedCode: String?
    @State private var isShowingScanner = false
    @StateObject private var dataController = ScannedBookDataController()

    var body: some View {
        VStack {
            Text("Scan ISBN Barcode")
                .font(.largeTitle)
                .padding(.bottom, 40)

            if let code = scannedCode {
                ScannedBookDetailView(dataController: dataController, isbn: code)
            } else {
                Text("No ISBN scanned yet")
                    .padding()
            }

            Button(action: {
                self.isShowingScanner = true
            }) {
                Text("Start Scanning")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.blue)
                    .cornerRadius(15.0)
            }
            .sheet(isPresented: $isShowingScanner) {
                BarcodeScannerView {
                    self.scannedCode = $0
                    self.dataController.fetchBookDetails(isbn: $0) // Fetch new book details
                    self.isShowingScanner = false
                }
            }
        }
        .padding()
    }
}
