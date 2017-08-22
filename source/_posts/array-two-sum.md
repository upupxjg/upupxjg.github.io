---
title: "leetcode之Two Sum"
date: 2017-08-17 23:18:12
categories: leetcode
tags: [leetcode,ACM]
---

开始尝试去A一些LeetCode的题目，本人是算法小白，希望各路大神不要见笑。希望能坚持吧LeetCode刷完，题目当然是先从Easy的刷起了~

# 题目

>Given an array of integers, return indices of the two numbers such that they add up to a specific target.
>
>You may assume that each input would have exactly one solution, and you may not use the same element twice.

**Example:**

>Given nums = [2, 7, 11, 15], target = 9,
>
>Because nums[0] + nums[1] = 2 + 7 = 9,
>return [0, 1].
  
[题目连接-two_sum](https://leetcode.com/problems/two-sum/description/)

# 解题

## 方案一 两次遍历相加

### 思路

一看到题目，就知道直接两次遍历暴力求解应该是OK的， 需要注意的就是两次遍历的index不相等即可。

### 实现

``` go
func twoSum0(nums []int, target int) []int {
    l := len(nums)
    for i := 0; i < l; i++ {
        for j := 0; j < l; j++ {
            if i != j && nums[i]+nums[j] == target {
                return []int{i, j}
            }
        }
    }
    return nil
}
```

此方案肯定能得到解，不过时间复杂度是O(n^2),Go的OJ能过，不过我用Java语言尝试发现会超时Fail。需要找一种时间复杂度小于n^2的方式。

<!-- more -->

## 方案二 利用Map对撞

### 思路

考虑到O(n^2)时间复杂度会超时的问题，这里提供一个思路，通过一个Map，key为数组中的元素，value为元素在数组中的index，利用target-当前数（c)得到需要的数(e)，检查e是否在Map中存在，若存在则返回当前遍历的索引和e在map中记录的索引。
需要注意的是返回数组的顺序，假设从数组index=0开始遍历，开始条件下map为空，找到匹配的数时，此时index应为第二个数的索引。注意到这个点以防fail。

### 实现

``` go

func twoSum1(nums []int, target int) []int {
    m := make(map[int]int, len(nums))
    for i := 0; i < len(nums); i++ {
        x := nums[i]
        if _, ok := m[x]; !ok {
            m[x] = i
        }
        y := target - x
        if x == y {
            continue
        }
        if j, ok := m[y]; ok {
            // 注意返回顺序，或者可以考虑从后向前遍历
            return []int{j, i}
        }
    }
    return nil
}
```
# 总结

第一次尝试ALeetCode的题目，感觉OJ的规则还是比较严格的，型号题目不算难，经过一些思考还是很容易找到思路。希望能坚持下去。

本文涉及的代码均已上传至github:
[代码Github地址](https://github.com/upupxjg/leetcode)