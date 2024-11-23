// ProductView.swift

import SwiftUI

struct ProductView: View {
    @StateObject var viewModel = ProductViewModel()
    let url: String = "https://app.getswipe.in/api/public/get"
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.products, id: \.id) { product in
                    VStack(alignment: .leading) {
                        if let url = URL(string: product.image),
                           let imageData = try? Data(contentsOf: url),
                           let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(width: 150, height: 150)
                                .cornerRadius(10)
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 150, height: 150)
                                .cornerRadius(10)
                        }
                        
                        Text(product.productName)
                            .font(.title2)
                        Text("Price: \(String(format: "%.2f", product.price))")
                            .foregroundColor(.secondary)
                        Text("Type: \(product.productType)")
                            .foregroundColor(.secondary)
                        Text("Tax: \(String(format: "%.2f", product.tax))")
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchProducts(url: url)
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView()
    }
}
