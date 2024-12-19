import SwiftUI
import CoreData

struct LoginView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var navigateToDashboard: Bool = false // State for navigation

    var body: some View {
        NavigationStack {
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
                    Text("Login")
                        .font(.title2)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()

                // Profile Picture
                ZStack {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.orange, lineWidth: 2)
                        )
                }
                .padding(.bottom, 40)

                // Email Field
                InputField(icon: "envelope.fill", placeholder: "Email", text: $email)

                // Password Field
                InputField(icon: "lock.fill", placeholder: "Password", text: $password, isSecure: !isPasswordVisible) {
                    isPasswordVisible.toggle()
                }

                // Login Button
                Button(action: {
                    loginUser() // Call the loginUser function
                }) {
                    Text("Login")
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
                    Alert(title: Text("Login Failed"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }

                // Forgot Password Link
                Button(action: {
                    // Handle forgot password action
                }) {
                    Text("Forgot password?")
                        .font(.body)
                        .foregroundColor(Color.orange)
                }
                .padding(.top, 10)

                Spacer()
            }
            .background(Color.black.ignoresSafeArea())
            .navigationDestination(isPresented: $navigateToDashboard) {
                DashboardView() // Destination when navigation occurs
            }
        }
    }

    // Function to check user credentials
    private func loginUser() {
        // Fetch User objects from Core Data
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email) // Match email

        do {
            let users = try viewContext.fetch(fetchRequest)

            if let user = users.first, user.password == password {
                // Credentials are correct
                navigateToDashboard = true
            } else {
                // Incorrect credentials
                alertMessage = "Incorrect email or password."
                showAlert = true
            }
        } catch {
            alertMessage = "An error occurred while checking your credentials. Please try again."
            showAlert = true
        }
    }
}

// Preview
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environment(\.managedObjectContext, (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    }
}
