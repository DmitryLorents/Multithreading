//
//  Day2-Task4.swift
//  Multithreading
//
//  Created by Dmitry on 20.03.2024.
//

import UIKit

class Day2_Task4: UIViewController {

    override func viewDidLoad() {
            super.viewDidLoad()

            print("A")
            
            DispatchQueue.main.async {
                print("B")
            }
        
            print("C")
    }
}
// Скорее всего A C B  Вызывается на последовательной main очереди и выполняется по порядку. В закидывается на асинхронное выполнение и обычно пока оно туда перекинется, уже успевает С напечататься
