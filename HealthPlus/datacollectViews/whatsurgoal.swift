import SwiftUI

struct GoalSelectionView: View {
    @State private var selectedGoal: String? = nil

    var body: some View {
        VStack {
            Spacer()

            // Title
            Text("What's your goal?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.bottom, 10)

            // Subtitle
            Text("We will calculate daily calories according to your goal")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .padding(.bottom, 40)

            // Goal Options
            VStack(spacing: 20) {
                GoalOptionButton(title: "Lose weight", isSelected: selectedGoal == "Lose weight") {
                    selectedGoal = "Lose weight"
                }
                GoalOptionButton(title: "Keep weight", isSelected: selectedGoal == "Keep weight") {
                    selectedGoal = "Keep weight"
                }
                GoalOptionButton(title: "Gain weight", isSelected: selectedGoal == "Gain weight") {
                    selectedGoal = "Gain weight"
                }
            }

            Spacer()

            // Next Button
            Button(action: {
                // Handle "Next" action
            }) {
                NavigationLink(destination: GenderSelectionView()) {
                    Image(systemName: "arrow.right")
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Color.orange)
                        .clipShape(Circle())
                }
            }
                    
            .padding(.bottom, 20)
        }
        .background(Color.black.ignoresSafeArea())
    }
}

// Reusable Goal Option Button
struct GoalOptionButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.body)
                .foregroundColor(isSelected ? .orange : .gray)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isSelected ? Color.orange : Color.gray, lineWidth: isSelected ? 2 : 1)
                )
        }
        .padding(.horizontal, 40)
    }
}

// Preview
struct GoalSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        GoalSelectionView()
    }
}


