//
//  RegularText.swift
//  MyGame
//
//  Created by Mac on 11.07.2023.
//

import Foundation
import UIKit

class RegularText: UILabel {
    convenience init() {
        self.init(frame: .zero)
        font = UIFont(name: "Helvetica", size: 22)
    }
}
