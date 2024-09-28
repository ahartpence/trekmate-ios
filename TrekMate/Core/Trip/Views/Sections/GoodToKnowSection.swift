import SwiftUI

struct GoodToKnowItem: Identifiable {
    let id = UUID()
    let iconName: String
    let title: String
    let subtitle: String
}

struct GoodToKnowRow: View {
    let item: GoodToKnowItem
    let showDivider: Bool
    
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: item.iconName, variableValue: 0.10)
                .font(.title2)
                .padding(.leading, 5)
                .padding(.trailing, 15)
            
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.subheadline.weight(.bold))
                Text(item.subtitle)
                    .font(.caption)
                    .padding(.bottom, 10)
            }
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .overlay(
            Group {
                if showDivider {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.border)
                        .padding(.leading, 40) // Adjust to align with text
                }
            },
            alignment: .bottom
        )
    }
}

struct GoodToKnowSection: View {
    let items: [GoodToKnowItem] = [
        GoodToKnowItem(iconName: "antenna.radiowaves.left.and.right", title: "Poor Cell Signal", subtitle: "Cell signal for this campground is reported to be low. Try using StarkLink if you have it"),
        GoodToKnowItem(iconName: "moon.fill", title: "", subtitle: "57° and clear sky"),
        // Add more items as needed
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            VStack(alignment: .leading) {
                Text("Good to know")
                    .font(.title2.weight(.semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Information about this trip")
                    .font(.callout.weight(.semibold))
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 8)
            
            ForEach(items.indices, id: \.self) { index in
                let item = items[index]
                GoodToKnowRow(item: item, showDivider: index != items.count - 1)
            }
        }
        .padding(.horizontal, 5)
        .padding(.vertical, 5)
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(.border, lineWidth: 1)
        )
        .padding(.top, 10)
        .padding(.horizontal, 10)
    }
}

#Preview {
    GoodToKnowSection()
}
