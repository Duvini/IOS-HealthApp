import SwiftUI

struct OnboardingScreen: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                // Illustration
                Image("onboard1") // Replace with your image asset name
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)

                Spacer()

                // Title
                Text("Welcome!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)

                // Subtitle
                Text("Congratulations on taking the first step toward a healthier you!")
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)

                Spacer()

                // Page Indicator
                HStack(spacing: 8) {
                    Circle()
                        .fill(Color.orange)
                        .frame(width: 8, height: 8)
                    Circle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 8, height: 8)
                    Circle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 8, height: 8)
                }
                .padding()

                // Navigation Buttons
                HStack {
                    Button(action: {
                        // Handle "Skip" action
                    }) {
                        Text("Skip")
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, 30)

                    Spacer()

                    NavigationLink(destination: OnboardingSecondView()) {
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
}

// Preview
struct OnboardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen()
    }
}
