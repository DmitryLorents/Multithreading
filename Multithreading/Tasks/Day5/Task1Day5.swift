//
//  Task1Day5.swift
//  Multithreading
//
//  Created by Dmitry on 22.03.2024.
//

import UIKit

class Task1Day5: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        print(1)
        Task {
            print(2)
        }
        print(3)
    }
    
}

// Изначально печать 2 вызывается раньше, чем печать 3, но пока она перекидывается на main асинхронно - успевает вызваться печать 3 и исполниться
// При замене ничего не изменилось в печати, но печать 2 стала вызываться с другой очереди
