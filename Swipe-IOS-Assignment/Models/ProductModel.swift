import Foundation


struct Product: Identifiable,Decodable{
    
    var id = UUID()
    let image: String
    let price: Double
    let productName: String
    let productType: String
    let tax: Double
    
    
    enum CodingKeys: String, CodingKey {
    case image
    case price
    case productName = "product_name"
    case productType = "product_type"
    case tax
        }
    
}



class ProductViewModel {
    @Published var products: [Product] = []
    
    func fetchProducts(url: String) {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching products: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                DispatchQueue.main.async {
                    self.products = products
                }
            } catch {
                print("Error parsing products: \(error)")
            }
        }.resume()
    }
}
