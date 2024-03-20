//
//  Day2-Task6.swift
//  Multithreading
//
//  Created by Dmitry on 20.03.2024.
//

import UIKit

class Day2_Task6: UIViewController {

    private lazy var name = "I love RM"
    
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            updateName()
        }
        
        func updateName() {
            var lock = NSLock()
            DispatchQueue.global().async {
                lock.lock()
                print(self.name) // Считываем имя из global
                lock.unlock()
                print(Thread.current)
            }
            lock.lock()
            print(self.name) // Считываем имя из main
            lock.unlock()
        }

}
// Идет обращение к lazy var из разных поток и она инициализируется по несколько раз
