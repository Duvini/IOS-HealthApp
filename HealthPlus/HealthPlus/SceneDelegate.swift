import UIKit
import SwiftUI
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    // Access the persistent container from AppDelegate
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Pass the managed object context to SwiftUI views
        let context = persistentContainer.viewContext

        // Decide the initial view based on onboarding completion
        let hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
        let rootView: AnyView

        if hasCompletedOnboarding {
            rootView = AnyView(DashboardView().environment(\.managedObjectContext, context))
        } else {
            rootView = AnyView(OnboardingScreen().environment(\.managedObjectContext, context))
        }

        // Set up the window and root view controller
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIHostingController(rootView: rootView)
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Undo changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Save changes in the application's managed object context when the application transitions to the background.
        saveContext()
    }

    // MARK: - Core Data Saving Support
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
