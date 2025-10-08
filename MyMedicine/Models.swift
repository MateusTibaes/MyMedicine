import SwiftUI

// MARK: - User Profile (Adicionado)
struct UserProfile: Codable {
    var name: String = "Usuário"
    var email: String = "usuario@email.com"
    var phone: String = "(11) 99999-9999"
    
    init() {}
    
    init(name: String, email: String, phone: String) {
        self.name = name
        self.email = email
        self.phone = phone
    }
}

// MARK: - Medicine Model
struct Medicine: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var description: String
    var dosage: String
    var times: [Date]
    var isActive: Bool
    var createdDate: Date
    
    init(id: UUID = UUID(), name: String, description: String, dosage: String, times: [Date], isActive: Bool = true, createdDate: Date = Date()) {
        self.id = id
        self.name = name
        self.description = description
        self.dosage = dosage
        self.times = times
        self.isActive = isActive
        self.createdDate = createdDate
    }
    
    var timesString: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return times.map { formatter.string(from: $0) }.joined(separator: ", ")
    }
}

// MARK: - Medicine History
struct MedicineHistory: Identifiable, Codable {
    let id: UUID
    let medicineId: UUID
    let medicineName: String
    let takenDate: Date
    let dosage: String
    
    init(id: UUID = UUID(), medicineId: UUID, medicineName: String, takenDate: Date, dosage: String) {
        self.id = id
        self.medicineId = medicineId
        self.medicineName = medicineName
        self.takenDate = takenDate
        self.dosage = dosage
    }
    
    var timeString: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: takenDate)
    }
}

// MARK: - Pharmacy Models
struct PharmacyProduct: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    let description: String
    let price: Double
    let category: ProductCategory
    let requiresPrescription: Bool
    let imageName: String
    let stock: Int
    
    init(id: UUID = UUID(), name: String, description: String, price: Double, category: ProductCategory, requiresPrescription: Bool, imageName: String, stock: Int) {
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.category = category
        self.requiresPrescription = requiresPrescription
        self.imageName = imageName
        self.stock = stock
    }
}

enum ProductCategory: String, CaseIterable, Codable {
    case painRelief = "Alívio da Dor"
    case vitamins = "Vitaminas"
    case allergy = "Alergia"
    case digestion = "Digestão"
    case firstAid = "Primeiros Socorros"
    case coughCold = "Tosse e Resfriado"
}
