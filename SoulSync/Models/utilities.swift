//
//  utilities.swift
//  SoulSync
//
//  Created by Jeegrra on 10/04/2024.
//

import Foundation
import UIKit

class Utilities {
    //validate password
    static func isPasswordValid(_ password: String?) -> Bool {
        guard let password = password else {
            return false
        }
        let passwordRegex = "^(?=.*[a-z])(?=.*[\\$@#!%*?&])[A-Za-z\\d\\$@#!%*?&]{8,}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
    
    //validate email
    static func isEmailValid(_ email: String?) -> Bool {
        guard let email = email else {
            return false
        }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    static func isMobileNumberValid(_ mobileNumber: String?) -> Bool {
        guard let mobileNumber = mobileNumber else {
            return false
        }
        let mobileNumberRegex = "^[0-9]{7,15}$"
        let mobileNumberTest = NSPredicate(format: "SELF MATCHES %@", mobileNumberRegex)
        return mobileNumberTest.evaluate(with: mobileNumber)
    }

}

class LabelledDivider: UIView {
    
    let label: String
    let horizontalPadding: CGFloat
    let color: UIColor
    
    private let lineView = UIView()
    private let labelView = UILabel()

    @IBInspectable var labelText: String {
        get {
            return labelView.text ?? ""
        }
        set {
            labelView.text = newValue
        }
    }
    
    init(label: String, horizontalPadding: CGFloat = 20, color: UIColor = .gray) {
        self.label = label
        self.horizontalPadding = horizontalPadding
        self.color = color
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.label = aDecoder.decodeObject(forKey: "label") as? String ?? ""
        self.horizontalPadding = aDecoder.decodeObject(forKey: "horizontalPadding") as? CGFloat ?? 20
        self.color = aDecoder.decodeObject(forKey: "color") as? UIColor ?? .gray
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(label, forKey: "label")
        aCoder.encode(horizontalPadding, forKey: "horizontalPadding")
        aCoder.encode(color, forKey: "color")
    }
    
    private func setupViews() {
        // Label view
        addSubview(labelView)
        labelView.textColor = color
        labelView.textAlignment = .center
        labelView.font = UIFont.systemFont(ofSize: 14)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        
        // Line view
        addSubview(lineView)
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints
        NSLayoutConstraint.activate([
            labelView.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            lineView.topAnchor.constraint(equalTo: topAnchor),
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: horizontalPadding),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -horizontalPadding),
            lineView.widthAnchor.constraint(equalToConstant: 1)
        ])
    }
}
