---
title: Lab-Template
date: 2023-09-04 22:37:03
tags:
---


# Lab 问答报告模板

## 提交须知

!!! Warning ""
    每次实验的**问答报告**包括问答和编码两部分，具体提交内容请以题面说明为准。**除此之外**，也要记得提交**实验报告**。🫡

对于每次实验的问答报告部分，你需要在**云平台**上提交一个压缩包，命名格式为 `学号-姓名-LabXX.zip`，如 `22373000-张三-Lab01`。所有问答题的回答和截图放在一个 PDF 文件中，可通过 Markdown 或 Word 导出。如有需要提交代码的问题，则新建一个文件夹用于存放所有代码，并在相应题目的回答中做出说明。提交的文件结构如下（仅供参考），最终将 `22373000-XXX-Lab01` 打包为压缩包提交即可：

```
22373000-XXX-Lab01
|-- 22373000-XXX-Lab01.pdf
|-- Q2
|   \-- Main.java
|-- Q3
|   |-- Test.java
|   \-- Hello.java
\-- Q6
    \-- Test.java
```

!!! Warning ""
    记得仔细阅读问答题目，不要遗漏问答，更不要忘记提交实验报告哦。😵‍💫

---

## 报告格式

!!! Info ""
    以下是每次 Lab 任务问答题的报告模板，仅作参考，结构清晰即可，不必完全相同。😋

# Lab XX 实验报告

> 班级：
>
> 学号：
>
> 姓名：

## Question 1

你的回答...

## Question 2

你的回答...

## ......

......

---

## Markdown 模板

问答部分的报告推荐使用 Markdown 编写，相对方便快捷，完成之后导出 PDF 提交即可。下面给出一个简单的模板供大家参考。

{% collapsecard %}

```markdown
# Lab 02 Assignment

> 班级：222100
> 
> 学号：22370000
> 
> 姓名：BUAAer

## Question 1

Java 是一门面向对象的编程语言。

## Question 2

`ArrayList` 和 `LinkedList` 均实现了 `List` 的接口，都具列表的功能，区别在于 `ArrayList` 使用动态数组作为储存容器，而 `LinkedList` 采用双向链表作为储存容器。

相关代码见 `\Solution\Question 2` 目录下的 `ArraryListTest.java` 和 `LinkedListTest.java`。
```

{% endcollapsecard %}

