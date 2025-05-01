import SwiftUI

class RecipeDataController: ObservableObject {
    // Data for each segment
    @Published var snacks: [Recipe]
    @Published var meals: [Recipe]
    @Published var desserts: [Recipe]
    @Published var drinks: [Recipe]
    
    init() {
        // Sample data for Snacks
        snacks = [
            Recipe(
                imageName1: "veggieStick", imageName2: "veggieStick",
                recipeName: "Veggie Sticks",
                preparationTime: "5 mins",
                difficultyLevel: "Easy",
                ingredients: [
                    Ingredient(name: "Carrot Sticks", image: "bowl", quantity: "1 cup"),
                    Ingredient(name: "Cucumber Slices", image: "bowl", quantity: "1/2 cup"),
                    Ingredient(name: "Hummus", image: "bowl", quantity: "3 tbsp")
                ],
                servings: "1 serving",
                preparationPointers: "Cut veggies and dip in hummus.",
                recipeSteps: """
                1. Cut carrots and cucumber into sticks.
                2. Serve with hummus for dipping.
                """
            ),
            Recipe(
                imageName1: "yogurt", imageName2: "yogurt",
                recipeName: "Yogurt - Almond Parfait",
                preparationTime: "5 mins",
                difficultyLevel: "Easy",
                ingredients: [
                    Ingredient(name: "Plain Greek Yogurt", image: "yogurt_image", quantity: "1/2 cup"),
                    Ingredient(name: "Almonds", image: "bowl", quantity: "1 tbsp, sliced"),
                    Ingredient(name: "Chia Seeds", image: "bowl", quantity: "1 tsp"),
                    Ingredient(name: "Fresh Berries", image: "bowl", quantity: "1/4 cup")
                ],
                servings: "1 serving",
                preparationPointers: "Layer ingredients in a glass or bowl.",
                recipeSteps: """
                1. Layer Greek yogurt, fresh berries, and almonds in a glass.
                2. Sprinkle chia seeds on top and serve.
                """
            ),
            Recipe(
                imageName1: "cucumber", imageName2: "cucumber",
                recipeName: "Cucumber Bites",
                preparationTime: "5 mins",
                difficultyLevel: "Easy",
                ingredients: [
                    Ingredient(name: "Cucumber", image: "bowl", quantity: "1"),
                    Ingredient(name: "Cream Cheese", image: "bowl", quantity: "2 tbsp")
                ],
                servings: "1 serving",
                preparationPointers: "Slice cucumber and top with cream cheese.",
                recipeSteps: """
                1. Slice cucumber into rounds.
                2. Top with cream cheese and serve.
                """
            ),
            Recipe(
                imageName1: "roll", imageName2: "roll",
                recipeName: "Cheese & Turkey Roll-Ups",
                preparationTime: "5 mins",
                difficultyLevel: "Easy",
                ingredients: [
                    Ingredient(name: "Turkey Slices", image: "bowl", quantity: "4 slices"),
                    Ingredient(name: "Cheese Slices", image: "bowl", quantity: "2 slices")
                ],
                servings: "1 serving",
                preparationPointers: "Roll up turkey and cheese.",
                recipeSteps: """
                1. Place cheese on turkey slices and roll them up.
                2. Serve immediately.
                """
            )

        ]
        
        meals = [
            Recipe(
                imageName1: "chicken", imageName2: "chicken",
                recipeName: "Winter Chicken Parmesan",
                preparationTime: "1 hour",
                difficultyLevel: "Hard",
                ingredients: [
                    Ingredient(name: "Butternut Squash", image: "flour_image", quantity: "3 cups"),
                    Ingredient(name: "Red Onion", image: "bowl", quantity: "1 large"),
                    Ingredient(name: "Extra- Virgin Oil", image: "bowl", quantity: "2 tbsp"),
                    Ingredient(name: "Fresh Sage", image: "bowl", quantity: "1 Cup"),
                    Ingredient(name: "Salt", image: "", quantity: "1 tsp"),
                    Ingredient(name: "Mushrooms", image: "bowl", quantity: "2 cups"),
                    Ingredient(name: "Whole- wheat panko breadcumbs", image: "bowl", quantity: "2/3 cup"),
                    Ingredient(name: "Parmesan Cheese", image: "", quantity: "1 tbsp"),
                    Ingredient(name: "Chicken Cutlests", image: "", quantity: "4"),
                    Ingredient(name: "Butternut Squash Pasta Sauce", image: "", quantity: "1 cup"),
                    Ingredient(name: "Shredded low-moisture part-skim mozzarella cheese", image: "", quantity: "3/4 cup"),
                    Ingredient(name: "white balsamic vinegar", image: "", quantity: "2 tbsp"),
                    Ingredient(name: "Egg", image: "", quantity: "1")
                ],
                servings: "4 servings",
                preparationPointers: """
1. Cubed butternut squash (1/2-inch).
2. Chopped and stemmed lacinato kale
3. the egg should be lightly beaten.
""",
                recipeSteps: """
1. Preheat oven to 400°F and position racks in the middle and lower thirds. Line 2 baking sheets with foil.
2.Toss 3 cups squash, 1/2-inch onion wedges, 1 1/2 tsp oil, 1 tbsp sage, and 1/8 tsp salt on one baking sheet. Roast for 20 minutes. Add 2 cups mushrooms, 2 cups kale, 1 tbsp garlic, and 1/8 tsp salt, then set aside.
3.Dredge chicken cutlets in 1/4 cup flour, egg, and 2/3 cup panko mixed with 1 tbsp Parmesan. Season chicken with remaining salt.
4.Heat 1 1/2 tbsp oil in a skillet over medium-high heat. Cook chicken until golden, about 1 minute per side. Transfer to the second baking sheet. Top with 1/4 cup pasta sauce and 3/4 cup mozzarella. Bake for 15 minutes or until chicken reaches 165°F and veggies are tender, stirring veggies halfway.
5.Increase oven temp to broil and broil chicken for 1-2 minutes until cheese is browned.
Serve each chicken cutlet with 1 1/2 cups vegetables, garnished with sage, if desired.
"""
            ),
            Recipe(
                imageName1: "salad", imageName2: "salad",
                recipeName: "Grilled Chicken Salad",
                preparationTime: "40 mins",
                difficultyLevel: "Medium",
                ingredients: [
                    Ingredient(name: "Boneless, Skinless chicken breasts", image: "bowl", quantity:"2"),
                    Ingredient(name: "Sliced Avocado", image: "bowl", quantity: "1"),
                    Ingredient(name: "Cucumber", image: "bowl", quantity: "1"),
                    Ingredient(name: "Onion", image: "bowl", quantity: "1/4 cup"),
                    Ingredient(name: "Mixed Greens", image: "bowl", quantity: "2 cups"),
                    Ingredient(name: "Olive Oil", image: "", quantity: "1 tbsp"),
                    Ingredient(name: "Lemon Juice", image: "", quantity: "1 tbsp"),
                    Ingredient(name: "Salt and Pepper", image: "", quantity: "To TAste"),
                    
                ],
                servings: "2 serving",
                preparationPointers: "Preheat grill or grill pan over medium heat.",
                recipeSteps: """
                
                1.Season chicken breasts with salt and pepper, then grill for about 6-7 minutes per side, or until fully cooked (165°F internal temperature).
                2.While the chicken is grilling, prepare the salad. Toss together the mixed greens, avocado, cucumber, and red onion.
                3.In a small bowl, whisk together olive oil, lemon juice, salt, and pepper for the dressing.
                4.Slice the grilled chicken and add it to the salad. Drizzle with lemon dressing and toss gently.
                """
            ),
            Recipe(
                imageName1: "rice", imageName2: "rice",
                recipeName: "Cauliflower Fried Rice",
                preparationTime: "30 mins",
                difficultyLevel: "Easy",
                ingredients: [
                    Ingredient(name: "Cauliflower", image: "bowl", quantity: "1 small head"),
                    Ingredient(name: "Sesame Oil", image: "bowl", quantity: "1 tbsp"),
                    Ingredient(name: "Carrots", image: "bowl", quantity: "1/2 cup"),
                    Ingredient(name: "Peas", image: "bowl", quantity: "1/2 cup"),
                    Ingredient(name: "Green Onions", image: "bowl", quantity: "1/4 cup"),
                    Ingredient(name: "Eggs", image: "bowl", quantity: "2"),
                    Ingredient(name: "Low-Sodium Soy Sauce", image: "soy_sauce_image", quantity: "2 tbsp"),
                    Ingredient(name: "Garlic", image: "", quantity: "1 clove"),
                    Ingredient(name: "Fresh Ginger", image: "", quantity: "1/2 tsp")
                ],
                servings: "2 servings",
                preparationPointers: "Heat sesame oil in a pan and prepare all ingredients.",
                recipeSteps: """
                1. Heat sesame oil in a large skillet over medium heat. Add carrots, peas, and garlic, and cook for 3 minutes.
                2. Push vegetables to one side of the pan and scramble the beaten eggs on the other side.
                3. Once eggs are cooked, mix with the vegetables.
                4. Add grated cauliflower rice to the skillet and stir-fry for about 5-7 minutes.
                5. Stir in soy sauce and fresh ginger. Garnish with green onions before serving.
                """
            ),
            Recipe(
                imageName1: "salmon", imageName2: "salmon",
                recipeName: "Baked Salmon",
                preparationTime: "20 mins",
                difficultyLevel: "Easy",
                ingredients: [
                    Ingredient(name: "Salmon Fillets", image: "bowl", quantity: "2 (4 oz each)"),
                    Ingredient(name: "Asparagus", image: "bowl", quantity: "1 bunch"),
                    Ingredient(name: "Olive Oil", image: "bowl", quantity: "1 tbsp"),
                    Ingredient(name: "Garlic Powder", image: "garlic_image", quantity: "1 tsp"),
                    Ingredient(name: "Lemon Zest", image: "bowl", quantity: "1 tsp"),
                    Ingredient(name: "Salt and Pepper", image: "salt_image", quantity: "To Taste"),
                    Ingredient(name: "Lemon Wedges", image: "bowl", quantity: "For serving")
                ],
                servings: "2 servings",
                preparationPointers: "Preheat oven and prepare salmon and asparagus.",
                recipeSteps: """
                1. Preheat oven to 400°F.
                2. Place salmon fillets and asparagus on a baking sheet. Drizzle olive oil over both.
                3. Sprinkle garlic powder, lemon zest, salt, and pepper on top of salmon and asparagus.
                4. Bake for 12-15 minutes, or until salmon reaches 165°F internal temperature.
                5. Serve with lemon wedges on the side.
                """
            )

        ]
        
        desserts = [
            Recipe(
                imageName1: "matcha", imageName2: "matcha",
                recipeName: "Matcha Energy Bites",
                preparationTime: "15 mins",
                difficultyLevel: "Easy",
                ingredients: [
                    Ingredient(name: "Pecans", image: "bowl", quantity: "1/2 cup"),
                    Ingredient(name: "Unsweetened Shreeded Coconut", image: "bowl", quantity: "1 cup"),
                    Ingredient(name: "Coconut Oil", image: "bowl", quantity: "1 tbsp"),
                    Ingredient(name: "Pitted Dates", image: "bowl", quantity: "6"),
                    Ingredient(name: "Matcha Powder", image: "bowl", quantity: "1 tbsp"),
                    Ingredient(name: "Protein Powder", image: "", quantity: "2 tbsp"),
                ],
                servings: "8 servings",
                preparationPointers: "In a food processor or high powered blender, pulse pecans until finely ground (the texture of cornmeal).",
                recipeSteps: """
1.Add shredded coconut, coconut oil, dates, matcha powder and protein powder. Pulse until well combined into a sticky dough.
2.Divide mixture into 8 equal portions and roll into balls.
3.Enjoy one ball per serving. Extra servings can be individually wrapped or stored in an airtight container in the fridge up to 1 week, or frozen up to 3 months.
"""
            ),
            Recipe(
                imageName1: "pudding", imageName2: "pudding",
                recipeName: "Chia Seed Pudding",
                preparationTime: "15 mins",
                difficultyLevel: "Easy",
                ingredients: [
                    Ingredient(name: "Flour", image: "bowl", quantity: "200g"),
                    Ingredient(name: "Sugar", image: "bowl", quantity: "50g")
                ],
                servings: "2 servings",
                preparationPointers: "Mix ingredients and bake.",
                recipeSteps: "1. Preheat oven to 180°C\n2. Mix ingredients.\n3. Bake for 20 minutes."
            ),
            Recipe(
                imageName1: "apple", imageName2: "apple",
                recipeName: "Baked Apple",
                preparationTime: "20 mins",
                difficultyLevel: "Easy",
                ingredients: [
                    Ingredient(name: "Apple", image: "bowl", quantity: "1"),
                    Ingredient(name: "Cinnamon", image: "bowl", quantity: "1/4 tsp")
                ],
                servings: "1 serving",
                preparationPointers: "Bake apple with cinnamon.",
                recipeSteps: """
                1. Core the apple and sprinkle with cinnamon.
                2. Bake at 350°F for 20 minutes and serve.
                """
            ),
            Recipe(
                imageName1: "choco", imageName2: "choco",
                recipeName: "Chocolate Clusters",
                preparationTime: "10 mins",
                difficultyLevel: "Medium",
                ingredients: [
                    Ingredient(name: "Dark Chocolate", image: "chocolate_image", quantity: "2 oz"),
                    Ingredient(name: "Almonds", image: "bowl", quantity: "1/4 cup"),
                    Ingredient(name: "Sea Salt", image: "bowl", quantity: "Pinch")
                ],
                servings: "2 servings",
                preparationPointers: "Melt chocolate and combine with almonds.",
                recipeSteps: """
                1. Melt dark chocolate in a double boiler.
                2. Mix in almonds and a pinch of sea salt.
                3. Spoon clusters onto parchment paper and chill until set.
                """
            )
        ]
        
        drinks = [
            Recipe(
                imageName1: "mint", imageName2: "mint",
                recipeName: "Cucumber Mint Water",
                preparationTime: "5 mins",
                difficultyLevel: "Easy",
                ingredients: [
                    Ingredient(name: "Cucumber", image: "bowl", quantity: "4 slices"),
                    Ingredient(name: "Fresh Mint", image: "bowl", quantity: "A few sprigs"),
                    Ingredient(name: "Water", image: "bowl", quantity: "1 glass")
                ],
                servings: "1 serving",
                preparationPointers: "Infuse water with cucumber and mint.",
                recipeSteps: """
                1. Add cucumber slices and fresh mint to a glass of water.
                2. Stir well and let infuse for a few minutes before serving.
                """
            ),

            Recipe(
                imageName1: "lemon", imageName2: "lemon",
                recipeName: "Lemon Ginger Tea",
                preparationTime: "10 mins",
                difficultyLevel: "Easy",
                ingredients: [
                    Ingredient(name: "Fresh Ginger", image: "ginger_image", quantity: "1-inch piece"),
                    Ingredient(name: "Lemon", image: "bowl", quantity: "1"),
                    Ingredient(name: "Hot Water", image: "bowl", quantity: "1 cup"),
                    Ingredient(name: "Honey (optional)", image: "bowl", quantity: "1 tsp")
                ],
                servings: "1 serving",
                preparationPointers: "Steep ginger and lemon in hot water.",
                recipeSteps: """
                1. Slice the ginger and lemon, then add to hot water.
                2. Steep for about 5 minutes.
                3. Add honey if desired and serve warm.
                """
            ),
            
            Recipe(
                imageName1: "greenTea", imageName2: "greenTea",
                recipeName: "Iced Green Tea",
                preparationTime: "5 mins",
                difficultyLevel: "Easy",
                ingredients: [
                    Ingredient(name: "Green Tea Bag", image: "green_tea_image", quantity: "1"),
                    Ingredient(name: "Lemon", image: "bowl", quantity: "2 slices"),
                    Ingredient(name: "Ice", image: "bowl", quantity: "For serving"),
                    Ingredient(name: "Stevia (optional)", image: "bowl", quantity: "To taste")
                ],
                servings: "1 serving",
                preparationPointers: "Brew tea and cool it down.",
                recipeSteps: """
                1. Brew the green tea bag in hot water for 3-5 minutes, then cool it down.
                2. Add ice cubes and lemon slices.
                3. Sweeten with stevia if desired, and serve chilled.
                """
            ),
            
            Recipe(
                imageName1: "smoothie", imageName2: "smoothie",
                recipeName: "Berry Smoothie",
                preparationTime: "5 mins",
                difficultyLevel: "Easy",
                ingredients: [
                    Ingredient(name: "Frozen Mixed Berries", image: "bowl", quantity: "1/2 cup"),
                    Ingredient(name: "Plain Greek Yogurt", image: "bowl", quantity: "1/2 cup"),
                    Ingredient(name: "Unsweetened Almond Milk", image: "bowl", quantity: "1/2 cup"),
                    Ingredient(name: "Chia Seeds", image: "seeds_image", quantity: "1 tsp")
                ],
                servings: "1 serving",
                preparationPointers: "Blend all ingredients together.",
                recipeSteps: """
                1. Combine frozen mixed berries, Greek yogurt, almond milk, and chia seeds in a blender.
                2. Blend until smooth and creamy, then serve immediately.
                """
            )


        ]
    }
}

