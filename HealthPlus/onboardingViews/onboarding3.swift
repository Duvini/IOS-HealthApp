import SwiftUI

struct OnboardingThirdView: View {
    var body: some View {
        VStack {
            Spacer()

            // Illustration
            Image("onboard3") // Replace with your image asset name
                .resizable()
                .scaledToFit()
                .frame(height: 300)

            Spacer()

            // Title
            Text("Goal Setting")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)

            // Subtitle
            Text("Set realistic goals and watch your progress unfold")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            Spacer()

            // Page Indicator
            HStack(spacing: 8) {
                Circle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 8, height: 8)
                Circle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 8, height: 8)
                Circle()
                    .fill(Color.orange)
                    .frame(width: 8, height: 8)
            }
            .padding()

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
                    NavigationLink(destination: WelcomeView()) {
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
struct OnboardingThirdView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingThirdView()
    }
}
