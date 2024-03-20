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
        let lock = NSLock()
        var threadConter: Int
        infinityThread.start()
        print("Is executing: ", infinityThread.isExecuting)
        
        // Подождем некоторое время, а затем отменяем выполнение потока
        sleep(2)
        // Отменяем тут
        while !infinityThread.isFinished {
            lock.lock()
            threadConter = infinityThread.counter
            lock.unlock()
            if threadConter > 4 {
                infinityThread.cancel()
            } else {
                sleep(UInt32(infinityThread.timeInterval))
            }
        }
        print("Is finished: ", infinityThread.isFinished)
    }
}
    class InfinityLoop: Thread {
        let lock = NSLock()
        var counter = 0
        let maxCountValue = 5
        let timeInterval = 1.0
        
        
        override func main() {
            while counter < 30 && !isCancelled {
                lock.lock()
                counter += 1
                print(counter)
                lock.unlock()
                InfinityLoop.sleep(forTimeInterval: timeInterval)
            }
        }
    }
