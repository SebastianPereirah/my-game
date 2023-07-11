//
//  RegularButton.swift
//  MyGame
//
//  Created by Mac on 11.07.2023.
//

import Foundation
import UIKit

class RegularButton: UIButton {
    convenience init() {
        self.init(frame: .zero)
        frame.size.width = 80 // Ширина кнопки
        frame.size.height = 80 // Высота кнопки
        backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 1, alpha: 1) // Цвет кнопки
        layer.borderColor = UIColor.blue.cgColor // Цвет рамки кнопки
        layer.borderWidth = 2.0 // Толщина рамки кнопки
        layer.cornerRadius = 10 // Радиус закругления кнопки
        layer.masksToBounds = true // Указываем, чтобы слой кнопки обрезался по границе закругления
        titleLabel?.font = UIFont.systemFont(ofSize: 33) // Размер шрифта на кнопке
    }
}
