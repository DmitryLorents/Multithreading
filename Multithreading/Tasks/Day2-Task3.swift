//
//  Day2-Task3.swift
//  Multithreading
//
//  Created by Dmitry on 20.03.2024.
//

import UIKit

class Day2_Task3: UIViewController {

    private var name = "Введите имя"
    private let lockQueue = DispatchQueue(label: "name.lock.queue")
        
        override func viewDidLoad() {
            super.viewDidLoad()
            updateName()
        }
        
        func updateName() {
            DispatchQueue.global().async {
                self.lockQueue.async {
                        self.name = "I love RM" // Перезаписываем имя в другом потоке
                }

                print(Thread.current)
                    print(self.name)
            }
            print(self.name, "main") // Считываем имя из main
        }

}
// 1. Почему вывелся такой порядок в консоли? - Имя успевает измениться на глобальной очереди и потом печатается еще и на main очереди уже с изменениями. У main выше приоритет, поэтому печатается сначала на ней.

// 2. Теперь заменить async на sync и объяснить изменения: - Печать thread.current происходит сначала, т.к. задания на очереди теперь выполняются синхронно и очередь блокируется, пока не напечатается thread.current. Ну и потом происходит печать на main так весь запуск происходит на main потоке и сначала перекидывается на глобальную очередь и потом вызывается печать на main. А глобальная очередь теперь не завершается пока не выполнит все таски

// 3. Решить проблему с помощью private let lockQueue = DispatchQueue(label: "name.lock.queue"). Добавил замок
