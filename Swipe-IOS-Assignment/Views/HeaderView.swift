import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Text("Add New Product")
                .font(.title)
                .fontWeight(.bold)
            
            Spacer()
            Button(action: {
                print("Add new product")
            }) {
                Image(systemName: "plus.circle.fill")
                    .font(.title)
                    .foregroundColor(.blue)
                    .padding()
            }
        }
        .padding()
        .background(Color.red)
        .cornerRadius(10)
      
    }
}

#Preview {
    HeaderView()
}
