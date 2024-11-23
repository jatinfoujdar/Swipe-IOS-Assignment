import SwiftUI

struct HeaderView: View {
    @State private var searchText = ""

       var body: some View {
           NavigationStack {
               Text("Searching for \(searchText)")
                   .navigationTitle("Searchable Example")
           }
           .searchable(text: $searchText)    
     }
 }


#Preview {
    HeaderView()
}
