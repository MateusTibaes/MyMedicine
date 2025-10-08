import SwiftUI
import UserNotifications

@main
struct MyMedicineApp: App {
    @StateObject private var dataManager = DataManager()
    @StateObject private var notificationManager = NotificationManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataManager)
                .environmentObject(notificationManager)
                .onAppear {
                    notificationManager.requestAuthorization()
                }
        }
    }
}
