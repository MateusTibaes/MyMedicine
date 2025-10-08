import SwiftUI

struct ProductRowView: View {
    let product: PharmacyProduct
    let onAddToCart: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: product.imageName)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 50)
                .padding(8)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .font(.headline)
                
                Text(product.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                Text("R$ \(product.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
            }
            
            Spacer()
            
            Button(action: onAddToCart) {
                Image(systemName: "cart.badge.plus")
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        .padding(.vertical, 8)
    }
}
