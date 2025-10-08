import SwiftUI

struct CartButton: View {
    let cartItemsCount: Int
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack(alignment: .topTrailing) {
                Image(systemName: "cart")
                    .font(.title3)
                    .foregroundColor(.blue)
                
                if cartItemsCount > 0 {
                    Text("\(cartItemsCount)")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(4)
                        .background(Color.red)
                        .clipShape(Circle())
                        .offset(x: 8, y: -8)
                }
            }
        }
    }
}
