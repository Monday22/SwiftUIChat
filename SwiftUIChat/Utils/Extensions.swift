//
//  Extensions.swift
//  SwiftUIChat
//
//  Created by Stephen Dowless on 1/25/21.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
