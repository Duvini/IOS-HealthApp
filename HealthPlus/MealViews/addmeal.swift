import SwiftUI
import CoreData

struct AddFoodFormView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State private var foodName: String = ""
    @State private var calories: String = ""
    @State private var fats: String = ""
    @State private var carbs: String = ""
    @State private var proteins: String = ""
    @State var selectedMealTime: String
    let mealTimes = ["Breakfast", "Lunch", "Dinner", "Snack", "Other"]

    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var navigateToMeals: Bool = false // Trigger navigation to MealsView

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Header
                HStack {
                    Spacer()
                    Text("Add Food")
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.horizontal)

                // Input Fields
                ScrollView {
                    VStack(spacing: 20) {
                        MealInputField(title: "FOOD NAME", placeholder: "(Required) Enter Food name", text: $foodName)
                        MealInputField(title: "CALORIES", placeholder: "(Required) Enter Calories", text: $calories)
                        MealInputField(title: "FATS", placeholder: "(Optional) Enter Fats", text: $fats)
                        MealInputField(title: "CARBOHYDRATES", placeholder: "(Optional) Enter Carbs", text: $carbs)
                        MealInputField(title: "PROTEINS", placeholder: "(Optional) Enter Proteins", text: $proteins)

                        // Meal Time Picker
                        VStack(alignment: .leading, spacing: 10) {
                            Text("MEAL TIME")
                                .font(.subheadline)
                                .foregroundColor(.white)
                            Picker("Select Meal Time", selection: $selectedMealTime) {
                                ForEach(mealTimes, id: \.self) { meal in
                                    Text(meal).tag(meal)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                }

                // Add Button
                Button(action: {
                    addFood() // Save data to Core Data
                }) {
                    Text("Add")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .cornerRadius(15)
                        .shadow(color: .green.opacity(0.3), radius: 10, x: 0, y: 5)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)

                // Invisible NavigationLink to MealsView
                NavigationLink(destination: MealsView(), isActive: $navigateToMeals) {
                    EmptyView()
                }
            }
            .background(Color.black.ignoresSafeArea())
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    private func addFood() {
        guard !foodName.isEmpty, !calories.isEmpty else {
            alertMessage = "Food name and calories are required."
            showAlert = true
            return
        }

        // Create a new Food object in Core Data
        let newFood = Food(context: viewContext)
        newFood.name = foodName
        newFood.calories = Double(calories) ?? 0.0
        newFood.fats = Double(fats) ?? 0.0
        newFood.carbs = Double(carbs) ?? 0.0
        newFood.proteins = Double(proteins) ?? 0.0
        newFood.mealTime = selectedMealTime

        // Save the context
        do {
            try viewContext.save()
            navigateToMeals = true // Navigate back to MealsView after successful save
        } catch {
            alertMessage = "Failed to save food: \(error.localizedDescription)"
            showAlert = true
        }
    }
}

// Reusable Input Field Component
struct MealInputField: View {
    let title: String
    let placeholder: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.white)
            TextField(placeholder, text: $text)
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(10)
                .foregroundColor(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
        }
    }
}

// Preview
struct AddFoodFormView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodFormView(selectedMealTime: "Breakfast")
            .environment(\.managedObjectContext, (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    }
}
