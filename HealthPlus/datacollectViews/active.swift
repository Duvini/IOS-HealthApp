import SwiftUI

struct ActivityLevelSelectionView: View {
    @State private var selectedActivityLevel: String? = nil

    var body: some View {
        VStack {
            Spacer()

            // Title
            Text("How active are you?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.bottom, 10)

            // Subtitle
            Text("A sedentary person burns fewer calories than an active person")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .padding(.bottom, 40)

            // Activity Level Options
            VStack(spacing: 20) {
                ActivityOptionButton(title: "Sedentary", isSelected: selectedActivityLevel == "Sedentary") {
                    selectedActivityLevel = "Sedentary"
                }
                ActivityOptionButton(title: "Low Active", isSelected: selectedActivityLevel == "Low Active") {
                    selectedActivityLevel = "Low Active"
                }
                ActivityOptionButton(title: "Active", isSelected: selectedActivityLevel == "Active") {
                    selectedActivityLevel = "Active"
                }
                ActivityOptionButton(title: "Very Active", isSelected: selectedActivityLevel == "Very Active") {
                    selectedActivityLevel = "Very Active"
                }
            }

            Spacer()

            // Navigation Buttons
            HStack {
                Button(action: {
                    // Handle "Back" action
                }) {
                    Text("Back")
                        .foregroundColor(.gray)
                }
                .padding(.leading, 30)

                Spacer()

                Button(action: {
                    // Handle "Next" action
                }) {
                    NavigationLink(destination: HeightSelectionView()) {
                        Image(systemName: "arrow.right")
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                            .background(Color.orange)
                            .clipShape(Circle())
                    }
                }
                .padding(.trailing, 30)
            }
            .padding(.bottom, 20)
        }
        .background(Color.black.ignoresSafeArea())
    }
}

// Reusable Activity Option Button
struct ActivityOptionButton: View {
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
struct ActivityLevelSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityLevelSelectionView()
    }
}
