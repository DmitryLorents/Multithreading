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
        let serialQueue = DispatchQueue(label: "serial")
        let fetchDataItem = DispatchWorkItem(flags: .barrier, block: {
            self.fetchData()
        })
        
        serialQueue.async(group: group) {
           group.enter()
            fetchDataItem.perform()
            group.leave()
            
        }
        
//        //1) fetchData
//        group.enter()
//        fetchData()
//        group.leave()
//        group.wait()
//        // 2) decodeData
//        group.enter()
//        
//        group.leave()
//        
//        // 3) modifyData
//        group.enter()
//        
//        group.leave()
        
        // После того как данные были получены, декодированы и обработаны вызвать метод showData()
        group.notify(queue: .main, execute: {
            self.showData()
        })
    }
    
    func fetchData() {
        DispatchQueue.global().async {
            sleep (10)
            print ("data did obtain")
        }
    }
    
    func decodeData() {
        DispatchQueue.global().async {
            sleep (2)
            print ("data did decode")
        }
    }
    
    func modifyData() {
        DispatchQueue.global().async {
            sleep (1)
            print ("data did modify")
        }
    }
    
    func showData() {
        print("data did show on the screen")
    }
}
