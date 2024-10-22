//
//  UIApplication.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/21/24.
//

import SwiftUI

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
