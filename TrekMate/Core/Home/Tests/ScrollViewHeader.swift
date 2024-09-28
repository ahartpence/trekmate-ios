import SwiftUI

//public struct ScrollViewHeader<Content: View>: View {
//
//    public init(
//        @ViewBuilder content: @escaping () -> Content
//    ) {
//        self.content = content
//    }
//
//    private let content: () -> Content
//
//    public var body: some View {
//        GeometryReader { geo in
//            content()
//                .stretchable(in: geo)
//                .onScrollGeometryChange(for: CGFloat.self, of: { geometry in
//                    geometry.contentOffset.y
//                }, action: { oldOffset, newOffset in
//                    handleScrollChange(oldOffset: oldOffset, newOffset: newOffset)
//                })
//        }
//    }
//
//    private func handleScrollChange(oldOffset: CGFloat, newOffset: CGFloat) {
//        // Handle scroll geometry changes, e.g., trigger animations or update state
//        // For example: print("Old: \(oldOffset), New: \(newOffset)")
//    }
//}
//
//private extension View {
//
//    @ViewBuilder
//    func stretchable(in geo: GeometryProxy) -> some View {
//        let minY = geo.frame(in: .global).minY
//        let useStandard = minY <= 0
//        self.frame(width: geo.size.width, height: geo.size.height + (useStandard ? 0 : minY))
//            .offset(y: useStandard ? 0 : -minY)
//    }
//}
//
//#Preview {
//    struct Preview: View {
//
//        var body: some View {
//            #if canImport(UIKit)
//            NavigationView {
//                content
//            }
//            .accentColor(.white)
//            .colorScheme(.dark)
//            #else
//            content
//                .accentColor(.white)
//                .colorScheme(.dark)
//            #endif
//        }
//
//        var content: some View {
//            ScrollView {
//                VStack {
//                    ScrollViewHeader {
//                        TabView {
//                            Color.red
//                            Color.green
//                            Color.blue
//                        }
//                        #if canImport(UIKit)
//                        .tabViewStyle(.page)
//                        #endif
//                    }
//                    .frame(height: 250)
//
//                    LazyVStack {
//                        ForEach(0...100, id: \.self) {
//                            Text("\($0)")
//                        }
//                    }
//                }
//            }
//            .navigationTitle("Test")
//            #if os(iOS)
//            .navigationBarTitleDisplayMode(.inline)
//            #endif
//        }
//    }
//
//    return Preview()
//}
