import SwiftUI

let keywords: [String] = [
    "Dogs On Lead", "Child-friendly", "Partially Paved", "Hiking",
    "Running", "Beach", "Cave", "Forest", "Historic Site",
    "Views", "Wildlife", "Wildflowers"
]
import SwiftUI
import UIKit // Needed for UIFont

// Extension to calculate text width
extension String {
    func sizeOfText(font: UIFont) -> CGFloat {
        let attributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: attributes)
        return size.width
    }
}


struct KeywordSectionLayout<Content: View>: View {
    let items: [String]
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let content: (String) -> Content
    
    init(items: [String], spacing: CGFloat = 8, alignment: HorizontalAlignment = .leading, @ViewBuilder content: @escaping (String) -> Content) {
        self.items = items
        self.spacing = spacing
        self.alignment = alignment
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: alignment, spacing: spacing) {
            ForEach(computeRows(), id: \.self) { row in
                HStack(spacing: spacing) {
                    ForEach(row, id: \.self) { item in
                        content(item)
                    }
                }
            }
        }
    }
    
    private func computeRows() -> [[String]] {
        var rows: [[String]] = [[]]
        var currentRowWidth: CGFloat = 0
        let maxWidth = UIScreen.main.bounds.width - 32 // Adjust based on padding
        
        for item in items {
            let itemWidth = item.sizeOfText(font: UIFont.systemFont(ofSize: 16)) + 20 // Padding and border
            
            if currentRowWidth + itemWidth + spacing > maxWidth {
                rows.append([item])
                currentRowWidth = itemWidth
            } else {
                rows[rows.count - 1].append(item)
                currentRowWidth += itemWidth + spacing
            }
        }
        
        return rows
    }
}

// ActivitiesSection View
struct ActivitiesSection: View {
    var body: some View {
        KeywordSectionLayout(items: keywords, spacing: 8, alignment: .leading) { keyword in
            Text(keyword)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

struct ActivitiesSection_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesSection()
    }
}
