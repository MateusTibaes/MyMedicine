import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            MedicineListView()
                .tabItem {
                    Image(systemName: "pills")
                    Text("Meus Remédios")
                }
                .tag(0)
            
            PharmacyStoreView()
                .tabItem {
                    Image(systemName: "bag")
                    Text("Farmácia")
                }
                .tag(1)
            
            HistoryView()
                .tabItem {
                    Image(systemName: "clock")
                    Text("Histórico")
                }
                .tag(2)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Perfil")
                }
                .tag(3)
        }
        .accentColor(.blue)
    }
} 
