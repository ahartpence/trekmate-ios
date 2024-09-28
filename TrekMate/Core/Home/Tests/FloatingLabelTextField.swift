//
//  FloatingLabelTextField.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/22/24.
//


import UIKit

class FloatingLabelTextField: UITextField {
    let floatingLabel: UILabel = UILabel()
    let floatingLabelHeight: CGFloat = 14.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        floatingLabel.font = UIFont.systemFont(ofSize: 12)
        floatingLabel.textColor = .gray
        floatingLabel.alpha = 0.0
        self.addSubview(floatingLabel)

        addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }

    @objc private func textFieldEditingChanged() {
        updateFloatingLabel()
    }

    func updateFloatingLabel() {
        let isActive = isFirstResponder || !(text?.isEmpty ?? true)
        isActive ? showFloatingLabel() : hideFloatingLabel()
        placeholder = isActive ? nil : floatingLabel.text
    }

    private func showFloatingLabel() {
        guard floatingLabel.alpha == 0.0 else { return }
        floatingLabel.frame.origin.y = bounds.height / 2
        UIView.animate(withDuration: 0.2) {
            self.floatingLabel.alpha = 1.0
            self.floatingLabel.frame.origin.y = 0
        }
    }

    private func hideFloatingLabel() {
        guard floatingLabel.alpha == 1.0 else { return }
        UIView.animate(withDuration: 0.2) {
            self.floatingLabel.alpha = 0.0
            self.floatingLabel.frame.origin.y = self.bounds.height / 2
        }
    }

    override func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        updateFloatingLabel()
        return result
    }

    override func resignFirstResponder() -> Bool {
        let result = super.resignFirstResponder()
        updateFloatingLabel()
        return result
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        floatingLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: floatingLabelHeight)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var rect = bounds
        if floatingLabel.alpha == 1.0 {
            rect.origin.y += floatingLabelHeight
            rect.size.height -= floatingLabelHeight
        }
        return rect
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}
