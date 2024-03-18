//
//  ThreadViewController.swift
//  Multithreading
//
//  Created by Dmitry on 18.03.2024.
//

import UIKit

class ThreadViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        Thread.detachNewThread {
        //            for _ in 0..<10 {
        //                print("😈")
        //            }
        //        }
        
//        Thread.detachNewThreadSelector(#selector(self.printDemon), toTarget: self, with: nil)
        let thread = Thread {
            for _ in 0..<10 {
                print("😈")
            }
        }
//        thread.start()
        
        let thread2 = ThreadPrinter()
        
        thread2.start()
        print(thread2.threadPriority)
        
        for _ in 0..<10 {
            print("🤠")
        }
        Thread.setThreadPriority(1)
        Thread.main.cancel()
        print("Main is canceled", Thread.main.threadPriority)
        
        
    }
        
        @objc func printDemon() {
            for _ in 0..<10 {
                print("😈")
            }
        }
    
    }
    
class ThreadPrinter: Thread {
    override func main() {
        for _ in 0..<10 {
            print("😈")
        }
    }
}
