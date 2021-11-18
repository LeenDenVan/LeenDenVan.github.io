---
title: 抽象工厂模式 - Abstract Factory Pattern
author: LeenDenVan
avatar: 'https://avatars.githubusercontent.com/u/16818274?v=4'
authorLink: leendvansland.xyz
categories: 软件设计
comments: true
date: 2021-11-15 01:32:30
authorAbout:
authorDesc:
tags: 
    - 设计模式
    - 创建型模式
keywords:
description:
photos: https://leendvanspics.oss-cn-beijing.aliyuncs.com/pic/82886110_p0_master1200.jpg
---

## 模式定义
> 抽象工厂模式是一种创建型设计模式， 它能创建一系列相关的对象， 而无需指定其具体类。
> **Abstract Factory** is a creational design pattern that lets you produce families of related objects without specifying their concrete classes.

## 模式结构
### 模式构成
1. **抽象产品** （Abstract Product） 为构成系列产品的一组不同但相关的产品声明接口。
2. **具体产品** （Concrete Product） 是抽象产品的多种不同类型实现。 所有变体 都必须实现相应的抽象产品 。
3. **抽象工厂** （Abstract Factory） 接口声明了一组创建各种抽象产品的方法。
4. **具体工厂** （Concrete Factory） 实现抽象工厂的构建方法。 每个具体工厂都对应特定产品变体， 且仅创建此种产品变体。
### 模式类图
![](https://refactoringguru.cn/images/patterns/diagrams/abstract-factory/structure-2x.png)

## Code Example


```java
//AssemblingMachine.java Abstract Factory
public interface AssemblingMachine {
    public ConveyorBelt makeConveyorbelt();
    public PowerTower makePowerTower();
}
//AssemblingMachineMK1.java Concrete Factory 1
public class AssemblingMachineMK1 implements AssemblingMachine {

    @Override
    public ConveyorBelt makeConveyorbelt() {
        return new ConveyorBeltMK1();
    }

    @Override
    public PowerTower makePowerTower() {
        return new TeslaTower();
    }
}
//AssemblingMachineMK2.java Concrete Factory 2
public class AssemblingMachineMK2 implements AssemblingMachine{
    @Override
    public ConveyorBelt makeConveyorbelt() {
        return new ConveyorBeltMK2();
    }
    @Override
    public PowerTower makePowerTower() {
        return new WirelessPowerTower();
    }
}
//AssemblingMachineMK3.java Concrete Factory 3
public class AssemblingMachineMK3 implements AssemblingMachine {
    @Override
    public ConveyorBelt makeConveyorbelt() {
        return new ConveyorBeltMK3();
    }
    @Override
    public PowerTower makePowerTower() {
        return new SatelliteSubstation();
    }
}
//AssemblingMachineTire.java
public enum AssembingMachineTire {
    MK1, MK2, MK3
}
//AssemblingTerminal.java Client
public class AssemblingTerminal {
    private AssemblingMachine assemblingMachine;
    public AssemblingTerminal(AssembingMachineTire tire){
        setAssemblingMachine(tire);
    }
    public void setAssemblingMachine(AssembingMachineTire tire) {
        switch (tire){
            case MK1: assemblingMachine = new AssemblingMachineMK1();break;
            case MK2: assemblingMachine = new AssemblingMachineMK2();break;
            case MK3: assemblingMachine = new AssemblingMachineMK3();break;
        }
    }
    public ConveyorBelt makeConveyorBelt(){
        return assemblingMachine.makeConveyorbelt();
    }
    public PowerTower makePowerTower(){
        return assemblingMachine.makePowerTower();
    }
}
//ConveyorBelt.java ProductA
public abstract class ConveyorBelt extends GameObject{
    public abstract int getSpeedPerMinute();
    @Override
    public String getDescription() {
        return super.getDescription() + "\n Transport Speed:" + getSpeedPerMinute() +"items/minute" ;
    }
}
//ConveyorBeltMK1.java Concrete ProductA1
public class ConveyorBeltMK1 extends ConveyorBelt {

    @Override
    public int getSpeedPerMinute() {
        return 360;
    }

    @Override
    public double getCraftingEnergy() {
        return 0.656;
    }

    @Override
    public HashMap<String, Double> getRecipe() {
        HashMap<String, Double> recipe = new HashMap<>();
        recipe.put("Iron Ignot", 2.0);
        recipe.put("Gear", 1.0);
        return recipe;
    }
}
//ConveyorBeltMK2.java Concrete ProductA2
public class ConveyorBeltMK2 extends ConveyorBelt{
    @Override
    public int getSpeedPerMinute() {
        return 12*60;
    }
    @Override
    public double getCraftingEnergy() {
        return 3.90;
    }
    @Override
    public HashMap<String, Double> getRecipe() {
        HashMap<String, Double> recipe = new HashMap<>();
        recipe.put("Conveyor Belt MK.I", 3.0);
        recipe.put("Electromagnetic Turbine", 1.0);
        return recipe;
    }
}
//ConveyorBeltMK3.java Concrete ProductA3
public class ConveyorBeltMK3 extends ConveyorBelt{
    @Override
    public int getSpeedPerMinute() {
        return 30*60;
    }

    @Override
    public double getCraftingEnergy() {
        return 12.9;
    }

    @Override
    public HashMap<String, Double> getRecipe() {
        HashMap<String, Double> recipe = new HashMap<>();
        recipe.put("Conveyor Belt MK.II", 3.0);
        recipe.put("Super-Magnetic Ring", 1.0);
        recipe.put("Graphene", 1.0);
        return recipe;
    }
}
//GameObject.java
public abstract class GameObject {
    public String getName(){
        return this.getClass().getSimpleName();
    }
    public String getDescription(){
        String res = getName() + " Crafting Energy:" + getCraftingEnergy() + "\n";
        for(Map.Entry<String, Double> entry : getRecipe().entrySet()){
            res+=entry.getKey()+"/"+entry.getValue()+"+";
        }
        return res;
    }
    @Override
    public String toString(){
        return getDescription();
    }

    public abstract double getCraftingEnergy();
    public abstract HashMap<String, Double> getRecipe();
}
//PowerTower.java ProductB
public abstract class PowerTower extends GameObject{
    public abstract int getRadius();
    @Override
    public String getDescription(){
        return super.getDescription() + " \nRadius" + getRadius();
    }
}
//SatelliteSubstation.java Concrete ProductB1
public class SatelliteSubstation extends PowerTower {
    @Override
    public int getRadius() {
        return 100;
    }

    @Override
    public double getCraftingEnergy() {
        return 347.0;
    }

    @Override
    public HashMap<String, Double> getRecipe() {
        HashMap<String, Double> recipe = new HashMap<>();
        recipe.put("Wireless Power Tower", 1.0);
        recipe.put("Super-Magnetic Ring", 10.0);
        recipe.put("Frame Material", 2.0);
        return recipe;
    }
}
//TeslaTower.java Concrete ProductB2
public class TeslaTower extends PowerTower{

    @Override
    public int getRadius() {
        return 30;
    }

    @Override
    public double getCraftingEnergy() {
        return 2.14;
    }

    @Override
    public HashMap<String, Double> getRecipe() {
        HashMap<String, Double> recipe = new HashMap<>();
        recipe.put("Iron Ignot", 1.0);
        recipe.put("Magnetic Coil", 3.0);
        return recipe;
    }
}
//WirelessPowerTower.java Concrete ProductB3
public class WirelessPowerTower extends PowerTower{

    @Override
    public int getRadius() {
        return 10;
    }

    @Override
    public double getCraftingEnergy() {
        return 26.4;
    }

    @Override
    public HashMap<String, Double> getRecipe() {
        HashMap<String, Double> recipe = new HashMap<>();
        recipe.put("Tesla Tower", 1.0);
        recipe.put("Plasma Exciter", 3.0);
        return recipe;
    }
}
//Main.java Test
public class Main {

    public static void main(String[] args){
        AssemblingTerminal assemblingTerminal = new AssemblingTerminal(AssembingMachineTire.MK2);
        ConveyorBelt conveyorBelt = assemblingTerminal.makeConveyorBelt();
        println(conveyorBelt);
        PowerTower powerTower = assemblingTerminal.makePowerTower();
        println(powerTower);
        assemblingTerminal.setAssemblingMachine(AssembingMachineTire.MK3);
        ConveyorBelt conveyorBelt1 = assemblingTerminal.makeConveyorBelt();
        PowerTower powerTower1 = assemblingTerminal.makePowerTower();
        println(conveyorBelt1);
        println(powerTower1);
    }
    public static void println(Object obj){
        System.out.println(obj);
    }
}
```
```Output
ConveyorBeltMK2 Crafting Energy:3.9
Electromagnetic Turbine/1.0+Conveyor Belt MK.I/3.0+
 Transport Speed:720items/minute
WirelessPowerTower Crafting Energy:26.4
Plasma Exciter/3.0+Tesla Tower/1.0+ 
Radius10
ConveyorBeltMK3 Crafting Energy:12.9
Conveyor Belt MK.II/3.0+Graphene/1.0+Super-Magnetic Ring/1.0+
 Transport Speed:1800items/minute
SatelliteSubstation Crafting Energy:347.0
Wireless Power Tower/1.0+Frame Material/2.0+Super-Magnetic Ring/10.0+ 
Radius100
```