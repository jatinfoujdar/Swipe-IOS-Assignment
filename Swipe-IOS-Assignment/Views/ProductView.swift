import SwiftUI


struct ProductView: View {
    @StateObject var viewModel = ProductViewModel()
    let url: String = "https://app.getswipe.in/api/public/get" 
    
    var body: some View {
        List(viewModel.products, id: \.id) { product in
            VStack(alignment: .leading) {
                Text(product.productName)
                Text("Price: \(product.price)")
                Text("Type: \(product.productType)")
            }
        }
        .onAppear {
            viewModel.fetchProducts(url: url)
        }
    }
}

#Preview {
    ProductView()
}
