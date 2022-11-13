//
//  LinkedList.swift
//  Merge Sort
//
//  Created by Никита Пивоваров on 13.11.2022.
//

import Foundation

class LinkedListNode<T: Comparable> {
    
    var value: T
    var next: LinkedListNode?
    
    init(value: T) {
        self.value = value
    }
}
class LinkedList<T: Comparable> {
    
    var head: LinkedListNode<T>?
    var count: Int = 0
    
    func dequeue () -> LinkedListNode<T>? {
        if let node = head {
            head = head?.next
            count -= 1
            node.next = nil
            return node
        }
        return nil
    }
    
    func enqueue(value: T) {
        let newNode = LinkedListNode(value:value)
        
        if count == 0 {
            head = newNode
        } else {
            var currentNode = head
            while currentNode?.next != nil {
                currentNode = currentNode?.next
            }
            currentNode?.next = newNode
        }
        
        count += 1
    }
    
    
    func printAll() {
        if count == 0 {
            print("List is empty")
        } else {
            var currentNode = head
            for _ in 1...count {
                print(currentNode?.value ?? "Value error")
                currentNode = currentNode?.next
            }
        }
    }
}
