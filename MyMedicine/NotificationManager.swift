import UserNotifications
import SwiftUI

class NotificationManager: ObservableObject {
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification authorization granted")
            } else if let error = error {
                print("Notification authorization error: \(error)")
            }
        }
    }
    
    func scheduleMedicineNotification(for medicine: Medicine) {
        guard medicine.isActive else { return }
        
        removeNotifications(for: medicine)
        
        for time in medicine.times {
            let content = UNMutableNotificationContent()
            content.title = "💊 Hora do Remédio"
            content.body = "Está na hora de tomar \(medicine.name) - \(medicine.dosage)"
            content.sound = .default
            
            let triggerComponents = Calendar.current.dateComponents([.hour, .minute], from: time)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerComponents, repeats: true)
            
            let request = UNNotificationRequest(
                identifier: "\(medicine.id.uuidString)-\(time.timeIntervalSince1970)",
                content: content,
                trigger: trigger
            )
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error)")
                }
            }
        }
    }
    
    func removeNotifications(for medicine: Medicine) {
        let identifiers = medicine.times.map { "\(medicine.id.uuidString)-\($0.timeIntervalSince1970)" }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
    }
}
