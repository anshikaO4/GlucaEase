import SwiftUI

struct RecipeCardView: View {
    let recipe: Recipe

    var body: some View {
        ZStack {
            // Image at the background
            Image(recipe.imageName1)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width - 40, height: 400)
                .clipped()
                .overlay(
                    VStack {
                        Spacer()
                        
                        Rectangle()
                            .fill(Color.black.opacity(0.7))
                            .blur(radius: 8)
                            .frame(width: UIScreen.main.bounds.width - 40, height: 80)  
                            .cornerRadius(10)
                            .opacity(0.6)
                            .overlay(
                                VStack {
                                   
                                    HStack {
                                        Text(recipe.recipeName)
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .padding(.leading, 16)
                                            .padding(.bottom, 8)
                                            .padding(.top, 16)
                                            .lineLimit(1)
                                        
                                        Spacer()
                                        
                                        Text(recipe.preparationTime)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .padding(.trailing, 16)
                                            .padding(.bottom, 8)
                                            .padding(.top, 16)
                                    }
                                    Spacer()
                                    // Difficulty level below the name
                                    Text(recipe.difficultyLevel)
                                        .font(.body)
                                        .foregroundColor(.white)
                                        .padding(.trailing, 290)
                                        .padding(.bottom, 8)
                                }
                                .padding(.bottom, 16)
                            )
                    })
        }
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding()
        .cornerRadius(20)
    }
}

