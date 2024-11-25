import SwiftUI

struct AddProductView: View {
    @State private var productName: String = ""
    @State private var productType: String = ""
    @State private var price: String = ""
    @State private var tax: String = ""
    @State private var image: Image? = nil

    var body: some View {
        Form {
            Section(header: Text("Product Details")) {
                TextField("Product Name", text: $productName)
                TextField("Product Type", text: $productType)
                TextField("Price", text: $price)
                    .keyboardType(.decimalPad)
                TextField("Tax", text: $tax)
                    .keyboardType(.decimalPad)
            }

            Section(header: Text("Product Image")) {
                if let image = image {
                    image
                        .resizable()
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                } else {
                    Button(action: {
                   
                    }) {
                        Text("Add Image")
                            .font(.headline)
                    }
                }
            }

            Section {
                Button(action: {
              
                }) {
                    Text("Submit")
                        .font(.headline)
                }
            }
        }
        .navigationTitle("Add Product")
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddProductView()
        }
    }
}
