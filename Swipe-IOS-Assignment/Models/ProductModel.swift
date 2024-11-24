import Foundation


struct Product: Identifiable,Decodable{
    
    var id = UUID()
    let image: String
    let price: Double
    let productName: String
    let productType: String
    let tax: Double
    var isFavorited = false
    
    enum CodingKeys: String, CodingKey {
    case image
    case price
    case productName = "product_name"
    case productType = "product_type"
    case tax
        }
    
}




