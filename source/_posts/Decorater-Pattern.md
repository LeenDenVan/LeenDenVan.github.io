---
title: 装饰模式 - Decorator Pattern
author: LeenDenVan
avatar: 'https://avatars.githubusercontent.com/u/16818274?v=4'
authorLink: leendvansland.xyz
authorAbout: LeenDenVan
authorDesc: 
categories: 软件设计
comments: true
date: 2021-11-13 09:14:59
tags: 
    - 设计模式
    - 结构型模式
keywords: 
description:
photos: https://leendvanspics.oss-cn-beijing.aliyuncs.com/pic/2020-09-23_21.09.47.png
---

## 模式定义
> 装饰模式动态地将责任附加到对象上。若要拓展功能，装饰提供了比继承更有弹性地替代方案
> ***The Decorator Pattern*** *attaches additional responsibilities to an object dynamically.*
 *Decorators provide a flexible alternative to subclassing for extending functinality*

## 模式结构
### 模式构成
1. 部件 （Component） 声明封装器和被封装对象的公用接口。
2. 具体部件 （Concrete Component） 类是被封装对象所属的类。 它定义了基础行为， 但装饰类可以改变这些行为。
3. 基础装饰 （Base Decorator） 类拥有一个指向被封装对象的引用成员变量。 该变量的类型应当被声明为通用部件接口， 这样它就可以引用具体的部件和装饰。 装饰基类会将所有操作委派给被封装的对象。
4. 具体装饰类 （Concrete Decorators） 定义了可动态添加到部件的额外行为。 具体装饰类会重写装饰基类的方法， 并在调用父类方法之前或之后进行额外的行为。
### 结构类图
[![](https://mermaid.ink/img/eyJjb2RlIjoiY2xhc3NEaWFncmFtXG5Db21wb25lbnQgPHwtLSBDb25jcmV0ZUNvbXBvbmVudFxuQ29tcG9uZW50IDwtLSBEZWNvcmF0b3JcbkNvbXBvbmVudCA8fC0tIERlY29yYXRvclxuRGVjb3JhdG9yIDx8LS0gQ29uY3JldGVEZWNvcmF0b3JBXG5EZWNvcmF0b3IgPHwtLSBDb25jcmV0ZURlY29yYXRvckJcbmNsYXNzIENvbXBvbmVudHtcbiAgPDxhYnN0cmFjdD4-XG4gIG1ldGhvZEEoKSpcbiAgbWV0aG9kQigpKlxufVxuY2xhc3MgRGVjb3JhdG9ye1xuICAtQ29tcG9uZW50IHdyYXBwZWRPYmplY3RcbiAgK21ldGhvZEEoKVxuICArbWV0aG9kQigpXG59XG5jbGFzcyBDb25jcmV0ZURlY29yYXRvckF7XG4gIG1ldGhvZEEoKVxuICBtZXRob2RCKClcbiAgbmV3TWV0aG9kKClcbn1cbmNsYXNzIENvbmNyZXRlRGVjb3JhdG9yQntcbiAgT2JqZWN0IG5ld1N0YXRlXG4gIG1ldGhvZEEoKVxuICBtZXRob2RCKClcbn1cbmNsYXNzIENvbmNyZXRlQ29tcG9uZW50e1xuICBtZXRob2RBKClcbiAgbWV0aG9kQigpXG59XG4iLCJtZXJtYWlkIjp7InRoZW1lIjoiZGVmYXVsdCJ9LCJ1cGRhdGVFZGl0b3IiOmZhbHNlLCJhdXRvU3luYyI6dHJ1ZSwidXBkYXRlRGlhZ3JhbSI6ZmFsc2V9)](https://mermaid-js.github.io/mermaid-live-editor/edit#eyJjb2RlIjoiY2xhc3NEaWFncmFtXG5Db21wb25lbnQgPHwtLSBDb25jcmV0ZUNvbXBvbmVudFxuQ29tcG9uZW50IDwtLSBEZWNvcmF0b3JcbkNvbXBvbmVudCA8fC0tIERlY29yYXRvclxuRGVjb3JhdG9yIDx8LS0gQ29uY3JldGVEZWNvcmF0b3JBXG5EZWNvcmF0b3IgPHwtLSBDb25jcmV0ZURlY29yYXRvckJcbmNsYXNzIENvbXBvbmVudHtcbiAgPDxhYnN0cmFjdD4-XG4gIG1ldGhvZEEoKSpcbiAgbWV0aG9kQigpKlxufVxuY2xhc3MgRGVjb3JhdG9ye1xuICAtQ29tcG9uZW50IHdyYXBwZWRPYmplY3RcbiAgK21ldGhvZEEoKVxuICArbWV0aG9kQigpXG59XG5jbGFzcyBDb25jcmV0ZURlY29yYXRvckF7XG4gIG1ldGhvZEEoKVxuICBtZXRob2RCKClcbiAgbmV3TWV0aG9kKClcbn1cbmNsYXNzIENvbmNyZXRlRGVjb3JhdG9yQntcbiAgT2JqZWN0IG5ld1N0YXRlXG4gIG1ldGhvZEEoKVxuICBtZXRob2RCKClcbn1cbmNsYXNzIENvbmNyZXRlQ29tcG9uZW50e1xuICBtZXRob2RBKClcbiAgbWV0aG9kQigpXG59XG4iLCJtZXJtYWlkIjoie1xuICBcInRoZW1lXCI6IFwiZGVmYXVsdFwiXG59IiwidXBkYXRlRWRpdG9yIjpmYWxzZSwiYXV0b1N5bmMiOnRydWUsInVwZGF0ZURpYWdyYW0iOmZhbHNlfQ)

## Example
[![](https://mermaid.ink/img/eyJjb2RlIjoiY2xhc3NEaWFncmFtXG5CZXZlcmFnZSA8fC0tIEVzcHJlc3NvXG5CZXZlcmFnZSA8fC0tIENvbmRpbWVudERlY29yYXRvclxuQmV2ZXJhZ2UgPC0tIENvbmRpbWVudERlY29yYXRvclxuQ29uZGltZW50RGVjb3JhdG9yIDx8LS0gU295XG5Db25kaW1lbnREZWNvcmF0b3IgPHwtLSBTdGVhbWVkTWlsa1xuQ29uZGltZW50RGVjb3JhdG9yIDx8LS0gTW9jaGFcbmNsYXNzIEJldmVyYWdle1xuICA8PGFic3RyYWN0Pj5cbiAgI1N0cmluZyBkZXNjcmlwdGlvblxuICArZ2V0RGVzY3JpcHRpb24oKSBTdHJpbmdcbiAgK3RvU3RyaW5nKCkgU3RyaW5nXG4gICtjb3N0KCkqIGRvdWJsZVxufVxuY2xhc3MgRXNwcmVzc297XG4gICtjb3N0KCkgZG91YmxlXG59XG5jbGFzcyBDb25kaW1lbnREZWNvcmF0b3J7XG4gIDw8YWJzdHJhY3Q-PlxuICAjQmV2ZXJhZ2UgYmV2ZXJhZ2VcbiAgK2dldERlc2NyaXB0aW9uKCkqIFN0cmluZ1xufVxuY2xhc3MgU295e1xuICArZ2V0RGVzY3JpcHRpb24oKSBTdHJpbmdcbiAgK2Nvc3QoKSBkb3VibGVcbn1cbmNsYXNzIFN0ZWFtZWRNaWxre1xuICArZ2V0RGVzY3JpcHRpb24oKSBTdHJpbmdcbiAgK2Nvc3QoKSBkb3VibGVcbn1cbmNsYXNzIE1vY2hhe1xuICArZ2V0RGVzY3JpcHRpb24oKSBTdHJpbmdcbiAgK2Nvc3QoKSBkb3VibGVcbn0iLCJtZXJtYWlkIjp7InRoZW1lIjoiZGVmYXVsdCJ9LCJ1cGRhdGVFZGl0b3IiOmZhbHNlLCJhdXRvU3luYyI6dHJ1ZSwidXBkYXRlRGlhZ3JhbSI6ZmFsc2V9)](https://mermaid-js.github.io/mermaid-live-editor/edit#eyJjb2RlIjoiY2xhc3NEaWFncmFtXG5CZXZlcmFnZSA8fC0tIEVzcHJlc3NvXG5CZXZlcmFnZSA8fC0tIENvbmRpbWVudERlY29yYXRvclxuQmV2ZXJhZ2UgPC0tIENvbmRpbWVudERlY29yYXRvclxuQ29uZGltZW50RGVjb3JhdG9yIDx8LS0gU295XG5Db25kaW1lbnREZWNvcmF0b3IgPHwtLSBTdGVhbWVkTWlsa1xuQ29uZGltZW50RGVjb3JhdG9yIDx8LS0gTW9jaGFcbmNsYXNzIEJldmVyYWdle1xuICA8PGFic3RyYWN0Pj5cbiAgI1N0cmluZyBkZXNjcmlwdGlvblxuICArZ2V0RGVzY3JpcHRpb24oKSBTdHJpbmdcbiAgK3RvU3RyaW5nKCkgU3RyaW5nXG4gICtjb3N0KCkqIGRvdWJsZVxufVxuY2xhc3MgRXNwcmVzc297XG4gICtjb3N0KCkgZG91YmxlXG59XG5jbGFzcyBDb25kaW1lbnREZWNvcmF0b3J7XG4gIDw8YWJzdHJhY3Q-PlxuICAjQmV2ZXJhZ2UgYmV2ZXJhZ2VcbiAgK2dldERlc2NyaXB0aW9uKCkqIFN0cmluZ1xufVxuY2xhc3MgU295e1xuICArZ2V0RGVzY3JpcHRpb24oKSBTdHJpbmdcbiAgK2Nvc3QoKSBkb3VibGVcbn1cbmNsYXNzIFN0ZWFtZWRNaWxre1xuICArZ2V0RGVzY3JpcHRpb24oKSBTdHJpbmdcbiAgK2Nvc3QoKSBkb3VibGVcbn1cbmNsYXNzIE1vY2hhe1xuICArZ2V0RGVzY3JpcHRpb24oKSBTdHJpbmdcbiAgK2Nvc3QoKSBkb3VibGVcbn0iLCJtZXJtYWlkIjoie1xuICBcInRoZW1lXCI6IFwiZGVmYXVsdFwiXG59IiwidXBkYXRlRWRpdG9yIjpmYWxzZSwiYXV0b1N5bmMiOnRydWUsInVwZGF0ZURpYWdyYW0iOmZhbHNlfQ)

### Java Version

```java
//Beverage.java
public abstract class Beverage {
    protected String description = "Unknown Beverage";
    public String getDescription(){ return description; }
    @Override
    public String toString(){ return getDescription() + " $" + cost(); }
    public abstract double cost();
}
//CondimentDecorator.java
public abstract class CondimentDecorator extends Beverage{
    Beverage beverage;
    public abstract String getDescription();
}
//Espresso.java
public class Espresso extends Beverage{
    public Espresso(){ description = "Espresso"; }

    @Override
    public double cost() { return 1.99; }
}
//Soy.java
public class Soy extends CondimentDecorator{

    public Soy(Beverage beverage){ this.beverage = beverage; }

    @Override
    public String getDescription() { return this.beverage.getDescription() + " ,Soy"; }

    @Override
    public double cost(){ return 0.10 + this.beverage.cost(); }
}
//SteamedMilk.java
public class SteamedMilk extends CondimentDecorator{

    public SteamedMilk(Beverage beverage){ this.beverage = beverage; }

    @Override
    public String getDescription() { return this.beverage.getDescription() + ", Steamed Milk"; }

    @Override
    public double cost() { return 0.10 + this.beverage.cost(); }
}
//Mocha.java
public class Mocha extends CondimentDecorator{

    public Mocha(Beverage beverage){ this.beverage = beverage; }

    @Override
    public String getDescription() { return beverage.getDescription() + ", Mocha"; }

    @Override
    public double cost() { return 0.20 + beverage.cost(); }
}
//Main.java
public class Main {
    public static void main(String[] args){
        Espresso espresso = new Espresso();
        Mocha mocha = new Mocha(espresso);
        println(new Soy(new SteamedMilk(mocha)));
    }
    static void println(Object obj){
        System.out.println(obj);
    }
}
/* Output:
* Espresso, Mocha, Steamed Milk ,Soy $2.39
*/
```
### Kotlin Version
```kotlin
interface Beverage{
    var description: String
    fun cost():Double
}

abstract class CondimentDecorator(val beverage: Beverage) : Beverage by beverage {
    override var description: String = ""
    override fun toString():String = "$description $${cost()}"
}

class Espresso(override var description: String = "Espresso") : Beverage{
    override fun cost():Double = 1.99
    override fun toString():String = "$description $ ${cost()}"
}

class Soy(beverage: Beverage) : CondimentDecorator(beverage){
    override var description: String = "${beverage.description}, Soy"
    override fun cost(): Double = 0.10 + beverage.cost()
}

class Mocha(beverage: Beverage) : CondimentDecorator(beverage){
    override var description: String = "${beverage.description}, Mocha"
    override fun cost(): Double = 0.20 + beverage.cost()
}

class SteamedMilk(beverage: Beverage) : CondimentDecorator(beverage){
    override var description: String = "${beverage.description}, Steamed Milk"
    override fun cost(): Double = 0.10 + beverage.cost()
}

fun main(args:Array<String>){
    var espresso = Espresso()
    var mocha = Mocha(espresso)
    println(Soy(SteamedMilk(mocha)))
}
```
## 实际应用

### Java I/O
   [![](https://mermaid.ink/img/eyJjb2RlIjoiY2xhc3NEaWFncmFtXG5JbnB1dFN0cmVhbSA8fC0tIEZpbGVJbnB1dFN0cmVhbVxuSW5wdXRTdHJlYW0gPHwtLSBTdHJpbmdCdWZmZXJJbnB1dFN0cmVhbVxuSW5wdXRTdHJlYW0gPHwtLSBCeXRlQXJyYXlJbnB1dFN0cmVhbVxuSW5wdXRTdHJlYW0gPHwtLSBGaWx0ZXJJbnB1dFN0cmVhbVxuSW5wdXRTdHJlYW0gPC0tIEZpbHRlcklucHV0U3RyZWFtXG5GaWx0ZXJJbnB1dFN0cmVhbSA8fC0tIFB1c2hCYWNrSW5wdXRTdHJlYW1cbkZpbHRlcklucHV0U3RyZWFtIDx8LS0gQnVmZmVyZWRJbnB1dFN0cmVhbVxuRmlsdGVySW5wdXRTdHJlYW0gPHwtLSBEYXRhSW5wdXRTdHJlYW1cbkZpbHRlcklucHV0U3RyZWFtIDx8LS0gSW5mbGF0b3JJbnB1dFN0cmVhbVxuSW5mbGF0b3JJbnB1dFN0cmVhbSA8fC0tIFppcElucHV0U3RyZWFtXG5jbGFzcyBGaWx0ZXJJbnB1dFN0cmVhbXtcbiAgPDxhYnN0cmFjdD4-XG59XG5jbGFzcyBJbnB1dFN0cmVhbXtcbiAgPDxhYnN0cmFjdD4-XG59XG4iLCJtZXJtYWlkIjp7InRoZW1lIjoiZGVmYXVsdCJ9LCJ1cGRhdGVFZGl0b3IiOmZhbHNlLCJhdXRvU3luYyI6dHJ1ZSwidXBkYXRlRGlhZ3JhbSI6ZmFsc2V9)](https://mermaid-js.github.io/mermaid-live-editor/edit#eyJjb2RlIjoiY2xhc3NEaWFncmFtXG5JbnB1dFN0cmVhbSA8fC0tIEZpbGVJbnB1dFN0cmVhbVxuSW5wdXRTdHJlYW0gPHwtLSBTdHJpbmdCdWZmZXJJbnB1dFN0cmVhbVxuSW5wdXRTdHJlYW0gPHwtLSBCeXRlQXJyYXlJbnB1dFN0cmVhbVxuSW5wdXRTdHJlYW0gPHwtLSBGaWx0ZXJJbnB1dFN0cmVhbVxuSW5wdXRTdHJlYW0gPC0tIEZpbHRlcklucHV0U3RyZWFtXG5GaWx0ZXJJbnB1dFN0cmVhbSA8fC0tIFB1c2hCYWNrSW5wdXRTdHJlYW1cbkZpbHRlcklucHV0U3RyZWFtIDx8LS0gQnVmZmVyZWRJbnB1dFN0cmVhbVxuRmlsdGVySW5wdXRTdHJlYW0gPHwtLSBEYXRhSW5wdXRTdHJlYW1cbkZpbHRlcklucHV0U3RyZWFtIDx8LS0gSW5mbGF0b3JJbnB1dFN0cmVhbVxuSW5mbGF0b3JJbnB1dFN0cmVhbSA8fC0tIFppcElucHV0U3RyZWFtXG5jbGFzcyBGaWx0ZXJJbnB1dFN0cmVhbXtcbiAgPDxhYnN0cmFjdD4-XG59XG5jbGFzcyBJbnB1dFN0cmVhbXtcbiAgPDxhYnN0cmFjdD4-XG59XG4iLCJtZXJtYWlkIjoie1xuICBcInRoZW1lXCI6IFwiZGVmYXVsdFwiXG59IiwidXBkYXRlRWRpdG9yIjpmYWxzZSwiYXV0b1N5bmMiOnRydWUsInVwZGF0ZURpYWdyYW0iOmZhbHNlfQ)

### 应用场景
- 在无需修改代码的情况下即可使用对象， 且希望在运行时为对象新增额外的行为的时候。
- 用继承来扩展对象行为的方案难以实现或者根本不可行， 可以使用该模式。
