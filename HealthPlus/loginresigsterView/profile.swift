import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                HStack {
                    Text("Profile")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: {
                        // Handle profile edit action
                    }) {
                        Image(systemName: "square.and.pencil")
                            .font(.title2)
                            .foregroundColor(.orange)
                    }
                }
                .padding(.horizontal)

                // Profile Info Section
                VStack(spacing: 10) {
                    // Profile Image
                    VStack {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .foregroundColor(.orange)
                        Text("Dinidu Ekanayaka")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("dini@gmail.com")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("Member Since: 20 Nov 2024")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Button(action: {
                            // Handle profile edit action
                        }) {
                            Text("Edit Profile")
                                .font(.caption)
                                .foregroundColor(.orange)
                        }
                    }

                    // Health Goals Card
                    VStack(spacing: 15) {
                        HStack {
                            Text("Health Goals")
                                .font(.headline)
                                .foregroundColor(.white)
                            Spacer()
                            Button(action: {
                                // Handle view more action
                            }) {
                                Text("View More")
                                    .font(.subheadline)
                                    .foregroundColor(.orange)
                            }
                        }

                        VStack(spacing: 15) {
                            ProfileGoalRow(icon: "scalemass", title: "Weight Goal", value: "2000.50 kg")
                            ProfileGoalRow(icon: "figure.walk", title: "Steps Goal", value: "10000 steps")
                            ProfileGoalRow(icon: "flame", title: "Calories Goal", value: "2000 kcal")
                            ProfileGoalRow(icon: "drop.fill", title: "Protein Goal", value: "150 g")
                            ProfileGoalRow(icon: "leaf.fill", title: "Carbs Goal", value: "220 g")
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(15)
                    }
                    .padding(.horizontal)
                }

                // Additional Options
                VStack(spacing: 15) {
                    NavigationLink(destination: Text("Health Records")) {
                        ProfileOptionRow(icon: "folder.fill", title: "Health Records")
                    }
                    NavigationLink(destination: Text("Progress Charts")) {
                        ProfileOptionRow(icon: "chart.bar.fill", title: "Progress Charts")
                    }
                    NavigationLink(destination: Text("Daily Activities")) {
                        ProfileOptionRow(icon: "heart.fill", title: "Daily Activities")
                    }
                    NavigationLink(destination: Text("App Settings")) {
                        ProfileOptionRow(icon: "gearshape.fill", title: "App Settings")
                    }
                    NavigationLink(destination: Text("Privacy")) {
                        ProfileOptionRow(icon: "lock.fill", title: "Privacy")
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top, 30) // Add top padding here
        }
        .background(Color.black.ignoresSafeArea())
    }
}

// Reusable Components
struct ProfileGoalRow: View {
    let icon: String
    let title: String
    let value: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.orange)
                .font(.title2)
            Text(title)
                .font(.subheadline)
                .foregroundColor(.white)
            Spacer()
            Text(value)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

struct ProfileOptionRow: View {
    let icon: String
    let title: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.orange)
                .font(.title2)
            Text(title)
                .font(.subheadline)
                .foregroundColor(.white)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(15)
    }
}

// Preview
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
