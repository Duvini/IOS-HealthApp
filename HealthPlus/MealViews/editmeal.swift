import SwiftUI

struct EditFoodFormView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var food: Food

    @State private var foodName: String
    @State private var calories: String
    @State private var fats: String
    @State private var carbs: String
    @State private var proteins: String
    @State private var selectedMealTime: String
    @State private var navigateToMeals: Bool = false // Navigation trigger
    @State private var showDeleteConfirmation: Bool = false // Trigger delete confirmation
    let mealTimes = ["Breakfast", "Lunch", "Dinner", "Snack", "Other"]

    init(food: Food) {
        self.food = food
        _foodName = State(initialValue: food.name ?? "")
        _calories = State(initialValue: String(format: "%.0f", food.calories))
        _fats = State(initialValue: String(format: "%.0f", food.fats))
        _carbs = State(initialValue: String(format: "%.0f", food.carbs))
        _proteins = State(initialValue: String(format: "%.0f", food.proteins))
        _selectedMealTime = State(initialValue: food.mealTime ?? "Breakfast")
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Header
                HStack {
                    Button(action: {
                        navigateToMeals = true // Navigate back
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.orange)
                    }
                    Spacer()
                    Text("Edit Food Info")
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: {
                        saveFood() // Save changes and navigate back
                    }) {
                        Text("Save")
                            .font(.headline)
                            .foregroundColor(.orange)
                    }
                }
                .padding(.horizontal)

                // Input Fields
                ScrollView {
                    VStack(spacing: 20) {
                        FoodInputField(title: "EDIT NAME", placeholder: "Enter Food name", text: $foodName)
                        FoodInputField(title: "EDIT CALORIES", placeholder: "Enter Calories", text: $calories)
                        FoodInputField(title: "EDIT FAT", placeholder: "Enter Fat", text: $fats)
                        FoodInputField(title: "EDIT PROTEIN", placeholder: "Enter Protein", text: $proteins)
                        FoodInputField(title: "EDIT CARBS", placeholder: "Enter Carbs", text: $carbs)

                        // Meal Time Picker
                        VStack(alignment: .leading, spacing: 10) {
                            Text("MEAL TYPE")
                                .font(.subheadline)
                                .foregroundColor(.white)
                            Picker("Select Meal Time", selection: $selectedMealTime) {
                                ForEach(mealTimes, id: \.self) { meal in
                                    Text(meal).tag(meal)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
                            )
                            .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal)
                }

                Spacer()

                // Delete Button
                Button(action: {
                    showDeleteConfirmation = true // Show confirmation alert
                }) {
                    Text("Delete")
                        .font(.headline)
                        .foregroundColor(.red)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.red.opacity(0.5), lineWidth: 1)
                        )
                }
                .padding(.horizontal)

                // NavigationLink to MealsView
                NavigationLink(destination: MealsView(), isActive: $navigateToMeals) {
                    EmptyView() // Invisible NavigationLink
                }
            }
            .padding(.top)
            .background(Color.black.ignoresSafeArea())
            .alert(isPresented: $showDeleteConfirmation) {
                Alert(
                    title: Text("Confirm Delete"),
                    message: Text("Are you sure you want to delete this food item?"),
                    primaryButton: .destructive(Text("Delete")) {
                        deleteFood() // Perform deletion
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }

    private func saveFood() {
        // Update the Food object with new values
        food.name = foodName
        food.calories = Double(calories) ?? 0.0
        food.fats = Double(fats) ?? 0.0
        food.carbs = Double(carbs) ?? 0.0
        food.proteins = Double(proteins) ?? 0.0
        food.mealTime = selectedMealTime

        // Save changes to Core Data
        do {
            try viewContext.save()
            navigateToMeals = true // Trigger navigation back to MealsView
        } catch {
            print("Failed to save changes: \(error.localizedDescription)")
        }
    }

    private func deleteFood() {
        // Delete the Food object from Core Data
        viewContext.delete(food)
        do {
            try viewContext.save()
            navigateToMeals = true // Navigate back to MealsView
        } catch {
            print("Failed to delete food: \(error.localizedDescription)")
        }
    }
}

// Reusable Input Field Component
struct FoodInputField: View {
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

