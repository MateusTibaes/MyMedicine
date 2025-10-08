import SwiftUI

class DataManager: ObservableObject {
    @Published var medicines: [Medicine] = []
    @Published var medicineHistory: [MedicineHistory] = []
    @Published var cartItems: [PharmacyProduct] = []
    @Published var userProfile = UserProfile() // Adicionado de volta
    
    private let medicinesKey = "savedMedicines"
    private let historyKey = "medicineHistory"
    private let cartKey = "shoppingCart"
    private let profileKey = "userProfile"
    
    init() {
        loadAllData()
    }
    
    // MARK: - Medicines
    func addMedicine(_ medicine: Medicine) {
        medicines.append(medicine)
        saveMedicines()
    }
    
    func updateMedicine(_ medicine: Medicine) {
        if let index = medicines.firstIndex(where: { $0.id == medicine.id }) {
            medicines[index] = medicine
            saveMedicines()
        }
    }
    
    func deleteMedicine(_ medicine: Medicine) {
        medicines.removeAll { $0.id == medicine.id }
        saveMedicines()
    }
    
    func addMedicineHistory(_ history: MedicineHistory) {
        medicineHistory.append(history)
        saveHistory()
    }
    
    func getTodayHistory() -> [MedicineHistory] {
        return medicineHistory.filter { Calendar.current.isDateInToday($0.takenDate) }
    }
    
    // MARK: - Cart
    func addToCart(_ product: PharmacyProduct) {
        cartItems.append(product)
        saveCart()
    }
    
    func removeFromCart(_ product: PharmacyProduct) {
        cartItems.removeAll { $0.id == product.id }
        saveCart()
    }
    
    func clearCart() {
        cartItems.removeAll()
        saveCart()
    }
    
    var cartTotal: Double {
        cartItems.reduce(0) { $0 + $1.price }
    }
    
    // MARK: - User Profile
    func saveProfile() { // Adicionado de volta
        if let encoded = try? JSONEncoder().encode(userProfile) {
            UserDefaults.standard.set(encoded, forKey: profileKey)
        }
    }
    
    // MARK: - Persistence
    private func loadAllData() {
        loadMedicines()
        loadHistory()
        loadCart()
        loadProfile()
    }
    
    private func loadMedicines() {
        if let data = UserDefaults.standard.data(forKey: medicinesKey),
           let savedMedicines = try? JSONDecoder().decode([Medicine].self, from: data) {
            medicines = savedMedicines
        }
    }
    
    private func saveMedicines() {
        if let encoded = try? JSONEncoder().encode(medicines) {
            UserDefaults.standard.set(encoded, forKey: medicinesKey)
        }
    }
    
    private func loadHistory() {
        if let data = UserDefaults.standard.data(forKey: historyKey),
           let savedHistory = try? JSONDecoder().decode([MedicineHistory].self, from: data) {
            medicineHistory = savedHistory
        }
    }
    
    private func saveHistory() {
        if let encoded = try? JSONEncoder().encode(medicineHistory) {
            UserDefaults.standard.set(encoded, forKey: historyKey)
        }
    }
    
    private func loadCart() {
        if let data = UserDefaults.standard.data(forKey: cartKey),
           let savedCart = try? JSONDecoder().decode([PharmacyProduct].self, from: data) {
            cartItems = savedCart
        }
    }
    
    private func saveCart() {
        if let encoded = try? JSONEncoder().encode(cartItems) {
            UserDefaults.standard.set(encoded, forKey: cartKey)
        }
    }
    
    private func loadProfile() {
        if let data = UserDefaults.standard.data(forKey: profileKey),
           let savedProfile = try? JSONDecoder().decode(UserProfile.self, from: data) {
            userProfile = savedProfile
        }
    }
}
