//
//  Task1V2.swift
//  Multithreading
//
//  Created by Dmitry on 21.03.2024.
//

import UIKit

class Task1V2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        let phrasesService = PhrasesService()
        DispatchQueue.global().async {
            for i in 0..<10 {
                phrasesService.addPhrase("Phrase \(i)")
            }
        }
        // Выводим результат
    }
    
    actor PhrasesService {
        var phrases: [String] = []
        
        func addPhrase(_ phrase: String)  {
            phrases.append(phrase)
        }
    }
}
