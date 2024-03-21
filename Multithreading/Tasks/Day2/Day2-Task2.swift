//
//  Day2-Task2.swift
//  Multithreading
//
//  Created by Dmitry on 19.03.2024.
//

import UIKit

class Day2_Task2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Создаем и запускаем поток
        let thread1 = ThreadprintDemon()
        let thread2 = ThreadprintAngel()
        
        // Меняем приоритеты
//        // 1. Выставить приоритеты, чтобы сначала печаталось 1, потом 2
//        thread1.qualityOfService = .userInteractive
//        thread2.qualityOfService = .background
        
//        // 2. Выставить приоритеты, чтобы сначала печаталось 2, потом 1
//        thread1.qualityOfService = .background
//        thread2.qualityOfService = .userInteractive
//
        // 3. Выставить приоритеты, чтобы печаталось вперемешку
        
        thread1.start()
        thread2.start()
        
    }
}
class ThreadprintDemon: Thread {
    override func main() {
        for _ in (0..<100) {
            print("1")
        }
    }
}
class ThreadprintAngel: Thread {
    override func main() {
        for _ in (0..<100) {
            print("2")
        }
    }
}
