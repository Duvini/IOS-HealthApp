import SwiftUI

struct WeightSelectionView: View {
    @State private var weight: String = ""

    var body: some View {
        VStack {
            Spacer()

            // Title
            Text("What's your weight?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.bottom, 10)

            // Subtitle
            Text("The more you weigh, the more calories your body burns")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .padding(.bottom, 40)

            // Weight Input
            HStack {
                TextField("Enter weight", text: $weight)
                    .keyboardType(.decimalPad)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.clear)
                    .frame(width: 150)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.orange),
                        alignment: .bottom
                    )

                Text("kg")
                    .foregroundColor(.orange)
            }
            .padding(.horizontal, 40)

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
                    print("Weight entered: \(weight)")
                }) {
                    NavigationLink(destination: NutritionGoalsView()) {
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

// Preview
struct WeightSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        WeightSelectionView()
    }
}
