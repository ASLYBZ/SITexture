//
//  LTString.swift
//  SITexture
//
//  Created by 王卫亮 on 2022/12/13.
//

import Foundation

class LTString {
    
    /* 1832. 判断句子是否为全字母句
     全字母句 指包含英语字母表中每个字母至少一次的句子。
     给你一个仅由小写英文字母组成的字符串 sentence ，请你判断 sentence 是否为 全字母句 。
     如果是，返回 true ；否则，返回 false 。
     */
    
    // 0 ms
    func checkIfPangram1(_ sentence: String) -> Bool {
        
        var characters:[Character] = []
        
        for c in sentence {
            if !characters.contains(c) {
                characters.append(c)
            }
        }
        
        return characters.count == 26
    }
    
    /// 最优解 0 ms
    func checkIfPangram(_ sentence: String) -> Bool {
        return Set(Array(sentence)).count == 26
    }
    
    
    /*
     给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出 和为目标值 target  的那 两个 整数，并返回它们的数组下标。
     你可以假设每种输入只会对应一个答案。但是，数组中同一个元素在答案里不能重复出现。
     你可以按任意顺序返回答案。
     2 <= nums.length <= 104
     -109 <= nums[i] <= 109
     -109 <= target <= 109
     */
    
    // 68 ms
    func twoSum1(_ nums: [Int], _ target: Int) -> [Int] {
        if nums.count < 2 || nums.count > 104 {
            return []
        }
        
        var results: [Int] = []
        for i in 0..<nums.count {
            let num = nums[i]
            for j in 0..<nums.count-i-1 {
                if target == num + nums[j+i+1] {
                    results.append(i)
                    results.append(j+i+1)
                    return results
                }
            }
        }
        
        return results
    }
    
    // 最优解 28 ms
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dict: [Int: Int] = .init(minimumCapacity: nums.count)
        
        for (offset, element) in nums.enumerated() {
            if let index = dict[target - element] {
                return [offset, index]
            }
            
            dict[element] = offset
        }
        
        return []
        
        
        //        for (index, item) in nums.enumerated() {
        //            if let i = nums.firstIndex(of: target-item), i != index {
        //                return [index, i]
        //            }
        //        }
        //
        //        return []
    }
    
    
    /*
     给你两个 非空 的链表，表示两个非负的整数。它们每位数字都是按照 逆序 的方式存储的，并且每个节点只能存储 一位 数字。
     请你将两个数相加，并以相同形式返回一个表示和的链表。
     你可以假设除了数字 0 之外，这两个数都不会以 0 开头。
     */
    func addTwoNumbers1(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
        let dummyHead = ListNode(0)
        var p = l1, q = l2, curr = dummyHead
        var carry = 0
        
        while (p != nil || q != nil) {
            let x = (p != nil) ? p!.val : 0
            let y = (q != nil) ? q!.val : 0
            let sum = x + y + carry
            carry = sum / 10
            curr.next = ListNode(sum % 10)
            curr = curr.next ?? ListNode.init()
            if (p != nil) { p = p!.next }
            if (q != nil) { q = q!.next }
        }
        
        // 如果有剩余进位，则将其添加到结果中。
        if (carry > 0) {
            curr.next = ListNode(carry)
        }
        
        // 返回结果，不包括假头。
        return dummyHead.next
    }
    
    /// 最优解
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        guard let l1 = l1,let l2 = l2 else {return nil}
        var sum = l1.val + l2.val
        let newNode = ListNode(sum%10)
        var theNode:ListNode? = newNode
        var addOne = sum >= 10 ? 1 : 0
        var node1:ListNode? = l1.next
        var node2:ListNode? = l2.next
        while node1 != nil || node2 != nil {
            sum = (node1?.val ?? 0) + (node2?.val ?? 0)
            theNode?.next = ListNode((sum+addOne)%10)
            if sum+addOne >= 10{
                addOne = 1
            }else{
                addOne = 0
            }
            if node1?.next != nil || node2?.next != nil{
                node1 = node1?.next != nil ? node1?.next : ListNode(0)
                node2 = node2?.next != nil ? node2?.next : ListNode(0)
            }else{
                node1 = nil
                node2 = nil
            }
            theNode = theNode?.next
        }
        if addOne > 0{
            theNode?.next = ListNode(addOne)
        }
        return newNode
    }
}



public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

