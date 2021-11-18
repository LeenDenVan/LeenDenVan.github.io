---
title: 单例模式 - Singleton Pattern
author: LeenDenVan
avatar: 'https://avatars.githubusercontent.com/u/16818274?v=4'
authorLink: hojun.cn
authorAbout: LeenDenVan
authorDesc: 
categories: 软件设计
comments: true
date: 2021-11-11 20:17:31
tags: 
    - 设计模式
    - 创建型模式
keywords:
description:
photos: https://leendvanspics.oss-cn-beijing.aliyuncs.com/pic/86531238_p25.jpg
---

## 模式定义
> **单例模式**是一种创建型设计模式， 让你能够保证一个类只有一个实例， 并提供一个访问该实例的全局节点。
> **Singleton** is a creational design pattern that lets you ensure that a class has only one instance, while providing a global access point to this instance.

## 模式结构
[![](https://mermaid.ink/img/eyJjb2RlIjoiY2xhc3NEaWFncmFtXG5jbGFzcyBTaW5nbGV0b257XG4gIC1TaW5nbGV0b24gaW5zdGFuY2UkXG4gIC1TaW5nbGV0b24oKVxuICArZ2V0SW5zdGFuY2UoKSQgU2luZ2xldG9uXG59IiwibWVybWFpZCI6eyJ0aGVtZSI6ImRlZmF1bHQifSwidXBkYXRlRWRpdG9yIjpmYWxzZSwiYXV0b1N5bmMiOnRydWUsInVwZGF0ZURpYWdyYW0iOmZhbHNlfQ)](https://mermaid-js.github.io/mermaid-live-editor/edit#eyJjb2RlIjoiY2xhc3NEaWFncmFtXG5jbGFzcyBTaW5nbGV0b257XG4gIC1TaW5nbGV0b24gaW5zdGFuY2UkXG4gIC1TaW5nbGV0b24oKVxuICArZ2V0SW5zdGFuY2UoKSQgU2luZ2xldG9uXG59IiwibWVybWFpZCI6IntcbiAgXCJ0aGVtZVwiOiBcImRlZmF1bHRcIlxufSIsInVwZGF0ZUVkaXRvciI6ZmFsc2UsImF1dG9TeW5jIjp0cnVlLCJ1cGRhdGVEaWFncmFtIjpmYWxzZX0)

## 代码例
### 饿汉式
```java
public class Singleton{
    private static final Singleton singleton = new Singleton();

    private Singleton() {}

    public static Singleton getSingleton() {
        return singleton;
    }
}
```
### 非线程安全懒汉式
```java
public class Singleton {

    private static Singleton singleton;

    private Singleton() {}

    public static Singleton getSingleton() {
        if (singleton == null) {
            singleton = new Singleton();
        }
        return singleton;
    }

}
```
### 低效的线程安全懒汉式
```java
public class Singleton {

    private static Singleton singleton;

    private Singleton() {}

    public static synchronized Singleton getSingleton() {
        if (singleton == null) {
            singleton = new Singleton();
        }
        return singleton;
    }

}
```
### 双重校验锁线程安全懒汉式
```java
public class Singleton {

    private static Singleton singleton;

    private Singleton() {}

    public static Singleton getSingleton() {
        if (singleton == null) {
            synchronized (Singleton.class) {
                if (singleton == null) {
                    singleton = new Singleton();
                }
            }
        }
        return singleton;
    }

}
```

### 枚举式
```java
public enum Singleton {
    INSTANCE;
}
```

### 静态内部类
```java
public class Singleton {
    private Singleton() {}
    private static final class SingletonHolder {
        private SingletonHolder() {}
        private static Singleton4 instance = new Singleton();

    }
    public static Singleton getInstance() {
        return SingletonHolder.instance;
    }
}
```

## 应用
### 适用环境
- 系统只需要一个实例对象，如系统要求提供一个唯一的序列号生成器，或者需要考虑资源消耗太大而只允许创建一个对象。
- 客户调用类的单个实例只允许使用一个公共访问点，除了该公共访问点，不能通过其他途径访问该实例。
- 在一个系统中要求一个类只有一个实例时才应当使用单例模式。反过来，如果一个类可以有几个实例共存，就需要对单例模式进行改进，使之成为多例模式。
