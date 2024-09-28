//
//  Extensions.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 9/29/24.
//

import SwiftUI

extension VStack {
    func resizablePanelGesture(size: Binding<CGFloat>, minHeight: CGFloat, maxHeight: CGFloat) -> some View {
        return self
            .gesture(DragGesture()
                .onChanged { value in
                    let newHeight = size.wrappedValue - value.translation.height
                    if newHeight >= minHeight && newHeight <= maxHeight {
                        size.wrappedValue = newHeight
                    }
                }
                .onEnded { value in
                    // Optional: Add logic for snapping back or finalizing size
                }
            )
    }
}
