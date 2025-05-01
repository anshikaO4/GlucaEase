import SwiftUI

//MARK: - corner radius
struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

struct ArticlesCard: View {
    @StateObject var dataController = articlesDataController()
    @State private var selectedArticle: Article? = nil
    
    var body: some View {
        VStack {
            ForEach(dataController.articles, id: \.id) { article in
                Button(action: {
                    selectedArticle = article
                }) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(hex: "C9D3F5"))
                        .frame(width: UIScreen.main.bounds.width - 40, height: 250)
                        .overlay(
                            VStack(alignment: .leading, spacing: 0) {
                                Image(article.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width - 40, height: 150)
                                    .clipShape(RoundedCorner(radius: 8, corners: [.topLeft, .topRight]))
                                    
                                Rectangle()
                                    .fill(Color(hex: "E3EAFA"))
                                    .clipShape(RoundedCorner(radius: 8, corners: [.bottomLeft, .bottomRight]))
                                    .overlay(
                                        VStack {
                                            Text(article.title)
                                                .bold(true)
                                                .font(.title2)
                                                .padding(.leading, -140)
                                                .foregroundColor(Color(hex:"1C1345"))
                                            
                                           
                                            Text(article.description)
                                                .font(.subheadline)
                                                .foregroundColor(Color(hex:"1C1345"))
                                                .padding(.leading, -8)
                                               
                                        }
                                    )
                            }
                        )
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .sheet(item: $selectedArticle) { article in
            NavigationView {
                articleDetailView(article: article)
                    .navigationBarTitle(article.title, displayMode: .inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Done") {
                                // Dismiss the modal
                                self.selectedArticle = nil
                        }
                    }
                }
            }
        }
    }
}




