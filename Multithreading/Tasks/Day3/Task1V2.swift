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
        var phrasesService = PhrasesService()
            Task {
                print("Start")
               for i in 0..<10 {
                    await phrasesService.addPhrase("Phrase \(i)")
                }
            }
        
        // Выводим результат
        Task {
            // Даем потокам время на завершение работы
            try await Task.sleep(nanoseconds: 1_000_000_000)
            print(await phrasesService.phrases)
        }
    }
    
    actor PhrasesService {
        var phrases: [String] = []
        
        func addPhrase(_ phrase: String) async {
            phrases.append(phrase)
        }
    }
}
