//
//  TMUITextFieldVIewRepresentable.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/15/24.
//

import Foundation
import SwiftUI

struct TMTextField: UIViewRepresentable {
    
    
    ///Creates a new TMTextField from a UITextField View representable
    
    @Binding var text: String
    var placeholder: String = ""
    
    init(placeholder: String = "No placeholder", text: Binding<String>) {
        self._text = text
        self.placeholder = placeholder
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = makeTextField()
        textField.delegate = context.coordinator
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.placeholder = placeholder
        
    }
    
    //UIKit to SwiftUI
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    private func makeTextField() -> UITextField {
        let textField = UITextField(frame: .zero)
        let placeholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor : UIColor.orange
            ])
        
        textField.textColor = .white
        
        textField.attributedPlaceholder = placeholder
        textField.backgroundColor = .black
        return textField
    }
    
    func updatePlaceholder(_ text: String) -> TMTextField {
        var viewRepresetnable = self
        viewRepresetnable.placeholder = text
        return viewRepresetnable
    }
    
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
        
    }
    
}

#Preview {
    
    @Previewable @State var text: String =  ""
    @Previewable @State var placeholder: String = "Placeholder asdasf"
    
    TMTextField(text: $text)
        .updatePlaceholder(placeholder)
        .frame(width: .infinity, height: 40)
    
    Button("Change") {
        placeholder.append("a")
    }
}
