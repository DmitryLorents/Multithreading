//
//  Task4v2.swift
//  Multithreading
//
//  Created by Dmitry on 22.03.2024.
//

import UIKit

class Task4v2Day4: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
           
            // Использование
            let threadSafeArray = ThreadSafeArray()
            let operationQueue = OperationQueue()

            let firstOperation = FirstOperation(threadSafeArray: threadSafeArray)
            let secondOperation = SecondOperation(threadSafeArray: threadSafeArray)

            operationQueue.addOperation(firstOperation)
            operationQueue.addOperation(secondOperation)

            // Дождитесь завершения операций перед выводом содержимого массива
            operationQueue.waitUntilAllOperationsAreFinished()
        Task {
            print(await threadSafeArray.getAll())
        }

            
        }

}

    // Объявляем класс для для синхронизации потоков

    actor ThreadSafeArray {
        private var array: [String] = []

        func append(_ item: String) {
            array.append(item)
        }

        func getAll() -> [String] {
            return array
        }
    }

    // Определяем первую операцию для добавления строки в массив
    class FirstOperation: Operation {
        let threadSafeArray: ThreadSafeArray

        init(threadSafeArray: ThreadSafeArray) {
            self.threadSafeArray = threadSafeArray
        }

        override func main() {
            if isCancelled { return }
            Task {
               await threadSafeArray.append("Первая операция")
            }
            
        }
    }

    // Определяем вторую операцию для добавления строки в массив

    class SecondOperation: Operation {
        // Создаем по образу первой операции
        let threadSafeArray: ThreadSafeArray

        init(threadSafeArray: ThreadSafeArray) {
            self.threadSafeArray = threadSafeArray
        }

        override func main() {
            if isCancelled { return }
            Task {
               await threadSafeArray.append("Вторая операция")
            }
        }
    }
