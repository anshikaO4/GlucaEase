import SwiftUI

struct articleDetailView: View {
    var article: Article
    @Environment(\.presentationMode) var presentationMode // To dismiss the view
    
    var body: some View {
        ScrollView{
            VStack {
                Image(article.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: 80)
                    .padding(.top, 180)
                
                Text(article.title)
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 170)
                    .padding(.leading, -50)
                    .foregroundColor(Color(hex: "1C1345"))
                
                Text(article.content)
                    .font(.body)
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                    .foregroundColor(Color(hex: "1C1345"))
                
                Spacer()
            }
            .navigationTitle(article.title) // Set the navigation bar title
            
        }
        .background(Color(hex: "#E0E3F0"))
    }
}


