package ru.d9k.example;
import processing.core.*;

/**
 * Created by d9k on 5/21/15.
 */
public class ProcessingExample extends PApplet{

    public void setup(){
        size(400, 400);
        background(0);
    }

    public void draw(){
        stroke(255);
        if (mousePressed) {
            line(mouseX, mouseY, pmouseX, pmouseY);
        }
    }
}
