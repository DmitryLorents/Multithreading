//
//  Task4Optional.swift
//  Multithreading
//
//  Created by Dmitry on 24.03.2024.
//

import UIKit

class Task4Optional: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("start")
        view.backgroundColor = .cyan
        let highPriority = DispatchQueue.global(qos: .userInitiated)
        let lowPriority = DispatchQueue.global(qos: .utility)
        let semaphore = DispatchSemaphore (value: 2)
        lowPriority.async {
            print ("Ждем выполнения низкоприоретной задачи")
            semaphore.wait()
            print("Низкоприоретная задача начала выполнение")
            Thread.sleep(forTimeInterval: 10) // Эмуляция затратной операции
            semaphore.signal()
            print("Низкоприоретная задача выполнена")
        }
        sleep (1)
        
        highPriority.async {
            print ("Ждем выполнения высокоприоретентной задачи")
            semaphore.wait()
            semaphore.signal()
            print ("Высокоприоретентная задача выполнена")
        }
    }
}
// Здесь случается priority inversion
// Для исключения можно увеличить счетчик семафора до 2
