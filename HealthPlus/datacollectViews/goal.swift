import SwiftUI

struct NutritionGoalsView: View {
    @State private var calorieGoal: String = ""
    @State private var fatGoal: String = ""
    @State private var proteinGoal: String = ""
    @State private var carbGoal: String = ""
    
    var body: some View {
        VStack {
            // Header Section
            VStack(spacing: 15) {
                Text("HealthPlus")
                    .font(.largeTitle.bold())
                    .foregroundColor(.orange)
                
                Text("Almost there!")
                    .font(.title2.weight(.semibold))
                    .foregroundColor(.white)
                
                Text("What are your daily nutrition requirements?")
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 40)
            .padding(.horizontal)
            
            Spacer(minLength: 30)
            
            // Input Fields Section
            ScrollView {
                VStack(spacing: 20) {
                    NutritionInputField(
                        title: "Calories Goal",
                        placeholder: "Enter your daily calorie goal",
                        text: $calorieGoal,
                        icon: "flame.fill"
                    )
                    NutritionInputField(
                        title: "Fats (g)",
                        placeholder: "Enter your daily fat intake",
                        text: $fatGoal,
                        icon: "drop.fill"
                    )
                    NutritionInputField(
                        title: "Proteins (g)",
                        placeholder: "Enter your daily protein intake",
                        text: $proteinGoal,
                        icon: "bolt.fill"
                    )
                    NutritionInputField(
                        title: "Carbs (g)",
                        placeholder: "Enter your daily carbohydrate intake",
                        text: $carbGoal,
                        icon: "leaf.fill"
                    )
                }
                .padding(.horizontal)
            }
            .scrollIndicators(.hidden)
            
            Spacer()
            
            // Next Button Section
            Button(action: {
                // Handle Next Button Action
            }) {
                NavigationLink(destination: RecommendedPFCView()) {
                    Text("Next")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 150, height: 50)
                        .background(
                            Capsule()
                                .fill(Color.orange)
                                .shadow(color: Color.orange.opacity(0.4), radius: 10, x: 0, y: 5)
                        )
                }
            }
            .padding(.bottom, 30)
        }
        .background(Color.black.ignoresSafeArea())
    }
}

// Reusable Nutrition Input Field Component
struct NutritionInputField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    let icon: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.orange)
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            
            TextField(placeholder, text: $text)
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(12)
                .foregroundColor(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.orange.opacity(0.6), lineWidth: 1)
                )
        }
    }
}

// Preview
struct NutritionGoalsView_Previews: PreviewProvider {
    static var previews: some View {
        NutritionGoalsView()
    }
}
