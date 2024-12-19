import SwiftUI

struct RecommendedPFCView: View {
    var body: some View {
        VStack {
            Spacer()

            // Title
            Text("Recommended PFC")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.bottom, 10)

            // Subtitle
            Text("You can always change PFC in the profile")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .padding(.bottom, 40)

            // PFC Values
            VStack(spacing: 15) {
                HStack(spacing: 15) {
                    PFCChip(title: "Proteins: 225g")
                    PFCChip(title: "Fats: 118g")
                }
                HStack(spacing: 15) {
                    PFCChip(title: "Carbs: 340g")
                    PFCChip(title: "Calories: 3400")
                }
            }
            .padding(.bottom, 40)

            // Sign-In Buttons
            VStack(spacing: 15) {
                SignInButton(imageName: "google", title: "Continue with Google", action: {
                    // Handle Google sign-in
                })
                SignInButton(imageName: "envelope.fill", title: "Continue with Email", action: {
                    // Handle Email sign-in
                })
            }
            .padding(.horizontal, 20)

            Spacer()
        }
        .background(Color.black.ignoresSafeArea())
    }
}

// Reusable Chip for PFC Values
struct PFCChip: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.body)
            .fontWeight(.medium)
            .foregroundColor(.black)
            .padding()
            .background(Color.orange)
            .cornerRadius(10)
    }
}

// Reusable Sign-In Button
struct SignInButton: View {
    let imageName: String
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                NavigationLink(destination: RegistrationView()) {
                    Image(systemName: imageName)
                        .font(.title2)
                        .foregroundColor(.white)
                    Text(title)
                        .font(.body)
                        .foregroundColor(.white)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            )
        }
    }
}

// Preview
struct RecommendedPFCView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendedPFCView()
    }
}
