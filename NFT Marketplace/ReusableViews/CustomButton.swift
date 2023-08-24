//
//  CustomButton.swift
//  NFT Marketplace
//
//  Created by Вадим Кузьмин on 24.08.2023.
//

import UIKit

final class CustomButton: UIButton {
    enum ButtonType {
        case filled
        case bordered
    }

    ///  Custom button with action.
    /// - Parameters:
    ///   - type: Button style. Filled - button with filled color. Bordered - button with border.
    ///   - title: Text on button.
    ///   - action: Action to be called when button tapped..
    init(type: ButtonType, title: String, action: Selector) {
        super.init(frame: .zero)
        addTarget(nil, action: action, for: .touchUpInside)
        configure(type: type, title: title)
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
        isUserInteractionEnabled = true
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.transform = .identity
        }
        isUserInteractionEnabled = true
    }

    private func configure(type: ButtonType, title: String) {
        setTitle(title, for: .normal)
        layer.cornerRadius = 16
        layer.masksToBounds = true

        // TODO: Изменить цвета
        switch type {
        case .filled:
            backgroundColor = .black
            setTitleColor(.white, for: .normal)
            titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        case .bordered:
            backgroundColor = .white
            setTitleColor(.black, for: .normal)
            titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            layer.borderColor = UIColor.black.cgColor
            layer.borderWidth = 1
        }
    }
}
