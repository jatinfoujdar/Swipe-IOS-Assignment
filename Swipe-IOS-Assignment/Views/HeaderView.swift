import SwiftUI

struct HeaderView: View {
    @State private var searchText = ""
     var body: some View {
         NavigationView {
             VStack {
                
                 Text("Search Results Will Appear Here")
                     .padding()
                 
                 Spacer()
             }
             .navigationTitle("Main Screen")
             .navigationBarItems(
                 leading: Button(action: {
                    
                     print("Back button tapped")
                 }) {
                     Image(systemName: "arrow.left.circle.fill")
                         .foregroundColor(.blue)
                 },
                 trailing: Button(action: {
                  
                     print("Settings button tapped")
                 }) {
                     Image(systemName: "gearshape.fill")
                         .foregroundColor(.blue)
                 }
             )
             .overlay(
                 // Centered search bar
                 VStack {
                     HStack {
                         Spacer()  // To center the TextField horizontally
                         TextField("Search...", text: $searchText)  // Placeholder text
                             .padding(12)  // Padding inside the TextField
                             .background(Color.gray.opacity(0.2), in: RoundedRectangle(cornerRadius: 10))  // Rounded corner background
                             .padding(.horizontal, 20)  // Outer padding
                             .padding(.top, 8)  // Padding from the top
                         Spacer()  // To center the TextField horizontally
                     }
                     Spacer()  // Keeps the content below the header area
                 }
                 , alignment: .top
             )
         }
     }
 }


#Preview {
    HeaderView()
}
