import SwiftUI

struct OnboardingSecondView: View {
    var body: some View {
        VStack {
            Spacer()

            // Illustration
            Image("onboard2") // Replace with your image asset name
                .resizable()
                .scaledToFit()
                .frame(height: 300)

            Spacer()

            // Title
            Text("Effortless Tracking")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)

            // Subtitle
            Text("Easily log your meals, snacks and water intake")
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
                    .fill(Color.orange)
                    .frame(width: 8, height: 8)
                Circle()
                    .fill(Color.gray.opacity(0.5))
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
                    NavigationLink(destination: OnboardingThirdView()) {
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
struct OnboardingSecondView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingSecondView()
    }
}
