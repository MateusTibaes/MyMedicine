import SwiftUI

struct ProductDetailView: View {
    let product: PharmacyProduct
    let onAddToCart: () -> Void
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: product.imageName)
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(20)
                
                VStack(spacing: 12) {
                    Text(product.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    
                    if product.requiresPrescription {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.orange)
                            Text("Receita Obrigatória")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.orange)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(8)
                    }
                    
                    Text(product.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    
                    Text("R$ \(product.price, specifier: "%.2f")")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
                .padding(.horizontal)
                
                Button(action: {
                    onAddToCart()
                    dismiss()
                }) {
                    Text("Adicionar ao Carrinho")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Detalhes do Produto")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Fechar") {
                        dismiss()
                    }
                }
            }
        }
    }
}
