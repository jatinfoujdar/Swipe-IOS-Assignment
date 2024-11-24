import SwiftUI

struct ProductView: View {
    @StateObject var viewModel = ProductViewModel()
    @State private var searchText = ""
    @State private var favourite = false
    
    let url: String = "https://app.getswipe.in/api/public/get"


      enum SortOption: String, CaseIterable {
        case name = "Name"
        case price = "Price"
        case tax = "Tax"
        
        var localized: String {
            switch self {
            case .name:
                return "Name"
            case .price:
                return "Price"
            case .tax:
                return "Tax"
            }
        }
    }
    
    @State private var selectedSortOption: SortOption = .name
    @State private var showFilterMenu = false
    
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
   
    var filteredProducts: [Product] {
        let filtered = viewModel.products.filter { product in
            searchText.isEmpty ||
            product.productName.lowercased().contains(searchText.lowercased()) ||
            product.productType.lowercased().contains(searchText.lowercased())
        }
        
      
        switch selectedSortOption {
        case .name:
            return filtered.sorted { $0.productName < $1.productName }
        case .price:
            return filtered.sorted { $0.price < $1.price }
        case .tax:
            return filtered.sorted { $0.tax < $1.tax }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
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
                                
                                HStack {
                                    Text(product.productName)
                                        .fontWeight(.heavy)
                                    Spacer()
                                    Image(systemName: "heart")

                                };                                 Text("Price: \(String(format: "%.2f", product.price))")
                                    .font(.custom("HelveticaNeue-Bold", size: 16))
                                    .foregroundColor(Color.gray)
                                
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
                .toolbar {
                    
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {
                            showFilterMenu.toggle()
                        }) {
                            Image(systemName: "line.horizontal.3.decrease.circle")
                                .font(.title2)
                        }
                        .actionSheet(isPresented: $showFilterMenu) {
                            ActionSheet(
                                title: Text("Filter Options"),
                                message: Text("Select your filter criteria"),
                                buttons: [
                                    .default(Text("Sort by Price")) {
                                        selectedSortOption = .price
                                    },
                                    .default(Text("Sort by Tax")) {
                                        selectedSortOption = .tax
                                    },
                                    .default(Text("Sort by Name")) {
                                        selectedSortOption = .name
                                    },
                                    .cancel()
                                ]
                            )
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ProductView()
}
