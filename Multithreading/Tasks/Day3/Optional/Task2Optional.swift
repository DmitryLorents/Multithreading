//
//  Task2Optional.swift
//  Multithreading
//
//  Created by Dmitry on 24.03.2024.
//

import UIKit

class Task2Optional: UIViewController {
    
    lazy var someDate: Date = {
        print(" \n initialization happens only once!")
        startNumber += 1
        return Date()
    }()
    
    var startNumber: Int = 0 {
        willSet (newNumber) { print("После иницициализации начнем работать с этим значением: \(newNumber)")
            // какая-то логика
        }
        didSet {
            print("Предыдущее значение: \(oldValue)")
            // какая-то логика
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("start")
        view.backgroundColor = .cyan
        let semaphore = DispatchSemaphore(value: 1)
        let lock = NSLock()
        DispatchQueue.global().async {
            // Имитация какой-то работы
            sleep (1)
            lock.lock()
            let _ = self.someDate
            lock.unlock()
        }
        DispatchQueue.global().async {
            // Имитация какой-то работы
            sleep (1)
            lock.lock()
            let _ = self.someDate
            lock.unlock()
        }
        DispatchQueue.global().async {
            sleep (1)
            // Имитация какой-то работы
            lock.lock()
            let _ = self.someDate
            lock.unlock()
        }
    }
}
// Проблема в одновременнгом обращении к lazy переменной. Устранил с помощью NSLock
