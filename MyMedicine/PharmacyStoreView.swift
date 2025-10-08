import SwiftUI

struct PharmacyStoreView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var products: [PharmacyProduct] = []
    @State private var searchText = ""
    @State private var selectedCategory: ProductCategory?
    @State private var showingCart = false
    @State private var showingProductDetail: PharmacyProduct?
    
    var filteredProducts: [PharmacyProduct] {
        products.filter { product in
            let matchesSearch = searchText.isEmpty ||
                product.name.localizedCaseInsensitiveContains(searchText) ||
                product.description.localizedCaseInsensitiveContains(searchText)
            
            let matchesCategory = selectedCategory == nil || product.category == selectedCategory
            
            return matchesSearch && matchesCategory
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                CategoryFilterView(selectedCategory: $selectedCategory)
                    .padding(.horizontal)
                
                if filteredProducts.isEmpty {
                    EmptyStoreView()
                } else {
                    List(filteredProducts) { product in
                        ProductRowView(product: product) {
                            dataManager.addToCart(product)
                        }
                        .onTapGesture {
                            showingProductDetail = product
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Farmácia")
            .searchable(text: $searchText, prompt: "Buscar medicamentos...")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    CartButton(cartItemsCount: dataManager.cartItems.count) {
                        showingCart = true
                    }
                }
            }
            .sheet(isPresented: $showingCart) {
                CartView()
            }
            .sheet(item: $showingProductDetail) { product in
                ProductDetailView(product: product) {
                    dataManager.addToCart(product)
                    showingProductDetail = nil
                }
            }
            .onAppear {
                loadSampleProducts()
            }
        }
    }
    
    private func loadSampleProducts() {
        products = [
            PharmacyProduct(
                name: "Ibuprofeno 200mg",
                description: "Analgésico e antitérmico - 24 comprimidos",
                price: 8.99,
                category: .painRelief,
                requiresPrescription: false,
                imageName: "pills",
                stock: 50
            ),
            PharmacyProduct(
                name: "Vitamina C 1000mg",
                description: "Suporte ao sistema imunológico - 60 comprimidos",
                price: 12.49,
                category: .vitamins,
                requiresPrescription: false,
                imageName: "leaf",
                stock: 30
            ),
            PharmacyProduct(
                name: "Alívio de Alergia",
                description: "Para sintomas de alergia sazonal - 30 comprimidos",
                price: 15.99,
                category: .allergy,
                requiresPrescription: false,
                imageName: "allergens",
                stock: 25
            )
        ]
    }
}

struct CartView: View {
    @EnvironmentObject var dataManager: DataManager
    @Environment(\.dismiss) private var dismiss
    @State private var showingCheckoutConfirmation = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if dataManager.cartItems.isEmpty {
                    EmptyCartView()
                } else {
                    List {
                        ForEach(dataManager.cartItems) { item in
                            HStack {
                                Image(systemName: item.imageName)
                                    .foregroundColor(.blue)
                                    .frame(width: 40)
                                
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text("R$ \(item.price, specifier: "%.2f")")
                                        .font(.subheadline)
                                        .foregroundColor(.green)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    dataManager.removeFromCart(item)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    
                    VStack(spacing: 16) {
                        Divider()
                        
                        HStack {
                            Text("Total:")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text("R$ \(dataManager.cartTotal, specifier: "%.2f")")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.green)
                        }
                        .padding(.horizontal)
                        
                        Button(action: {
                            showingCheckoutConfirmation = true
                        }) {
                            Text("Finalizar Compra")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                    .background(Color(.systemBackground))
                }
            }
            .navigationTitle("Carrinho")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Fechar") {
                        dismiss()
                    }
                }
            }
            .alert("Pedido Confirmado", isPresented: $showingCheckoutConfirmation) {
                Button("OK") {
                    dataManager.clearCart()
                    dismiss()
                }
            } message: {
                Text("Seu pedido foi realizado com sucesso!\nTotal: R$ \(dataManager.cartTotal, specifier: "%.2f")")
            }
        }
    }
}

struct EmptyCartView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "cart")
                .font(.system(size: 80))
                .foregroundColor(.gray.opacity(0.5))
            
            Text("Seu carrinho está vazio")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Adicione produtos da loja")
                .font(.body)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
