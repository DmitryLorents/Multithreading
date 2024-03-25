//
//  Task1Day4.swift
//  Multithreading
//
//  Created by Dmitry on 22.03.2024.
//

import UIKit

class Task1Day4: UIViewController {

   final class Post: Sendable {
            
    }

    enum State1: Sendable {
         case loading
         case data(String)
    }
        
    enum State2: Sendable {
         case loading
         case data(Post) // Out: Associated value 'data' of 'Sendable'-conforming enum 'State2' has non-sendable type 'ViewController.Post'
    }

    }
// Второй enum содержит в себе ссылку на класс Post, который не является Sendable, поэтому предупреждение
