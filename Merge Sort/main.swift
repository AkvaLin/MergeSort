//
//  main.swift
//  Merge Sort
//
//  Created by Никита Пивоваров on 11.09.2022.
//

import Foundation

let qu = Queue<Int>()

qu.fillRandom()
qu.elements.printAll()
qu.sort()
print("---------------")
qu.elements.printAll()
print(qu.elements.count)
