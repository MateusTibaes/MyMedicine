import SwiftUI

struct AddEditMedicineView: View {
    let medicineToEdit: Medicine?
    var onSave: (Medicine) -> Void
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String
    @State private var description: String
    @State private var dosage: String
    @State private var times: [Date]
    @State private var isActive: Bool
    @State private var newTime = Date()
    
    init(medicineToEdit: Medicine? = nil, onSave: @escaping (Medicine) -> Void) {
        self.medicineToEdit = medicineToEdit
        self.onSave = onSave
        
        if let medicine = medicineToEdit {
            _name = State(initialValue: medicine.name)
            _description = State(initialValue: medicine.description)
            _dosage = State(initialValue: medicine.dosage)
            _times = State(initialValue: medicine.times)
            _isActive = State(initialValue: medicine.isActive)
        } else {
            _name = State(initialValue: "")
            _description = State(initialValue: "")
            _dosage = State(initialValue: "")
            _times = State(initialValue: [])
            _isActive = State(initialValue: true)
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Informações do Medicamento") {
                    TextField("Nome do Medicamento", text: $name)
                    TextField("Descrição", text: $description)
                    TextField("Dosagem (ex: 500mg, 1 comprimido)", text: $dosage)
                }
                
                Section("Horários do Lembrete") {
                    DatePicker("Adicionar Novo Horário", selection: $newTime, displayedComponents: .hourAndMinute)
                    
                    Button("Adicionar Horário") {
                        times.append(newTime)
                    }
                    
                    if !times.isEmpty {
                        ForEach(Array(times.enumerated()), id: \.offset) { index, time in
                            HStack {
                                Text("Horário \(index + 1)")
                                Spacer()
                                Text(time, style: .time)
                            }
                        }
                        .onDelete(perform: deleteTime)
                    }
                }
                
                Section {
                    Toggle("Lembretes Ativos", isOn: $isActive)
                }
            }
            .navigationTitle(medicineToEdit == nil ? "Adicionar Medicamento" : "Editar Medicamento")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar") {
                        let medicine = Medicine(
                            name: name.trimmingCharacters(in: .whitespaces),
                            description: description.trimmingCharacters(in: .whitespaces),
                            dosage: dosage.trimmingCharacters(in: .whitespaces),
                            times: times,
                            isActive: isActive
                        )
                        onSave(medicine)
                        dismiss()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty || times.isEmpty)
                }
            }
        }
    }
    
    private func deleteTime(at offsets: IndexSet) {
        times.remove(atOffsets: offsets)
    }
}
