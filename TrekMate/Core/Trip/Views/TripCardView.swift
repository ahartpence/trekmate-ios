import SwiftUI
import MapKit


public struct TripCardView: View {
    @StateObject var viewModel = TripViewModel()
    var trip: Trip?
    var onRemove: (()-> Void)?
    
    @State private var offsetX: CGFloat = 0
    @GestureState private var dragState = DragState.inactive
    
    
    private enum DragState {
        case inactive
        case dragging(translation: CGFloat)
        
        var translation: CGFloat {
            switch self {
            case .inactive:
                return 0
            case .dragging(let translation):
                return translation
            }
        }
        
        var isDragging: Bool {
            switch self {
            case .inactive:
                return false
            case .dragging:
                return true
            }
        }
    }
    
    public var body: some View {
        ZStack {
            Color.red
            
            VStack {
                Image(systemName: "trash.fill")
                Text("Delete")
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            
            VStack {
                ZStack {
                    // Background Layer
                    ZStack {
                        Image("campground")
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width - 40, height: 400)
                            .clipped()
                    }
                    // Map Layer
                    ZStack {
                        Map()
                            .frame(width: 120, height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
                }
                .frame(height: 400)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .padding(.horizontal, 20)
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text("Summer 2025 Campathon")
                        .font(.title2.weight(.bold))
                        .foregroundColor(.primary)
                    
                    HStack (spacing: 20) {
                        VStack (alignment: .leading) {
                            Text("2 Nights")
                                .font(.callout.weight(.semibold))
                                .foregroundStyle(.primary)
                            Text("Oct 25 -  Nov 1")
                                .font(.footnote.weight(.light))
                        }
                        
                        Rectangle()
                            .frame(width: 1, height: 40)
                            .foregroundStyle(.separator)
                        
                        VStack (alignment: .leading) {
                            Text("840 Mi")
                                .font(.callout.weight(.semibold))
                                .foregroundStyle(.primary)
                            Text("12hr 41min")
                                .font(.footnote.weight(.light))
                        }
                        
                        Rectangle()
                            .frame(width: 1, height: 40)
                            .foregroundStyle(.separator)
                        
                        
                        
                        VStack (alignment: .leading) {
                            Text("7 days left")
                                .font(.callout.weight(.semibold))
                                .foregroundStyle(.primary)
                            
                            Text("until camping")
                                .font(.footnote.weight(.light))
                        }
                    }
                    .padding(.vertical, 3)
                    
                    HStack (spacing: 4) {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundStyle(.secondary)
                        Text("Sleeping Bear Dunes • Platte River Campground")
                            .font(.subheadline.weight(.light))
                            .foregroundStyle(.foreground)
                    }
                    
                    HStack (spacing: 4) {
                        Image(systemName: "location")
                            .foregroundStyle(.secondary)
                        Text("Honor, MI")
                            .font(.subheadline.weight(.light))
                            .foregroundStyle(.foreground)
                    }
                    
                    
                }
                
            }
            .background(.background)
            .offset(x: offsetX + dragState.translation)
            .simultaneousGesture(
                    DragGesture()
                        .updating($dragState) { value, state, _ in
                            if abs(value.translation.width) > abs(value.translation.height) {
                                state = .dragging(translation: value.translation.width)
                            }
                        }
                        .onEnded { value in
                            handleSwipeEnd(translation: value.translation.width)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                // Ensures animations occur after the gesture ends
                            }
                        }
                    )
            .animation(.easeOut, value: offsetX)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
    }
    
    private func handleSwipeEnd(translation: CGFloat) {
        // Define thresholds
        let threshold1: CGFloat = -80    // First detent
        let threshold2: CGFloat = -160   // Second detent
        
        withAnimation(.easeOut) {
            if translation < threshold2 {
                // User swiped past second detent: simulate deletion by sliding away
                offsetX = -UIScreen.main.bounds.width
                // Future: Add deletion logic here
                onRemove?()
            } else if translation < threshold1 {
                // User swiped past first detent: snap to first detent
                offsetX = threshold1
            } else {
                // User did not swipe enough: return to original position
                offsetX = 0
            }
        }
    }
}



struct TripCardView_Previews: PreviewProvider {
    static var previews: some View {
        TripCardView()
    }
}
