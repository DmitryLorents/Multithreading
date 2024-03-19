//
//  Day2-Task1.swift
//  Multithreading
//
//  Created by Dmitry on 19.03.2024.
//

import UIKit

class Day2_Task1: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Создаем и запускаем поток
        let infinityThread = InfinityLoop()
        infinityThread.start()
        print("Is executing: ", infinityThread.isExecuting)
        
        // Подождем некоторое время, а затем отменяем выполнение потока
        sleep(2)
        // Отменяем тут
        while !infinityThread.isFinished {
            if infinityThread.counter > 4 {
                infinityThread.cancel()
            } else {
                sleep(1)
            }
        }
        print("Is finished: ", infinityThread.isFinished)
    }
}
    class InfinityLoop: Thread {
        var counter = 0
        
        override func main() {
            while counter < 30 && !isCancelled {
                counter += 1
                print(counter)
                InfinityLoop.sleep(forTimeInterval: 1)
            }
        }
    }
