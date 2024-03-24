//
//  Task1Optional.swift
//  Multithreading
//
//  Created by Dmitry on 24.03.2024.
//

import UIKit

class Task1Optional: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        print ("R")
        let lock = NSLock()
        DispatchQueue.global().async {
            lock.lock()
            print("A")
            lock.unlock()
            lock.lock()
            print ("D")
            lock.unlock()
            DispatchQueue.main.async {
                print("Map")
            }
        }
        print ("0")
    }
}

// R
