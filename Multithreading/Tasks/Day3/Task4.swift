//
//  Task4.swift
//  Multithreading
//
//  Created by Dmitry on 21.03.2024.
//

import UIKit

class Task4: UIViewController {

    override func viewDidLoad() {
            super.viewDidLoad()
        view.backgroundColor = .yellow
            let lock = NSLock()
            var sharedResource = 0

            DispatchQueue.global(qos: .background).async {
                for _ in 1...100 {
                    lock.lock()
                    sharedResource += 1
                    lock.unlock()
                }
            }

            DispatchQueue.global(qos: .background).async {
                for _ in 1...100 {
                    lock.lock()
                    sharedResource += 1
                    lock.unlock()
                }
            }
        
        sleep(5)
        print(sharedResource)
     }

}
// Здесь возникает data race. Для решения можно использовать lock
