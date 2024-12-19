import SwiftUI

struct HeightSelectionView: View {
    @State private var selectedMeters = 1
    @State private var selectedCentimeters = 70

    var body: some View {
        VStack {
            Spacer()

            // Title
            Text("How tall are you?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.bottom, 10)

            // Subtitle
            Text("The taller you are, the more calories your body needs")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .padding(.bottom, 40)

            // Height Picker
            HStack(spacing: 20) { // Add spacing between the two pickers
                VStack {
                    Text("Meters")
                        .font(.headline)
                        .foregroundColor(.gray)

                    Picker("Meters", selection: $selectedMeters) {
                        ForEach(1..<3) { meter in
                            Text("\(meter)")
                                .font(.title2) // Larger font for visibility
                                .foregroundColor(.white) // Ensure numbers are visible
                                .tag(meter)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 120, height: 150) // Adjust frame for visibility
                }

                VStack {
                    Text("Centimeters")
                        .font(.headline)
                        .foregroundColor(.gray)

                    Picker("Centimeters", selection: $selectedCentimeters) {
                        ForEach(0..<100) { cm in
                            Text("\(cm)")
                                .font(.title2) // Larger font for visibility
                                .foregroundColor(.white) // Ensure numbers are visible
                                .tag(cm)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 120, height: 150) // Adjust frame for visibility
                }
            }
            .foregroundColor(.orange)
            .padding(.horizontal, 20)

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

                NavigationLink(destination: WeightSelectionView()) {
                    Image(systemName: "arrow.right")
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Color.orange)
                        .clipShape(Circle())
                }
                .padding(.trailing, 30)
            }
            .padding(.bottom, 20)
        }
        .background(Color.black.ignoresSafeArea())
    }
}

// Preview
struct HeightSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        HeightSelectionView()
    }
}
