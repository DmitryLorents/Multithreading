//
//  Task2Day4.swift
//  Multithreading
//
//  Created by Dmitry on 22.03.2024.
//

import UIKit

protocol RMOperationProtocol {
    // Приоритеты
    var priority: DispatchQoS.QoSClass { get }
    // Выполняемый блок
    var completionBlock: (() -> Void)? { get }
    // Завершена ли операция
    var isFinished: Bool { get }
    // Начата ли операция
    var isExecuting: Bool { get }
    // Метод для запуска операции
    func start()
}

class RMOperation: RMOperationProtocol {
    
    var priority: DispatchQoS.QoSClass
    
    var completionBlock: (() -> Void)?
    
    var isFinished: Bool = false
    var isExecuting: Bool = false
    
    init(priority: DispatchQoS.QoSClass = .unspecified, completionBlock: ( () -> Void)? = nil) {
        self.priority = priority
        self.completionBlock = completionBlock
    }
    
    func start() {
        let globalQueue = DispatchQueue.global(qos: priority)
        let group = DispatchGroup()
        globalQueue.async(group: group) {
            self.isExecuting = true
            self.completionBlock?()
        }
        group.wait()
        group.notify(queue: globalQueue) {
            self.isFinished = true
        }
    }
    /// В методе start. реализуйте все через глобальную паралельную очередь с приоритетами.
}

class Task2Day4: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        
        let operationFirst = RMOperation()
//        let operationFirst = BlockOperation()
        let operationSecond = RMOperation()
        
        operationFirst.priority = .userInitiated
        operationFirst.completionBlock = {
            
            for _ in 0..<50 {
                print(2)
            }
            print(Thread.current)
            print("Операция полностью завершена!")
        }
        
        operationFirst.start()
        
        operationSecond.priority = .background
        operationSecond.completionBlock = {
            
            for _ in 0..<50 {
                print(1)
            }
            print(Thread.current)
            print("Операция полностью завершена!")
        }
        operationSecond.start()
        
    }
}
