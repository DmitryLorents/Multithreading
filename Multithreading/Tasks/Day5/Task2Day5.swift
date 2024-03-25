//
//  Task2Day5.swift
//  Multithreading
//
//  Created by Dmitry on 22.03.2024.
//

import UIKit

class Task2Day5: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        print(1)
                Task { @MainActor  in
                    print(2)
                }
                print(3)
       
    }

}
// Относительно прошлого задания теперь 2 стало печататься на main потоке
