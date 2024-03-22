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
        let threadSafeArray = ThreadSafeArray2()
        let operationQueue = OperationQueue()
        
        let firstOperation = FirstOperation2(threadSafeArray: threadSafeArray)
        let secondOperation = SecondOperation2(threadSafeArray: threadSafeArray)
        
        operationQueue.addOperation(firstOperation)
        operationQueue.addOperation(secondOperation)
        
        // Дождитесь завершения операций перед выводом содержимого массива
        operationQueue.waitUntilAllOperationsAreFinished()
        print(threadSafeArray.getAll())
        
        
    }
    
}

// Объявляем класс для для синхронизации потоков

class ThreadSafeArray2 {
    private var array: [String] = []
    private let lock = NSLock()
    
    func append(_ item: String) {
        lock.lock()
        array.append(item)
        lock.unlock()
    }
    
    func getAll() -> [String] {
        return array
    }
}

// Определяем первую операцию для добавления строки в массив
class FirstOperation2: Operation {
    let threadSafeArray: ThreadSafeArray2
    
    init(threadSafeArray: ThreadSafeArray2) {
        self.threadSafeArray = threadSafeArray
    }
    
    override func main() {
        if isCancelled { return }
        
        threadSafeArray.append("Первая операция")
        
        
    }
}

// Определяем вторую операцию для добавления строки в массив

class SecondOperation2: Operation {
    // Создаем по образу первой операции
    let threadSafeArray: ThreadSafeArray2
    
    init(threadSafeArray: ThreadSafeArray2) {
        self.threadSafeArray = threadSafeArray
    }
    
    override func main() {
        if isCancelled { return }
        threadSafeArray.append("Вторая операция")
    }
}
