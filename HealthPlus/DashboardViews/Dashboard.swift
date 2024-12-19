import SwiftUI
import HealthKit

struct DashboardView: View {
    @State private var showHealthPermissionAlert = false
    @State private var isHealthDataAuthorized = false
    @State private var stepCount: Double = 0.0

    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                // Header
                HStack {
                    Text("Today")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "bell.fill")
                        .font(.title2)
                        .foregroundColor(.orange)
                }
                .padding(.horizontal)

                // Calorie Progress Section
                GlassCard {
                    VStack(spacing: 20) {
                        Text("Calorie Progress")
                            .font(.headline)
                            .foregroundColor(.white)

                        HStack(spacing: 20) {
                            VStack {
                                Text("1,320")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.orange)
                                Text("Eaten")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            ZStack {
                                Circle()
                                    .stroke(lineWidth: 15)
                                    .foregroundColor(.orange.opacity(0.2))
                                Circle()
                                    .trim(from: 0, to: 0.7) // Adjust for progress
                                    .stroke(lineWidth: 15)
                                    .foregroundColor(.orange)
                                    .rotationEffect(.degrees(-90))
                                Text("680\nkCal left")
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                    .font(.headline)
                            }
                            .frame(width: 120, height: 120)

                            VStack {
                                Text("250")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.orange)
                                Text("Burned")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }

                // Macro Progress Section
                GlassCard {
                    VStack(spacing: 20) {
                        Text("Macro Progress")
                            .font(.headline)
                            .foregroundColor(.white)

                        HStack(spacing: 15) {
                            ProgressCard(title: "Fat", progress: 0.5, current: 100, total: 60, color: .orange)
                            ProgressCard(title: "Protein", progress: 0.8, current: 120, total: 150, color: .purple)
                            ProgressCard(title: "Carbs", progress: 0.7, current: 150, total: 220, color: .green)
                        }
                    }
                }

                // Steps Progress Section
                GlassCard {
                    VStack(spacing: 20) {
                        Text("Steps Progress")
                            .font(.headline)
                            .foregroundColor(.white)

                        VStack(spacing: 10) {
                            HStack {
                                Text("\(Int(stepCount)) / 10,000")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                Spacer()
                                Image(systemName: "figure.walk")
                                    .foregroundColor(.orange)
                            }
                            ProgressView(value: stepCount, total: 10000)
                                .tint(.orange)
                                .frame(height: 8)
                                .accessibilityLabel(Text("Steps progress"))
                        }
                    }
                }

                Spacer()

                // Bottom Navigation
                HStack {
                    NavigationLink(destination: DashboardView()) {
                        TabItem(icon: "house.fill", title: "Home", isActive: true)
                    }
                    NavigationLink(destination: MealsView()) {
                        TabItem(icon: "fork.knife", title: "Meals", isActive: false)
                    }
                    NavigationLink(destination: ProfileView()) {
                        TabItem(icon: "person", title: "Personal", isActive: false)
                    }
                }
                .padding()
                .background(Color.black.opacity(0.9))
                .cornerRadius(30)
                .shadow(color: .orange.opacity(0.2), radius: 10, x: 0, y: -5)
            }
            .padding(.horizontal)
            .background(Color.black.ignoresSafeArea())
            .alert(isPresented: $showHealthPermissionAlert) {
                Alert(
                    title: Text("Health Data Permission"),
                    message: Text("Do you allow HealthPlus to access your health data?"),
                    primaryButton: .default(Text("Allow"), action: {
                        requestHealthAuthorization()
                    }),
                    secondaryButton: .cancel(Text("Don't Allow"))
                )
            }
            .onAppear {
                showHealthPermissionAlert = true // Trigger permission popup
            }
        }
    }

    private func requestHealthAuthorization() {
        HealthKitManager.shared.requestAuthorization { success, error in
            if success {
                isHealthDataAuthorized = true
                fetchStepCount()
            } else {
                print("HealthKit authorization failed: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }

    private func fetchStepCount() {
        HealthKitManager.shared.fetchStepCount { steps, error in
            if let steps = steps {
                DispatchQueue.main.async {
                    self.stepCount = steps
                }
            } else {
                print("Error fetching step count: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
}


// Progress Card View
struct ProgressCard: View {
    let title: String
    let progress: CGFloat
    let current: Int
    let total: Int
    let color: Color

    var body: some View {
        VStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.white)
            ProgressView(value: progress)
                .tint(color)
                .frame(height: 8)
            Text("\(current) / \(total) g")
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
    }
}

// Glass Card View
struct GlassCard<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding()
            .background(
                Color.black.opacity(0.5) // Frosted glass effect
                    .blur(radius: 10)
            )
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
            .shadow(color: .orange.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

// Tab Item View
struct TabItem: View {
    let icon: String
    let title: String
    let isActive: Bool

    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(isActive ? .orange : .gray)
            Text(title)
                .font(.footnote)
                .foregroundColor(isActive ? .orange : .gray)
        }
        .frame(maxWidth: .infinity)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
