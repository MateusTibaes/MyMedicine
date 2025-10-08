import SwiftUI

struct EmptyStoreView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 60))
                .foregroundColor(.gray.opacity(0.5))
            
            Text("Nenhum produto encontrado")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Tente ajustar sua busca ou filtro")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
