---
title: 生成器模式 - Builder Pattern
author: LeenDenVan
avatar: 'https://avatars.githubusercontent.com/u/16818274?v=4'
authorLink: leendvansland.xyz
categories: 软件设计
comments: true
date: 2021-11-15 08:24:43
authorAbout:
authorDesc:
tags: 
    - 设计模式
    - 创建型模式
keywords:
description:
photos: https://leendvanspics.oss-cn-beijing.aliyuncs.com/pic/87489218_p0_master1200.jpg
---

## 模式定义
> **生成器模式**是一种创建型设计模式， 使你能够分步骤创建复杂对象。 该模式允许你使用相同的创建代码生成不同类型和形式的对象。
> **Builder** is a creational design pattern that lets you construct complex objects step by step. The pattern allows you to produce different types and representations of an object using the same construction code.

## 模式结构

### 模式成员
1. **生成器**（Builder） 接口声明在所有类型生成器中通用的产品构造步骤。
2. **具体生成器** （Concrete Builders） 提供构造过程的不同实现。 具体生成器也可以构造不遵循通用接口的产品。
3. **产品** （Products） 是最终生成的对象。 由不同生成器构造的产品无需属于同一类层次结构或接口。
4. **主管** （Director） 类定义调用构造步骤的顺序， 这样你就可以创建和复用特定的产品配置。
5. **客户端** （Client） 必须将某个生成器对象与主管类关联。 

### 模式类图
![](https://refactoringguru.cn/images/patterns/diagrams/builder/structure-2x.png?id=dca1b1508e23c266cbed)

## Code Example
```java
//BuilingBuilder.java
public interface BuildingBuilder<T extends Building> {
    public BuildingBuilder setModel(String model);
    public BuildingBuilder setName(String name);
    public BuildingBuilder setTexture(String textureName);
    public BuildingBuilder setRecipe(HashMap<String, Integer> recipe);
    public BuildingBuilder addRecipe(String resource, int amount);
    public T build();
}

//Building.java
public abstract class Building {
    protected String name;
    protected String modelName;
    protected String textureName;
    protected HashMap<String, Integer> recipe;
    protected String unlockedTech;
    public abstract BuildingBuilder newBuilder();
    public abstract String getDescription();
}

//PowerGenerator.java
public class PowerGenerator extends Building {

    private double basePowerGeneration;
    private boolean requireInputFuel = false;
    private ArrayList<String> requiredFuel = new ArrayList();
    private String fuelType = "None";

    class PowerGeneratorBuilder implements BuildingBuilder<PowerGenerator>{
        private PowerGenerator powerGenerator;

        public PowerGeneratorBuilder(PowerGenerator powerGenerator){
            this.powerGenerator = powerGenerator;
        }

        @Override
        public PowerGeneratorBuilder setModel(String model) {
            this.powerGenerator.modelName = model;
            return this;
        }

        @Override
        public PowerGeneratorBuilder setName(String name) {
            this.powerGenerator.name = name;
            return this;
        }

        @Override
        public PowerGeneratorBuilder setTexture(String textureName) {
            this.powerGenerator.textureName = textureName;
            return this;
        }

        @Override
        public PowerGeneratorBuilder setRecipe(HashMap<String, Integer> recipe){
            this.powerGenerator.recipe = recipe;
            return this;
        }

        @Override
        public PowerGeneratorBuilder addRecipe(String resource, int amount){
            if(this.powerGenerator.recipe == null){
                this.powerGenerator.recipe = new HashMap<>();
            }
            this.powerGenerator.recipe.put(resource,amount);
            return this;
        }

        public PowerGeneratorBuilder setRequiredFuel(String name){
            this.powerGenerator.requiredFuel.add(name);
            return this;
        }

        public PowerGeneratorBuilder isRequireInputFuel(boolean bool){
            this.powerGenerator.requireInputFuel = bool;
            return this;
        }

        public PowerGeneratorBuilder setFuelType(String fuelType){
            this.powerGenerator.fuelType = fuelType;
            return this;
        }

        public PowerGeneratorBuilder setBaseGeneration(double baseGeneration){
            this.powerGenerator.basePowerGeneration = baseGeneration;
            return this;
        }

        public PowerGeneratorBuilder setUnlockTech(String tech){
            this.powerGenerator.unlockedTech = tech;
            return this;
        }

        @Override
        public PowerGenerator build() {
            return this.powerGenerator;
        }
    }

    @Override
    public PowerGeneratorBuilder newBuilder(){
        return new PowerGeneratorBuilder(this);
    }

    @Override
    public String getDescription() {
        String desc = this.name + " model:"+this.modelName+" texture name:"+this.textureName+" Unlock under:"+this.unlockedTech+"\n";
        for(Map.Entry<String, Integer> entry : this.recipe.entrySet()){
            desc += "  |"+entry.getKey()+" "+entry.getValue()+" \n";
        }
        desc += "PowerGeneration:" + this.basePowerGeneration+"MJ, Fuel Type:"+this.fuelType+" ";
        if(!this.requireInputFuel && !this.requiredFuel.isEmpty())
            for(String s : this.requiredFuel)desc += s +" ";
        return desc;
    }

    @Override
    public String toString(){
        return getDescription();
    }

}

//Client.java
public class Client {
    public PowerGenerator createWindTurbine(){
        return new PowerGenerator().newBuilder()
                .setName("Wind Turbine")
                .setModel("WTmodel.obj")
                .setTexture("WT.png")
                .setBaseGeneration(0.3)
                .setUnlockTech("Electromagnetism")
                .setFuelType("Wind")
                .addRecipe("Iron Ignot", 6)
                .addRecipe("Gear", 1)
                .addRecipe("Magnetic Coil", 3)
                .build();
    }

    public PowerGenerator createSolarPanel(){
        return new PowerGenerator().newBuilder()
                .setName("Solar Panel")
                .setModel("SP.obj")
                .setTexture("SP.png")
                .setBaseGeneration(0.36)
                .setUnlockTech("Solar Collection")
                .setFuelType("Solar Power")
                .addRecipe("Copper Ignot", 10)
                .addRecipe("High-Purity Silicon", 10)
                .addRecipe("Circuit Board", 5)
                .build();
    }

    public PowerGenerator createThermalPowerPlant(){
        return new PowerGenerator().newBuilder()
                .setName("Thermal Power Plant")
                .setModel("TPP.obj")
                .setTexture("TPP.png")
                .setBaseGeneration(2.16)
                .setFuelType("Thermal")
                .setUnlockTech("Thermal Power")
                .setRequiredFuel("Carbon nanotubes")
                .setRequiredFuel("Hydrogen")
                .setRequiredFuel("Deuterium")
                .setRequiredFuel("Fire Ice")
                .setRequiredFuel("Wood")
                .setRequiredFuel("Refined Oil")
                .setRequiredFuel("Diamond")
                .setRequiredFuel("Graphit")
                .setRequiredFuel("Graphene")
                .addRecipe("Iron Ignot", 10)
                .addRecipe("Stone Brick", 4)
                .addRecipe("Gear", 4)
                .addRecipe("Magnetic Coil", 4)
                .isRequireInputFuel(true)
                .build();
    }

    public PowerGenerator createMiniFusionPowerPlant(){
        return new PowerGenerator().newBuilder()
                .setName("Mini Fusion Power Plant")
                .setTexture("MFPP.png")
                .setModel("MFPP.obj")
                .isRequireInputFuel(true)
                .setFuelType("Fusion")
                .setUnlockTech("Mini Fusion Power Generation")
                .setBaseGeneration(15)
                .addRecipe("Titanium Alloy", 12)
                .addRecipe("Super-Magnetic Ring", 10)
                .addRecipe("Carbon Nanotube", 8)
                .addRecipe("Processor", 4)
                .isRequireInputFuel(true)
                .setRequiredFuel("Deuteron Fuel Rod")
                .build();
    }

    public PowerGenerator createRayReceiver(){
        return new PowerGenerator().newBuilder()
                .setName("Ray Receiver")
                .setTexture("RR.png")
                .setModel("RR.obj")
                .setFuelType("Dyson Cloud")
                .setUnlockTech("Ray Receiver")
                .setBaseGeneration(6.00)
                .addRecipe("Steel", 20)
                .addRecipe("High-Purity Silicon", 20)
                .addRecipe("Photon Combiner", 10)
                .addRecipe("Processor", 5)
                .addRecipe("Super-Magnetic", 20)
                .build();
    }

    public PowerGenerator createArtificialStar(){
        return new PowerGenerator().newBuilder()
                .setName("Artificial Star")
                .setModel("AS.obj")
                .setTexture("AS.png")
                .setFuelType("Antimatter")
                .setUnlockTech("Artificial Star")
                .isRequireInputFuel(true)
                .addRecipe("Titanium Alloy", 20)
                .addRecipe("Frame Material", 20)
                .addRecipe("Annhilation Constraint Sphere", 10)
                .addRecipe("Quantum Chip", 10)
                .setBaseGeneration(72)
                .setRequiredFuel("Antimatter Fuel Rod")
                .build();
    }

}
//Main.java
public class Main {

    public static void main(String[] args){
        Client cln = new Client();
        PowerGenerator wind = cln.createWindTurbine();
        PowerGenerator ther = cln.createThermalPowerPlant();
        PowerGenerator sol = cln.createSolarPanel();
        PowerGenerator mfusion = cln.createMiniFusionPowerPlant();
        PowerGenerator arti = cln.createArtificialStar();
        PowerGenerator ray = cln.createRayReceiver();
        println(wind);
        println(ther);
        println(sol);
        println(mfusion);
        println(arti);
        println(ray);
    }
    public static void println(Object obj){
        System.out.println(obj);
    }
}
```

```Output
Wind Turbine model:WTmodel.obj texture name:WT.png Unlock under:Electromagnetism
  |Iron Ignot 6 
  |Gear 1 
  |Magnetic Coil 3 
PowerGeneration:0.3MJ, Fuel Type:Wind 
Thermal Power Plant model:TPP.obj texture name:TPP.png Unlock under:Thermal Power
  |Stone Brick 4 
  |Iron Ignot 10 
  |Gear 4 
  |Magnetic Coil 4 
PowerGeneration:2.16MJ, Fuel Type:Thermal 
Solar Panel model:SP.obj texture name:SP.png Unlock under:Solar Collection
  |Circuit Board 5 
  |Copper Ignot 10 
  |High-Purity Silicon 10 
PowerGeneration:0.36MJ, Fuel Type:Solar Power 
Mini Fusion Power Plant model:MFPP.obj texture name:MFPP.png Unlock under:Mini Fusion Power Generation
  |Processor 4 
  |Titanium Alloy 12 
  |Carbon Nanotube 8 
  |Super-Magnetic Ring 10 
PowerGeneration:15.0MJ, Fuel Type:Fusion 
Artificial Star model:AS.obj texture name:AS.png Unlock under:Artificial Star
  |Annhilation Constraint Sphere 10 
  |Frame Material 20 
  |Quantum Chip 10 
  |Titanium Alloy 20 
PowerGeneration:72.0MJ, Fuel Type:Antimatter 
Ray Receiver model:RR.obj texture name:RR.png Unlock under:Ray Receiver
  |Processor 5 
  |Super-Magnetic 20 
  |High-Purity Silicon 20 
  |Steel 20 
  |Photon Combiner 10 
PowerGeneration:6.0MJ, Fuel Type:Dyson Cloud 
```