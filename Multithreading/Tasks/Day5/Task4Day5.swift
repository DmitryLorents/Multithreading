//
//  Task4Day5.swift
//  Multithreading
//
//  Created by Dmitry on 23.03.2024.
//

import UIKit

class Task4Day5: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        func randomD6() async -> Int  {
            Int.random(in: 1...6)
        }
        Task {
            let result = await randomD6()
            print(result)
        }
    }
}
