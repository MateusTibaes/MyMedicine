import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var showingEditProfile = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Informações Pessoais")) {
                    InfoRow(title: "Nome", value: dataManager.userProfile.name)
                    InfoRow(title: "Email", value: dataManager.userProfile.email)
                    InfoRow(title: "Telefone", value: dataManager.userProfile.phone)
                    
                    Button("Editar Perfil") {
                        showingEditProfile = true
                    }
                    .foregroundColor(.blue)
                }
                
                Section(header: Text("Estatísticas")) {
                    Text("Medicamentos: \(dataManager.medicines.count)")
                    Text("Histórico: \(dataManager.medicineHistory.count)")
                    Text("Carrinho: \(dataManager.cartItems.count) itens")
                }
            }
            .navigationTitle("Perfil")
            .sheet(isPresented: $showingEditProfile) {
                EditProfileView()
            }
        }
    }
}

struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
        }
    }
}

struct EditProfileView: View {
    @EnvironmentObject var dataManager: DataManager
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String
    @State private var email: String
    @State private var phone: String
    
    init() {
        // Inicializar com dados atuais
        _name = State(initialValue: DataManager().userProfile.name)
        _email = State(initialValue: DataManager().userProfile.email)
        _phone = State(initialValue: DataManager().userProfile.phone)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Informações Pessoais")) {
                    TextField("Nome", text: $name)
                    TextField("Email", text: $email)
                    TextField("Telefone", text: $phone)
                }
            }
            .navigationTitle("Editar Perfil")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salvar") {
                        saveProfile()
                    }
                }
            }
            .onAppear {
                // Carregar dados atuais ao aparecer
                name = dataManager.userProfile.name
                email = dataManager.userProfile.email
                phone = dataManager.userProfile.phone
            }
        }
    }
    
    private func saveProfile() {
        dataManager.userProfile = UserProfile(
            name: name,
            email: email,
            phone: phone
        )
        dataManager.saveProfile()
        dismiss()
    }
}
