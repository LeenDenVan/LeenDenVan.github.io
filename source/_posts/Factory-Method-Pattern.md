---
title: 工厂方法模式 - Factory Method Pattern
author: LeenDenVan
avatar: 'https://avatars.githubusercontent.com/u/16818274?v=4'
authorLink: leendvansland.xyz
categories: 软件设计
comments: true
date: 2021-11-14 16:29:23
authorAbout:
authorDesc:
tags: 
    - 设计模式 
    - 创建型模式
keywords:
description:
photos:
---

## 定义
>工厂方法模式是一种创建型设计模式， 其在父类中提供一个创建对象的方法， 允许子类决定实例化对象的类型。
>**Factory Method** is a creational design pattern that provides an interface for creating objects in a superclass, but allows subclasses to alter the type of objects that will be created.

## 模式结构

### 模式构成
1. **产品** （Product） 将会对接口进行声明。 对于所有由创建者及其子类构建的对象， 这些接口都是通用的。
2. **具体产品** （Concrete Products） 是产品接口的不同实现。
3. **创建者**（Creator） 类声明返回产品对象的工厂方法。 该方法的返回对象类型必须与产品接口相匹配。
4. **具体创建者** （Concrete Creators） 将会重写基础工厂方法， 使其返回不同类型的产品。

### 结构类图
[![](https://mermaid.ink/img/eyJjb2RlIjoiY2xhc3NEaWFncmFtXG5Qcm9kdWN0IDx8Li4gUHJvZHVjdEFcblByb2R1Y3QgPHwuLiBQcm9kdWN0QlxuQ3JlYXRvciAuLj4gUHJvZHVjdFxuQ3JlYXRvciA8fC0tIENvbmNyZXRlQ3JlYXRvckFcbkNyZWF0b3IgPHwtLSBDb25jcmV0ZUNyZWF0b3JCXG5jbGFzcyBQcm9kdWN0e1xuICA8PGludGVyZmFjZT4-XG4gICtkb1N0dWZmKClcbn1cbmNsYXNzIENyZWF0b3J7XG4gICtzb21lT3BlcmF0aW9uKClcbiAgK2NyZWF0ZVByb2R1Y3QoKVxufVxuY2xhc3MgQ29uY3JldGVDcmVhdG9yQXtcbiAgK2NyZWF0ZVByb2R1Y3QoKVxufVxuY2xhc3MgQ29uY3JldGVDcmVhdG9yQntcbiAgK2NyZWF0ZVByb2R1Y3QoKVxufSIsIm1lcm1haWQiOnsidGhlbWUiOiJkZWZhdWx0In0sInVwZGF0ZUVkaXRvciI6ZmFsc2UsImF1dG9TeW5jIjp0cnVlLCJ1cGRhdGVEaWFncmFtIjpmYWxzZX0)](https://mermaid-js.github.io/mermaid-live-editor/edit#eyJjb2RlIjoiY2xhc3NEaWFncmFtXG5Qcm9kdWN0IDx8Li4gUHJvZHVjdEFcblByb2R1Y3QgPHwuLiBQcm9kdWN0QlxuQ3JlYXRvciAuLj4gUHJvZHVjdFxuQ3JlYXRvciA8fC0tIENvbmNyZXRlQ3JlYXRvckFcbkNyZWF0b3IgPHwtLSBDb25jcmV0ZUNyZWF0b3JCXG5jbGFzcyBQcm9kdWN0e1xuICA8PGludGVyZmFjZT4-XG4gICtkb1N0dWZmKClcbn1cbmNsYXNzIENyZWF0b3J7XG4gICtzb21lT3BlcmF0aW9uKClcbiAgK2NyZWF0ZVByb2R1Y3QoKVxufVxuY2xhc3MgQ29uY3JldGVDcmVhdG9yQXtcbiAgK2NyZWF0ZVByb2R1Y3QoKVxufVxuY2xhc3MgQ29uY3JldGVDcmVhdG9yQntcbiAgK2NyZWF0ZVByb2R1Y3QoKVxufSIsIm1lcm1haWQiOiJ7XG4gIFwidGhlbWVcIjogXCJkZWZhdWx0XCJcbn0iLCJ1cGRhdGVFZGl0b3IiOmZhbHNlLCJhdXRvU3luYyI6dHJ1ZSwidXBkYXRlRGlhZ3JhbSI6ZmFsc2V9)

## Code Example

```java
//Dialog.java
//Creator
public abstract class Dialog {

    public void render(){
        Button okButton = createButton();
        okButton.onClick("Close Dialog");
        okButton.render();
    }

    public abstract Button createButton();
}
//WebDialog.java
//ConcreteCreatorA
public class WebDialog extends Dialog{
    public Button createButton(){
        return new HTMLButton();
    }
}
//WindowsDialog.java
//ConcreteCreatorB
public class WindowsDialog extends Dialog{
    public Button createButton(){
        return new WindowsButton();
    }
}

//Button.java
//Product
public interface Button {
    public void render();
    public void onClick(String message);
}
//WindowsButton.java
//ProductA
public class WindowsButton implements Button{
    @Override
    public void render() {
        System.out.println("Rendering "+ this.getClass().getSimpleName());
    }
    @Override
    public void onClick(String message) {
        System.out.println("WindowsButton is clicked" + message);
    }
}
//HTMLButton.java
//ProductB
public class HTMLButton implements Button{
    @Override
    public void render() {
        System.out.println("Rendering " + this.getClass().getSimpleName());
    }
    @Override
    public void onClick(String message) {
        System.out.println("HTMLButton is clicked. " + message);
    }
}
//Main.java
//Test
public class Main {
    static Dialog dialog;
    static void initialize(){
        String systemname = System.getProperty("os.name");
        if(systemname.contains("Windows")){
            dialog = new WindowsDialog();
        }else if(systemname.contains("Web")){
            dialog = new WebDialog();
        }
    }
    public static void main(String[] args){
        initialize();
        dialog.render();
    }
    public static void println(Object obj){
        System.out.println(obj);
    }
}
/* Output
* WindowsButton is clickedClose Dialog
* Rendering WindowsButton
*/
```
## 应用
### 应用场景
 - 无法预知对象确切类别及其依赖关系时
 - 希望用户能扩展软件库或框架的内部组件
 - 通过复用现有对象来节省系统资源， 而不是每次都重新创建对象

### Java核心库中的应用
- [java.util.Calendar#getInstance()](https://docs.oracle.com/javase/8/docs/api/java/util/Calendar.html#getInstance--)
- [java.util.ResourceBundle#getBundle()](https://docs.oracle.com/javase/8/docs/api/java/util/ResourceBundle.html#getBundle-java.lang.String-)
- [java.text.NumberFormat#getInstance()](https://docs.oracle.com/javase/8/docs/api/java/text/NumberFormat.html#getInstance--)
- [java.nio.charset.Charset#forName()](https://docs.oracle.com/javase/8/docs/api/java/nio/charset/Charset.html#forName-java.lang.String-)
- [java.net.URLStreamHandlerFactory#createURLStreamHandler(String)](https://docs.oracle.com/javase/8/docs/api/java/net/URLStreamHandlerFactory.html)
- [java.util.EnumSet#of()](https://docs.oracle.com/javase/8/docs/api/java/util/EnumSet.html#of(E))
- [javax.xml.bind.JAXBContext#createMarshaller()](https://docs.oracle.com/javase/8/docs/api/javax/xml/bind/JAXBContext.html#createMarshaller--)