//
//  FloatingLabelTextFieldView.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/22/24.
//


import SwiftUI

struct FloatingLabelTextFieldView: UIViewRepresentable {
    @Binding var text: String
    @Binding var placeholder: String

    func makeUIView(context: Context) -> FloatingLabelTextField {
        let textField = FloatingLabelTextField()
        textField.delegate = context.coordinator
        return textField
    }

    func updateUIView(_ uiView: FloatingLabelTextField, context: Context) {
        uiView.text = text
        uiView.floatingLabel.text = placeholder
        uiView.placeholder = uiView.isFirstResponder || !(uiView.text?.isEmpty ?? true) ? nil : placeholder
        uiView.updateFloatingLabel()
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: FloatingLabelTextFieldView

        init(_ parent: FloatingLabelTextFieldView) {
            self.parent = parent
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async {
                self.parent.text = textField.text ?? ""
            }
        }
    }
}
