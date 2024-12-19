import SwiftUI
import CoreData

struct RegistrationView: View {
    // Access the managed object context from the environment
    @Environment(\.managedObjectContext) private var viewContext

    // State variables for user input
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var navigateToLogin: Bool = false // State to trigger navigation

    var body: some View {
        NavigationView {
            VStack {
                // Navigation Back Button and Title
                HStack {
                    Button(action: {
                        // Handle back navigation
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.title)
                    }
                    Spacer()
                    Text("Register")
                        .font(.title2)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()

                // Profile Image Placeholder (Optional)
                ZStack {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                        .overlay(
                            Circle()
                                .stroke(Color.orange, lineWidth: 2)
                        )

                    Button(action: {
                        // Handle profile image selection (e.g., open image picker)
                    }) {
                        Image(systemName: "camera.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                            .background(Color.orange)
                            .clipShape(Circle())
                            .offset(x: 40, y: 40)
                    }
                }
                .padding(.bottom, 40)

                // Name Field
                InputField(icon: "person.fill", placeholder: "Name", text: $name)

                // Email Field
                InputField(icon: "envelope.fill", placeholder: "Email", text: $email)

                // Password Field
                InputField(icon: "lock.fill", placeholder: "Password", text: $password, isSecure: !isPasswordVisible) {
                    isPasswordVisible.toggle()
                }

                // Register Button
                Button(action: {
                    saveUser() // Call the saveUser function
                }) {
                    Text("Register")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                }
                .padding(.top, 20)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Registration"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }

                // NavigationLink to LoginView
                NavigationLink(destination: LoginView(), isActive: $navigateToLogin) {
                    EmptyView() // Invisible link that triggers navigation
                }

                Spacer()
            }
            .background(Color.black.ignoresSafeArea())
        }
    }

    // Function to save user data into Core Data
    private func saveUser() {
        // Ensure all fields are filled
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty else {
            alertMessage = "Please fill out all fields."
            showAlert = true
            return
        }

        // Create a new User object in the Core Data context
        let newUser = User(context: viewContext)
        newUser.userName = name
        newUser.email = email
        newUser.password = password

        // Save the Core Data context
        do {
            try viewContext.save()
            alertMessage = "User registered successfully!"
            showAlert = true
            // Clear the input fields after saving
            name = ""
            email = ""
            password = ""
            // Navigate to LoginView after successful registration
            navigateToLogin = true
        } catch {
            alertMessage = "Failed to save user: \(error.localizedDescription)"
            showAlert = true
        }
    }
}

// Reusable Input Field Component
struct InputField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    var onTrailingIconTap: (() -> Void)? = nil

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.gray)
            if isSecure {
                SecureField(placeholder, text: $text)
                    .foregroundColor(.white)
            } else {
                TextField(placeholder, text: $text)
                    .foregroundColor(.white)
            }
            if let onTrailingIconTap = onTrailingIconTap {
                Button(action: onTrailingIconTap) {
                    Image(systemName: isSecure ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
        )
        .padding(.horizontal, 40)
    }
}

// Preview for RegistrationView
struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
            .environment(\.managedObjectContext, (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    }
}
