import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Dish Name & Recipe Pic (Top Left Image)
                HStack {
                    VStack {
                        Text(recipe.recipeName)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color(hex:"1C1345"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 5)
                            .padding(.leading, 16)
                        
                        Text("Prep Time: \(recipe.preparationTime)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.leading, -60)
                        
                        Text("Serves: \(recipe.servings)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.leading, -65)
                    }
                    
                    // First Image: Recipe Image on the top
                    Image(recipe.imageName1)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .padding(.trailing, 16)
                }
                
                // Ingredients Section
                IngredientGridView(ingredients: recipe.ingredients)
                    
                    HStack{
                        Image(recipe.imageName2)  // Display image again
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            //.cornerRadius(1000)
                            .padding(.bottom, 8)
                        VStack(spacing: 20){
                            Text("Preparation")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.top, 16)
                                .foregroundColor(Color(hex:"1C1345"))
                           
                            
                            Text(recipe.preparationPointers)
                                .font(.body)
                                .foregroundColor(.gray)
                                .padding(.top, 8)
                                .padding(.trailing, 16)
                        }
                    }
                
                
                // Recipe Steps Section
                VStack {
                    Text("Recipe Steps")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top, 16)
                        .foregroundColor(Color(hex:"1C1345"))
                    
                    Text(recipe.recipeSteps)
                        .font(.body)
                        .padding(.bottom, 16)
                        .padding(.top, 8)
                        .padding(.horizontal, 16)
                }
            }
            .padding(.top, 16)
        }
        .background(Color(hex: "#E0E3F0"))
        .navigationTitle(recipe.recipeName)
    }
}



struct IngredientGridView: View {
    @State private var showingModal = false
    let ingredients: [Ingredient]
    
    var body: some View {
        VStack {
            Text("Ingredients")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 16)
                .foregroundColor(Color(hex:"1C1345"))
            
            // HStack for Ingredients
            HStack(spacing: 16) {
                ForEach(0..<min(4, ingredients.count)) { index in
                    IngredientImageView(ingredient: ingredients[index])
                }
                
                Button(action: {
                    showingModal.toggle()
                }) {
                    ZStack {
                        Color.gray.opacity(0.1)
                            .frame(width: 50, height: 50)
                            .cornerRadius(25)
                        
                        Image(systemName: "ellipsis")
                            .font(.largeTitle)
                            .foregroundColor(Color(hex:"1C1345"))
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .padding(.bottom, 16)
            .sheet(isPresented: $showingModal) {
                IngredientListView(ingredients: ingredients)
            }
        }
        .background(Color(hex: "#E0E3F0"))
    }
}


struct IngredientImageView: View {
    let ingredient: Ingredient
    
    var body: some View {
        Image(ingredient.image)
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
            .shadow(radius: 8)
    }
}


struct IngredientListView: View {
    let ingredients: [Ingredient]
    
    var body: some View {
        NavigationView {
            List(ingredients) { ingredient in
                HStack {
                    Image("bowl") // Placeholder icon for ingredients
                        .foregroundColor(.green)
                        .frame(width: 50.0, height: 50.0)
                        .clipShape(Circle())
                    
                    Text(ingredient.name)
                        .font(.body)
                    
                    Spacer()
                    
                    Text(ingredient.quantity)
                        .font(.body)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 8)
            }
            .background(Color(hex: "#E0E3F0"))
            .navigationTitle("Ingredients List")
        }
    }
}


