//
//  Task-1.swift
//  Multithreading
//
//  Created by Dmitry on 21.03.2024.
//

import UIKit

class Task1V1: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        let semaphore = DispatchSemaphore(value: 1)
        let phrasesService = PhrasesService()
        DispatchQueue.global().async {
            for i in 0..<10 {
                semaphore.wait()
                phrasesService.addPhrase("Phrase \(i)")
                semaphore.signal()
            }
        }
        
        // Даем потокам время на завершение работы
        Thread.sleep(forTimeInterval: 1)
        
        // Выводим результат
        semaphore.wait()
        print(phrasesService.phrases)
        semaphore.signal()
    }
    
    class PhrasesService {
        var phrases: [String] = []
        
        func addPhrase(_ phrase: String) {
            phrases.append(phrase)
        }
    }
    
}
