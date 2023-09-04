//
//  ProfileEditStackView.swift
//  NFT Marketplace
//
//  Created by Денис on 31.08.2023.
//


import UIKit

class ProfileEditStackView: UIStackView {
    
    // Лейбл для отображения названия поля
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .blackDayNight
        return label
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .lightGreyDayNight
        textView.textColor = .blackDayNight
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.isScrollEnabled = false // чтобы textView изменял свой размер в зависимости от содержимого
        textView.text = ""
        
        textView.layer.cornerRadius = 12
        textView.clipsToBounds = true
        
        // Устанавил отступы по краям
        textView.textContainerInset = UIEdgeInsets(top: 11, left: 16, bottom: 11, right: 16)
        
        // Создание панели с кнопкой "Готово" для textView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: S.ProfileEditStackView.keyboardDoneButton,
                                         style: .done, target: self, action: #selector(dismissKeyboard))
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        textView.inputAccessoryView = toolBar
        
        return textView
    }()
    
    // Инициализация со значениями
    init(labelText: String, textContent: String) {
        super.init(frame: .zero)
        
        label.text = labelText
        textView.text = textContent
        
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Private Methods
    private func setupViews() {
        addArrangedSubview(label)
        addArrangedSubview(textView)
        
        axis = .vertical
        spacing = 8
    }
    
    func getTextContent() -> String? {
        return textView.text
    }
    
    func updateTextContent(_ text: String) {
        textView.text = text
    }
    
    @objc func dismissKeyboard() {
        textView.resignFirstResponder()
    }
    
}
