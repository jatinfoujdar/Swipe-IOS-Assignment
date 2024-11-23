import SwiftUI

struct ProductView: View {
    @StateObject var viewModel = ProductViewModel()
    @State private var searchText = ""
    
    let url: String = "https://app.getswipe.in/api/public/get"
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return viewModel.products
        } else {
            return viewModel.products.filter { product in
                product.productName.lowercased().contains(searchText.lowercased()) ||
                product.productType.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(filteredProducts, id: \.id) { product in
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
            .searchable(text: $searchText)
            .navigationTitle("Products")
        }
    }
}

#Preview {
    ProductView()
}
