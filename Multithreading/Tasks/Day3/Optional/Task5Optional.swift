//
//  Task5Optional.swift
//  Multithreading
//
//  Created by Dmitry on 24.03.2024.
//

import UIKit

class Task5Optional: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        let resourceASemaphore = DispatchSemaphore (value: 1)
        let resourceBSemaphore = DispatchSemaphore(value: 1)
        
        let queue = DispatchQueue(label: "con", qos: .userInitiated, attributes: . concurrent)
        
        let firstWorkItem = DispatchWorkItem(qos: .userInteractive) {
            print("Поток 1 пытается захватить Ресурс А")
            resourceASemaphore.wait() // Захват Ресурса А
            
            print("Поток 1 захватил Ресурс А и пытается захватить Ресурс В")
            sleep(2)
            // для демонстрации livelock
            
            resourceBSemaphore.wait() // Попытка захвата Ресурса В, который уже занят Потоком 2
            print ("Поток 1 захватил Ресурс В")
            resourceBSemaphore.signal()
            resourceASemaphore.signal()
        }
        
        let secondWorItem = DispatchWorkItem(qos: .background) {
            
            print ("Поток 2 пытается захватить Ресурс В")
            resourceBSemaphore.wait() // Захват Ресурса В
            
            print ("Поток 2 захватил Ресурс В и пытается захватить Ресурс А")
            sleep(2) // Имитация работы для демонстрации livelock
            
            resourceASemaphore.wait() // Попытка захвата Ресурса А, который уже занят Потоком 1
            print("Поток 2 захватил Ресурс А")
            
            resourceASemaphore.signal()
            resourceBSemaphore.signal()
            
        }
        
        queue.async(execute: firstWorkItem)
        queue.async(execute: secondWorItem)
        
        checkResource (first: firstWorkItem, second: secondWorItem)
        // Вызвать метод taskCompleted, после успешного завершения
        taskCompleted()
    }
    
    func checkResource(first: DispatchWorkItem, second: DispatchWorkItem) {
        DispatchQueue.main.asyncAfter(deadline: . now() + 5) {
            // проверить что работа все еще выполняется
            if !first.isCancelled && !second.isCancelled {
                // и если выполняется отменить ее
                second.cancel()
            }
            //если работа была отменена, вывести сообщение
            if second.isCancelled {
                print("Second operation was canceled")
            }
            
        }
    }
    
    func taskCompleted () {
        print ("Task completed successfully.")
    }
    
}

