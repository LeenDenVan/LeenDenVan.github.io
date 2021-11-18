---
title: Generate and Play sound by wave - Java
author: LeenDenVan
avatar: 'https://avatars.githubusercontent.com/u/16818274?v=4'
authorLink: leendvansland.xyz
categories: Java
comments: true
date: 2021-11-19 00:48:52
authorAbout:
authorDesc:
tags: 杂项
keywords:
description:
photos:
---

Play Touhou Suimusou by sin wave.

```java
package xyz.leendvansland.pkg;

import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.SourceDataLine;

public class Main {
    private static double sampleRate = 198000;
    public static void main(String[] args) {
        final AudioFormat af = new AudioFormat((int)sampleRate, 16, 1, true, true);
        int[] freq = {
                784,932,1047,1245,1397,1245,1397,1568,1245,1047,932,784,1245,1397,1047
        };
        double[] length = {
                1,1,1,1,2,1,1,2,1,1,1,1,1,1,2
        };
        try {
            SourceDataLine line = AudioSystem.getSourceDataLine(af);
            line.open(af);
            line.start();
            //play Frequency = 200 Hz for 1 seconds
            for (int i = 0; i < freq.length; i++){
                play(line, generateSineWavefreq(freq[i], length[i]/2));
            }
            line.drain();
            line.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    private static byte[] generateSineWavefreq(int frequencyOfSignal, double seconds) {
        byte[] sin = new byte[(int) Math.ceil(seconds * sampleRate)];
        double samplingInterval = (double) (sampleRate / frequencyOfSignal);
        System.out.println("Sampling Frequency  : "+sampleRate);
        System.out.println("Frequency of Signal : "+frequencyOfSignal);
        System.out.println("Sampling Interval   : "+samplingInterval);
        for (int i = 0; i < sin.length; i++) {
            double angle = (2.0 * Math.PI * i) / samplingInterval;
            sin[i] = (byte)( (Math.sin(angle)) * 127);
        }
        return sin;
    }
    private static void play(SourceDataLine line, byte[] array) {
        int length = (int)sampleRate * array.length / 1000;
        line.write(array, 0, array.length);
    }
}
```