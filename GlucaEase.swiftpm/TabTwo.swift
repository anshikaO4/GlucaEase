import SwiftUI

struct TabTwo: View {
    @State private var selectedSegmentIndex: Int = 0
    @ObservedObject var dataController = RecipeDataController()  // Instantiate the DataController
    
    var body: some View {
        NavigationView {
            VStack {
                // Customizable Segmented Control
                CustomSegmentedControl(
                    items: ["Snacks", "Meals", "Desserts", "Drinks"],
                    selectedIndex: $selectedSegmentIndex,
//                    selectedColor: .blue,
//                    unselectedColor: .gray,
                    font: .subheadline
                )
                .padding()
                
                // Display content based on selected segment
                Spacer()
                
                switch selectedSegmentIndex {
                case 0:
                    // Display Snacks
                    ScrollView {
                        VStack {
                            ForEach(dataController.snacks) { recipe in
                                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                    RecipeCardView(recipe: recipe)
                                }
                            }
                        }
                    }
                case 1:
                    // Display Meals
                    ScrollView {
                        VStack {
                            ForEach(dataController.meals) { recipe in
                                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                    RecipeCardView(recipe: recipe)
                                }
                            }
                        }
                    }
                case 2:
                    // Display Desserts
                    ScrollView {
                        VStack {
                            ForEach(dataController.desserts) { recipe in
                                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                    RecipeCardView(recipe: recipe)
                                }
                            }
                        }
                    }
                case 3:
                    // Display Drinks
                    ScrollView {
                        VStack {
                            ForEach(dataController.drinks) { recipe in
                                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                    RecipeCardView(recipe: recipe)
                                }
                            }
                        }
                    }
                default:
                    Text("Default View")
                }
            }
            .padding()
//            .background(
//                LinearGradient(gradient: Gradient(colors: [Color(hex:"#494CA1"), Color(hex:"#F2F2F2")]), startPoint: .top, endPoint: .bottom)
//                )
            .background(Color(hex: "#E0E3F0"))
        }
        
    }
}


#Preview {
    TabTwo()
}

