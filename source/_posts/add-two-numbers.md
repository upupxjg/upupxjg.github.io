---
title: leetcode之add-two-numbers
categories: leetcode
tags:
  - leetcode
  - ACM
date: 2017-08-22 21:55:43
---

# 题目

>You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.
>
>You may assume the two numbers do not contain any leading zero, except the number 0 itself.

**Example:**

>Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
>Output: 7 -> 0 -> 8

[题目连接-add_two_numbers](https://leetcode.com/problems/add-two-numbers/description/)

题目大意就是存在两个非空链表代表两个非负数，链表元素是代表的数字从低位到高位循序的排列，链表不会以0开头除非链表代表的数字是0本身。
要求返回链表代表的两个数字的和，同样以相同的链表形式表示。

# 解题

## 方案一 
### 思路
把链表代表的数字得到，直接相加再转换回链表。
看到题目第一个念头想到的就是这个思路，既然要求链表代表数字的和，索性先拿到链表代表的数字，直接求和再根据规则转回链表。
话不多说，直接撸代码：

### 代码

``` go
func addTwoNumbers(l1 *ListNode, l2 *ListNode) *ListNode {
	n := 0
	for i, e := 0, 2; ; i, e = i+1, 2 {
		if l1 != nil {
			n += int(math.Pow10(i)) * l1.Val
			l1 = l1.Next
		} else {
			e--
		}
		if l2 != nil {
			n += int(math.Pow10(i)) * l2.Val
			l2 = l2.Next
		} else {
			e--
		}
		if e == 0 {
			break
		}
	}
	head := &ListNode{}
	node := head
	for {
		node.Val = n % 10
		n /= 10
		if n > 0 {
			node.Next = &ListNode{}
			node = node.Next
		} else {
			break
		}
	}
	return head
}
```
按这个思路代码实现很简单明白，提OJ，直接Fail！
看TestCase。。。 发现自己too naive，TestCase直接给出一个长度超过int代表数位的链表，看来此路不通。
<!-- more -->
## 方案二
### 思路
静下心来考虑，此题目的正常逻辑应该是要考察链表操作的，另一个思路也不难想到，直接根据加法规则同位相加大于等于10进位，配合一些链表操作应该可以实现。
于是有一下代码

### 代码

``` go
func addTwoNumbers2(l1 *ListNode, l2 *ListNode) *ListNode {
	head := &ListNode{}  // 记录链表头
	node := head  // 用node指针迭代
	for {
		if l1 != nil {
			node.Val += l1.Val
			l1 = l1.Next
		}
		if l2 != nil {
			node.Val += l2.Val
			l2 = l2.Next
		}
		if node.Val > 9 { // 同位相加大于等于10进位，创建更高位的Node，并先将其val设为1，这个if写在前面主要是发现需要进位不需要考虑是否后面还有运算
			node.Next = &ListNode{}
			node.Next.Val = 1
			node.Val -= 10
		}
		if l1 != nil || l2 != nil { // 判断 l1,l2两个数更高位是否还存在，当都不存在时结束算法
			if node.Next == nil {
				node.Next = &ListNode{}
			}
		} else { // 所有数位都计算完了，高位进位也提前处理了，直接break 完成！
			break
		}
		node = node.Next
	}
	return head
}
```
提交代码 Accept！，不过看执行时间大概在top90%,应该局部还存在优化空间，后续有时间再考虑一下！

[Github地址](https://github.com/upupxjg/leetcode)