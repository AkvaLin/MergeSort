//
//  Queue.swift
//  Merge Sort
//
//  Created by Никита Пивоваров on 13.11.2022.
//

import Foundation

class Queue<T: Comparable> {
    
    var elements = LinkedList<T>()
    
    func fillRandom() {
        for _ in 0..<1000 {
            elements.enqueue(value: Int.random(in: 0...1000) as! T)
        }
    }
    
    private func distribution<T: Comparable>(list: LinkedList<T>?) -> [LinkedList<T>?]? {
        guard let list = list, list.head != nil else {
            return nil
        }
        
        let firstList = LinkedList<T>()
        let secondList = LinkedList<T>()
        var isFirst = true
        
        var temp = list.dequeue()
        firstList.enqueue(value: temp!.value)
        
        while true {
            if list.head != nil {
                if temp!.value <= list.head!.value && isFirst {
                    temp = list.dequeue()!
                    firstList.enqueue(value: temp!.value)
                } else if temp!.value <= list.head!.value && !isFirst {
                    temp = list.dequeue()!
                    secondList.enqueue(value: temp!.value)
                } else if temp!.value > list.head!.value && isFirst {
                    temp = list.dequeue()!
                    secondList.enqueue(value: temp!.value)
                    isFirst.toggle()
                } else if temp!.value > list.head!.value && !isFirst {
                    temp = list.dequeue()!
                    firstList.enqueue(value: temp!.value)
                    isFirst.toggle()
                }
            } else {
                break
            }
        }

        return [firstList, secondList]
    }
    
    private func merge<T: Comparable>(a: LinkedList<T>?, b: LinkedList<T>?) -> LinkedList<T> {
        
        if a == nil && b == nil {
            return LinkedList<T>()
        }
        
        guard let a = a else {
            return b!
        }
        
        guard let b = b else {
            return a
        }
        
        let list = LinkedList<T>()
        
        var atmp = a.dequeue()
        var btmp = b.dequeue()
        
        while atmp != nil, btmp != nil {
            if atmp!.value <= btmp!.value {
                list.enqueue(value: atmp!.value)
                if a.head != nil, atmp!.value > a.head!.value {
                    list.enqueue(value: btmp!.value)
                    while b.head != nil, btmp!.value <= b.head!.value {
                        btmp = b.dequeue()
                        list.enqueue(value: btmp!.value)
                    }
                    btmp = b.dequeue()
                }
                atmp = a.dequeue()
            } else {
                list.enqueue(value: btmp!.value)
                if b.head != nil, btmp!.value > b.head!.value {
                    list.enqueue(value: atmp!.value)
                    while a.head != nil, atmp!.value <= a.head!.value {
                        atmp = a.dequeue()
                        list.enqueue(value: atmp!.value)
                    }
                    atmp = a.dequeue()
                }
                btmp = b.dequeue()
            }
        }
        
        if atmp != nil {
            list.enqueue(value: atmp!.value)
        } else if btmp != nil {
            list.enqueue(value: btmp!.value)
        }
        
        if a.head != nil {
            while a.head != nil {
                list.enqueue(value: a.dequeue()!.value)
            }
        } else if b.head != nil {
            while b.head != nil {
                list.enqueue(value: b.dequeue()!.value)
            }
        }
        return list
    }
    
    func sort() {
        
        var result = elements
        
        while true {
            let temp = distribution(list: result)
            
            guard temp?[1]?.head != nil else {
                elements = temp![0]!
                break
            }
            
            result = merge(a: temp![0], b: temp![1])
        }
    }
}
