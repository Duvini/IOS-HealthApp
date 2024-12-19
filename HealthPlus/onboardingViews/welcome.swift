import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Spacer()

            // Logo
            Image("logo") // Replace with your custom logo asset
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(Color.green)

            // Title
            Text("Welcome")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, 20)

            // Subtitle
            Text("Tell Us About Yourself")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .padding(.top, 5)

            Spacer()

            // "Start" Button
            Button(action: {
                // Handle "Start" action
            }) {
                NavigationLink(destination: GoalSelectionView()) {
                    Text("Start")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                }
            }

            // "Sign In" Link
            HStack {
                Text("Hanging on Almost there")
                    .foregroundColor(.gray)
                
            }
            .padding(.top, 10)

            Spacer()
        }
        .background(Color.black.ignoresSafeArea())
    }
}

// Preview
struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

