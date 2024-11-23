import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
          
            Spacer()
            
       
            Text("Products")
                .font(.title)
                .fontWeight(.bold)
            
      
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
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    HeaderView()
}
