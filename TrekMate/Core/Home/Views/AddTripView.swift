//import SwiftUI
//import SwiftRecGovApi
//
//// Extension to dismiss the keyboard
//extension View {
//    func hideKeyboard() {
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//}
//
//struct AddTripView: View  {
//    @Binding var isPresented: Bool
//    @Binding var trips: [Trip]
//    
//    
//    @State private var text: String = ""
//    @State private var placeholder: String = "Enter text"
//    
//    var body: some View  {
//        NavigationStack {
//            VStack{
//                VStack (alignment: .leading) {
//                    Text("Create a new trip")
//                        .font(.headline)
//                        .fontWeight(.bold)
//                        .padding(.bottom, 10)
//                    
//                    Text("Track the things you love and plan your whole trip")
//                        .font(.subheadline)
//                }
//                
////                SearchView()
//                
//                FloatingLabelTextFieldView(text: $text, placeholder: $placeholder)
//                    .frame(height: 60)
//                    .clipShape(.rect)
//                    .border(.blue)
//                    
//                
//                Button {
//                    isPresented.toggle()
//                    trips.append(Trip(name: "Summer 2025 Campathon", location: nil))
//                } label: {
//                    ZStack {
//                        // Blue background rectangle
//                        Rectangle()
//                            .fill(Color.blue)
//                            .cornerRadius(10)
//                            .frame(width: 250, height: 50)
//                       
//                        // Text displayed in the center
//                        Text("Save")
//                            .foregroundColor(.white)
//                            .font(.headline)
//                    }
//                    .padding()
//                }
//            }
//            .contentShape(Rectangle()) // Makes the entire VStack tappable
//            .onTapGesture {
//                hideKeyboard()
//            }
//        }
//    }
//}
//
//
//#Preview {
//    AddTripView(isPresented: .constant(false), trips: .constant([]))
//}
