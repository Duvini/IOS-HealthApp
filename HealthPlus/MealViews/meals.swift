import SwiftUI
import CoreData

struct MealsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Food.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Food.mealTime, ascending: true)]
    ) private var foods: FetchedResults<Food>

    @State private var selectedMealTime: String?
    @State private var selectedFood: Food? // Holds the selected Food item for editing
    @State private var isEditing: Bool = false // Controls navigation to EditFoodFormView

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Header
                HStack {
                    Text("Today's Food")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: {
                        isEditing.toggle()
                    }) {
                        Text("Edit")
                            .foregroundColor(.orange)
                            .font(.headline)
                    }
                }
                .padding(.horizontal)

                // Add New Items Section
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        AddMealButton(title: "Breakfast", icon: "sunrise.fill", mealTime: "Breakfast", selectedMealTime: $selectedMealTime)
                        AddMealButton(title: "Lunch", icon: "fork.knife", mealTime: "Lunch", selectedMealTime: $selectedMealTime)
                        AddMealButton(title: "Dinner", icon: "moon.fill", mealTime: "Dinner", selectedMealTime: $selectedMealTime)
                        AddMealButton(title: "Sweets", icon: "birthday.cake.fill", mealTime: "Snack", selectedMealTime: $selectedMealTime)
                        AddMealButton(title: "Drinks", icon: "cup.and.saucer.fill", mealTime: "Other", selectedMealTime: $selectedMealTime)
                    }
                    .padding(.horizontal)
                }

                // Food List Section
                ScrollView {
                    ForEach(["Breakfast", "Lunch", "Dinner", "Snack", "Other"], id: \.self) { mealTime in
                        let mealItems = foods.filter { $0.mealTime == mealTime }
                        if !mealItems.isEmpty {
                            MealSection(
                                title: mealTime.uppercased(),
                                items: mealItems,
                                isEditing: isEditing,
                                onItemSelected: { food in
                                    selectedFood = food
                                }
                            )
                        }
                    }
                }

                Spacer()

                // Bottom Navigation
                HStack {
                    NavigationLink(destination: DashboardView()) {
                        TabItem(icon: "house.fill", title: "Home", isActive: false)
                    }
                    NavigationLink(destination: MealsView()) {
                        TabItem(icon: "fork.knife", title: "Meals", isActive: true)
                    }
                    NavigationLink(destination: ProfileView()) {
                        TabItem(icon: "person", title: "Personal", isActive: false)
                    }
                }
                .padding()
                .background(Color.black.opacity(0.9))
                .cornerRadius(30)
                .shadow(color: .orange.opacity(0.2), radius: 10, x: 0, y: -5)
            }
            .background(Color.black.ignoresSafeArea())
            .navigationDestination(isPresented: Binding(get: {
                selectedFood != nil
            }, set: { isPresented in
                if !isPresented { selectedFood = nil }
            })) {
                if let food = selectedFood {
                    EditFoodFormView(food: food)
                }
            }
        }
    }
}

// Meal Section
struct MealSection: View {
    let title: String
    let items: [Food]
    let isEditing: Bool
    let onItemSelected: (Food) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundColor(.orange)
                .padding(.horizontal)
            ForEach(items, id: \.objectID) { item in
                Button(action: {
                    if isEditing {
                        onItemSelected(item)
                    }
                }) {
                    MealCard(item: MealItem(
                        name: item.name ?? "",
                        calories: Int(item.calories),
                        macros: "Fats: \(item.fats)g | Protein: \(item.proteins)g | Carbs: \(item.carbs)g"
                    ))
                }
            }
        }
    }
}


// Add New Meal Button
struct AddMealButton: View {
    let title: String
    let icon: String
    let mealTime: String
    @Binding var selectedMealTime: String?

    var body: some View {
        Button(action: {
            selectedMealTime = mealTime
        }) {
            VStack {
                ZStack {
                    Circle()
                        .fill(Color.green.opacity(0.2))
                        .frame(width: 60, height: 60)
                    Image(systemName: icon)
                        .font(.title)
                        .foregroundColor(.orange)
                }
                Text(title)
                    .font(.footnote)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 80)
            }
        }
        .navigationDestination(isPresented: Binding(get: {
            selectedMealTime == mealTime
        }, set: { isPresented in
            if !isPresented { selectedMealTime = nil }
        })) {
            AddFoodFormView(selectedMealTime: mealTime)
        }
    }
}

// Preview
struct MealsView_Previews: PreviewProvider {
    static var previews: some View {
        MealsView()
            .environment(\.managedObjectContext, (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    }
}

// Components


// Meal Item Model
struct MealItem {
    let name: String
    let calories: Int
    let macros: String
}

// Meal Card
struct MealCard: View {
    let item: MealItem

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(item.macros)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text("\(item.calories) kcal")
                .font(.headline)
                .foregroundColor(.orange)
        }
        .padding()
        .background(
            Color.white.opacity(0.1)
                .cornerRadius(15)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
        .padding(.horizontal)
    }
}
