import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var selectedDate = Date()
    
    var filteredHistory: [MedicineHistory] {
        dataManager.medicineHistory.filter {
            Calendar.current.isDate($0.takenDate, inSameDayAs: selectedDate)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                DatePicker("Selecione a data", selection: $selectedDate, displayedComponents: .date)
                    .padding()
                
                if filteredHistory.isEmpty {
                    Text("Nenhum registro para esta data")
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    List(filteredHistory) { history in
                        VStack(alignment: .leading) {
                            Text(history.medicineName)
                                .font(.headline)
                            Text("Dosagem: \(history.dosage)")
                                .font(.subheadline)
                            Text("Horário: \(history.timeString)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Histórico")
        }
    }
}
