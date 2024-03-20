//
//  Day1-Task1.swift
//  Multithreading
//
//  Created by Dmitry on 18.03.2024.
//

import UIKit

class Day1_Task1: UIViewController {

    override func viewDidLoad() {
            super.viewDidLoad()
        Thread.detachNewThread {
            for _ in (0..<10) {
                let currentThread = Thread.current
                print("1, Current thread: \(currentThread)")
             }
        }
     

      for _ in (0..<10) {
         let currentThread = Thread.current
         print("2, Current thread: \(currentThread)")
      }
    }

    /// Только первый цикл перевести в другой поток с помощью Thread.detachNewThread и обяснить почему изменился вывод.
    /// Ответ: первый цикл ушел на другой поток, который создан в методе Thread.detachNewThread {}

}
