import SwiftUI

struct GenderSelectionView: View {
    @State private var selectedGender: String? = nil

    var body: some View {
        VStack {
            Spacer()

            // Title
            Text("What's your gender?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.bottom, 10)

            // Subtitle
            Text("Male bodies need more calories")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .padding(.bottom, 40)

            // Gender Options
            VStack(spacing: 20) {
                GenderOptionButton(title: "Male", isSelected: selectedGender == "Male") {
                    selectedGender = "Male"
                }
                GenderOptionButton(title: "Female", isSelected: selectedGender == "Female") {
                    selectedGender = "Female"
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
                    NavigationLink(destination: ActivityLevelSelectionView()) {
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

// Reusable Gender Option Button
struct GenderOptionButton: View {
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
struct GenderSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        GenderSelectionView()
    }
}
