//
//  ViewController.swift
//  MyGame
//
//  Created by Mac on 11.07.2023.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - переменные

    // число которое загадал кот
    var catsNumber = 0
    // счетчик побед
    var winCount = 0
    // счетчик jgражений
    var loseCount = 0

    // лейблы (собственный класс RegularText в котором заданы установки шрифта для лейблов)
    let labelWinCount = RegularText() // лейбл победы
    let labelLoseCount = RegularText() // лейбл поражения
    let labelTextUnderCat = RegularText() // лейбл текста под котом

    // Создаем экземпляр класса UIImageView для кота
    let imageCat = UIImageView()
    
    //Создаем переключатель для кота
    let catSwitch = UISwitch()

    // кнопки 1, 2, 3 и сброс счета
    let button1 = RegularButton()
    let button2 = RegularButton()
    let button3 = RegularButton()
    let buttonResetScore = RegularButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // цвет фона
        view.backgroundColor = UIColor(red: 0.7, green: 0.9, blue: 0.9, alpha: 1)

        // MARK: - игровой счет

        // Узнаем координаты центра вью для дальнейшего использования
        let centerX = view.center.x
        let centerY = view.center.y

        // установка лейбла побед на вью
        labelWinCount.text = "Всего побед: "
        labelWinCount.frame = CGRect(x: centerX - 180, y: centerY - 300, width: 200, height: 100) // левый край лейбла Побед относительно центра вью
        view.addSubview(labelWinCount)
        // установка лейбла поражений на вью
        labelLoseCount.text = "Всего поражений: "
        labelLoseCount.frame = CGRect(x: centerX - 180, y: centerY - 250, width: 250, height: 100) // левый край лейбла Поражений относительно центра вью
        view.addSubview(labelLoseCount)
        
        // MARK: - свич кота
        // устанавливаем переключатель кота
        catSwitch.center = CGPoint(x: centerX + 150, y: centerY - 300) // расположение свича относительно центра вью
        view.addSubview(catSwitch)
        catSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged) //вк выкл отображение кота
        

        // MARK: - кот

        // устанавливаем кота
        imageCat.frame.size.width = 200 // ширина кота
        imageCat.frame.size.height = 220 // высота кота

        imageCat.center = CGPoint(x: centerX - 10, y: centerY - 70) // расположение центра кота относительно центра вью

        // Устанавливаем изображение
        imageCat.image = UIImage(named: "cat.png")

        // Добавляем кота на экран
        view.addSubview(imageCat)
        imageCat.isHidden = false // кот скрыт или виден

        // MARK: - текст под котом

        // устанавливаем текст под котом
        labelTextUnderCat.numberOfLines = 2 // количество строк в тексте
        labelTextUnderCat.font = UIFont.systemFont(ofSize: 35) // Размер шрифта под котом
        labelTextUnderCat.text = "Угадай какое число \n от 1 до 3 загадал кот"
        labelTextUnderCat.frame = CGRect(x: centerX - 180, y: centerY, width: 500, height: 200) // левый край текста под котом относительно центра вью
        view.addSubview(labelTextUnderCat)

        // MARK: - кнопки

        // установка трёх кнопок в ряд
        button1.center = CGPoint(x: centerX - 100, y: centerY + 220) // центр кнопки 1 относительно центра вью
        button1.setTitle("1", for: .normal) // Текст на кнопке 1
        button1.tag = 1 // Присваиваем кнопке 1 соответстсвующий тег
        // Добавляем цель (target) и селектор (selector) для кнопки
        button1.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        view.addSubview(button1)

        button2.center = CGPoint(x: centerX, y: centerY + 220) // центр кнопки 2 относительно центра вью
        button2.setTitle("2", for: .normal) // Текст на кнопке 2
        button2.tag = 2 // Присваиваем кнопке 2 соответстсвующий тег
        // Добавляем цель (target) и селектор (selector) для кнопки
        button2.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        view.addSubview(button2)

        button3.center = CGPoint(x: centerX + 100, y: centerY + 220) // центр кнопки 3 относительно центра вью
        button3.setTitle("3", for: .normal) // Текст на кнопке 3
        button3.tag = 3 // Присваиваем кнопке 3 соответстсвующий тег
        // Добавляем цель (target) и селектор (selector) для кнопки
        button3.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        view.addSubview(button3)

        // установка кнопки сброса
        buttonResetScore.frame.size.width = 200 // Кнопка сброса шире стандартных
        buttonResetScore.frame.size.height = 40 // Кнопка сброса меньше стандартных
        buttonResetScore.titleLabel?.font = UIFont.systemFont(ofSize: 22) // Шрифт на кнопке сброса меньше
        buttonResetScore.center = CGPoint(x: centerX, y: centerY + 330) // центр кнопки сброса относительно центра вью
        buttonResetScore.setTitle("Сбросить счет", for: .normal) // Текст на кнопке сброса
        // Добавляем цель (target) и селектор (selector) для кнопки
        buttonResetScore.addTarget(self, action: #selector(resetButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(buttonResetScore)
    }

    // MARK: - actions

    // метод при нажатии на одну из трех кнопок
    @objc func buttonTapped(_ sender: UIButton) {
        let buttonNumber = sender.tag // присваиваем переменной тэг с нажатой кнопки (1, 2 или 3)
        catsNumber = Int.random(in: 1 ... 3) // кот загадал рандомное число от 1 до 3

        if buttonNumber == catsNumber { // если вы угадали число
            winCount += 1 // счетчик побед растет
            
            // Создание всплывающего окна ПОБЕДА
            let alertController = UIAlertController(title: "Вы угадали!", message: "+1 победа на счет!", preferredStyle: .alert)
            // Добавляем кнопку "ОК" и связываем ее с закрытием алерта
            let okAction = UIAlertAction(title: "ОК", style: .default) { _ in
                self.labelWinCount.text = "Всего побед: " + String(self.winCount) // добавляем к счетчику побед текущее число побед
            }
            alertController.addAction(okAction)
            // Показ всплывающего окна ПОБЕДА
            present(alertController, animated: true, completion: nil)
            

        } else { // если число не угадали
            loseCount += 1 // счетчик поражений растет
            
            // Создание всплывающего окна ПОРАЖЕНИЕ
            let alertController = UIAlertController(title: "Вы не угадали :(", message: "+1 поражение на счет!", preferredStyle: .alert)
            // Добавляем кнопку "ОК" и связываем ее с закрытием алерта
            let okAction = UIAlertAction(title: "ОК", style: .default) { _ in
                self.labelLoseCount.text = "Всего поражений: " + String(self.loseCount) // добавляем к счетчику поражений текущее число поражений
            }
            alertController.addAction(okAction)
            // Показ всплывающего окна ПОРАЖЕНИЕ
            present(alertController, animated: true, completion: nil)
        }
    }

    // метод при сброса очков игры
    @objc func resetButtonTapped(_ sender: UIButton) {
        winCount = 0 // обнуляем счетчик побед
        loseCount = 0 // обнуляем счетчик поражений
        // приводим лейблы счетчиков в исходное положение
        labelWinCount.text = "Всего побед: "
        labelLoseCount.text = "Всего поражений: "
    }
    
    // свич включения и выключения отображения кота на вью
    @objc func switchValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            imageCat.isHidden = true // если переключатель включен - кот исчезает
        } else {
            imageCat.isHidden = false // если переключатель выключен - кот отображается
        }
    }
}
