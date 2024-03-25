//
//  Task6Optional.swift
//  Multithreading
//
//  Created by Dmitry on 24.03.2024.
//

import UIKit

class Task6Optional: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        // используя DispathGroup вызвать методы в следующем порядке
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            //1) fetchData
            group.enter()
            self.fetchData {
                group.leave()
            }
            
        }
        group.wait()
        // 2) decodeData
        group.enter()
        self.decodeData {
            group.leave()
        }
        group.wait()
               
        // 3) modifyData
        group.enter()
        self.modifyData {
            group.leave()
        }
        
        // После того как данные были получены, декодированы и обработаны вызвать метод showData()
        group.wait()
        group.notify(queue: .main, execute: {
            self.showData()
        })
    }
    
    func fetchData(_ handler: @escaping () -> ()) {
        DispatchQueue.global().async {
            sleep (10)
            print ("data did obtain")
            handler()
        }
    }
    
    func decodeData(_ handler: @escaping () -> ()) {
        DispatchQueue.global().async {
            sleep (2)
            print ("data did decode")
            handler()
        }
    }
    
    func modifyData(_ handler: @escaping () -> ()) {
        DispatchQueue.global().async {
            sleep (1)
            print ("data did modify")
            handler()
        }
    }
    
    func showData() {
        print("data did show on the screen")
    }
}
