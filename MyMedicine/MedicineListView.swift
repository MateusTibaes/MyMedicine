import SwiftUI

struct MedicineListView: View {
    @EnvironmentObject var dataManager: DataManager
    @EnvironmentObject var notificationManager: NotificationManager
    @State private var showingAddMedicine = false
    @State private var medicineToEdit: Medicine?
    @State private var searchText = ""
    
    var filteredMedicines: [Medicine] {
        if searchText.isEmpty {
            return dataManager.medicines
        } else {
            return dataManager.medicines.filter { medicine in
                medicine.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if !dataManager.medicines.isEmpty {
                    HStack {
                        VStack {
                            Text("\(dataManager.medicines.count)")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            Text("Medicamentos")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text("\(dataManager.getTodayHistory().count)")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.green)
                            Text("Tomados Hoje")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                }
                
                if dataManager.medicines.isEmpty {
                    EmptyMedicineView()
                } else {
                    List {
                        ForEach(filteredMedicines) { medicine in
                            MedicineRowView(
                                medicine: medicine,
                                onEdit: { editMedicine($0) },
                                onMarkTaken: { markAsTaken($0) }
                            )
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    deleteMedicine(medicine)
                                } label: {
                                    Label("Deletar", systemImage: "trash")
                                }
                                
                                Button {
                                    editMedicine(medicine)
                                } label: {
                                    Label("Editar", systemImage: "pencil")
                                }
                                .tint(.blue)
                            }
                            .swipeActions(edge: .leading) {
                                Button {
                                    markAsTaken(medicine)
                                } label: {
                                    Label("Tomado", systemImage: "checkmark")
                                }
                                .tint(.green)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Meus Remédios")
            .searchable(text: $searchText, prompt: "Buscar medicamentos...")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        medicineToEdit = nil
                        showingAddMedicine = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddMedicine) {
                AddEditMedicineView(medicineToEdit: medicineToEdit) { medicine in
                    if medicineToEdit != nil {
                        dataManager.updateMedicine(medicine)
                    } else {
                        dataManager.addMedicine(medicine)
                    }
                    notificationManager.scheduleMedicineNotification(for: medicine)
                    medicineToEdit = nil
                }
            }
        }
    }
    
    private func editMedicine(_ medicine: Medicine) {
        medicineToEdit = medicine
        showingAddMedicine = true
    }
    
    private func deleteMedicine(_ medicine: Medicine) {
        dataManager.deleteMedicine(medicine)
        notificationManager.removeNotifications(for: medicine)
    }
    
    private func markAsTaken(_ medicine: Medicine) {
        let historyItem = MedicineHistory(
            medicineId: medicine.id,
            medicineName: medicine.name,
            takenDate: Date(),
            dosage: medicine.dosage
        )
        dataManager.addMedicineHistory(historyItem)
    }
}

struct MedicineRowView: View {
    let medicine: Medicine
    let onEdit: (Medicine) -> Void
    let onMarkTaken: (Medicine) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(medicine.name)
                    .font(.headline)
                
                Spacer()
                
                HStack(spacing: 12) {
                    Button(action: { onEdit(medicine) }) {
                        Image(systemName: "pencil")
                            .foregroundColor(.blue)
                    }
                    
                    Button(action: { onMarkTaken(medicine) }) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                    }
                    
                    Image(systemName: medicine.isActive ? "bell.fill" : "bell.slash")
                        .foregroundColor(medicine.isActive ? .green : .red)
                }
            }
            
            Text(medicine.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text("Dosagem: \(medicine.dosage)")
                .font(.caption)
            
            Text("Horários: \(medicine.timesString)")
                .font(.caption)
                .foregroundColor(.blue)
        }
        .padding(.vertical, 4)
    }
}

struct EmptyMedicineView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "pills")
                .font(.system(size: 60))
                .foregroundColor(.gray.opacity(0.5))
            
            Text("Nenhum Medicamento Adicionado")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Toque no botão + para adicionar seu primeiro lembrete")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}
