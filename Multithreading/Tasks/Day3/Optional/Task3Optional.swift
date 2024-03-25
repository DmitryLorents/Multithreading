//
//  Task3Optional.swift
//  Multithreading
//
//  Created by Dmitry on 24.03.2024.
//

// Найти проблему и решить. Последним выведенным значением должна быть цифра 75
import UIKit

class HeavilyComputation {
    
    private var rezult = 0
    func doSomethimg(value: Int) -> Int {
            self.rezult += value
        return rezult
    }
}

class Task3Optional: UIViewController {
    private lazy var heavyComputationObject = HeavilyComputation()
    private var rezult: Int = 0 {
        didSet {
            print("Set value \(rezult)")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        print("start")
        start()
        print("finish")
    }
    
    func start() {
       let semaphore = DispatchSemaphore(value: 1)
        let group = DispatchGroup()
        DispatchQueue.global(qos: .background).async(group: group) {
            semaphore.wait()
            let value = self.heavyComputationObject.doSomethimg (value: 10)
            self.rezult += value
            semaphore.signal()
            sleep (1)
            print (value)
        }
        DispatchQueue.global(qos: .background).async(group: group) {
            semaphore.wait()
            let value = self.heavyComputationObject.doSomethimg (value: 11)
            self.rezult += value
            semaphore.signal()
            sleep (2)
            print (value)
        }
        DispatchQueue.global(qos: .background).async(group: group) {
            semaphore.wait()
            let value = self.heavyComputationObject.doSomethimg (value: 12)
            self.rezult += value
            semaphore.signal()
            print (value)
        }
        DispatchQueue.global(qos: .background).async(group: group) {
            semaphore.wait()
            let value = self.heavyComputationObject.doSomethimg (value: 13)
            self.rezult += value
            semaphore.signal()
            print (value)
        }
        DispatchQueue.global(qos: .background).async(group: group) {
            semaphore.wait()
            let value = self.heavyComputationObject.doSomethimg (value: 14)
            self.rezult += value
            semaphore.signal()
            sleep (3)
            print (value)
        }
        DispatchQueue.global(qos: .background).async(group: group) {
            semaphore.wait()
            let value = self.heavyComputationObject.doSomethimg (value: 15)
            self.rezult += value
            semaphore.signal()
            print (value)
        }
        group.wait()
        group.notify(queue: .main, execute: {
            print(self.rezult)
        })
    }
    }
