---
title: Convertir video a Ascii
layout: page
meta-title: Convertir video a Ascii
tags: [p5.js, javascript, ascii]
---

<div id="sketch-holder"></div>

Este es el código utilizado para este ejercicio.

---

<script src="https://cdnjs.cloudflare.com/ajax/libs/p5.js/1.0.0/p5.js"></script>

<script>
let sel;
let img;
let img2;
let out;
let v = 1.0 / 9.0;
let kernel = [[ v, v, v ], [ v, v, v ], [ v, v, v ]]

function setup() {
  img = loadImage('../data/bird.png');
  img2 = loadImage('../data/bird.png');
  createCanvas(890, 261);
  textAlign(CENTER);
  background(240);
  sel = createSelect();
  sel.position(500, 1500);
  sel.option('Escala de grises');
  sel.option('Blur');
  sel.option('Ascii');
  sel.selected('Sharpen');
  sel.changed(mySelectEvent);
}

function draw(){
  image(img, 445, 0);
  
}

function mySelectEvent() {
  let item = sel.value();
  background(250);
  if(item == 'Blur'){
   blur();
  }
  if(item == 'Escala de grises'){
   w_and_b();
   image(out, 0, 0);
  }
  if(item == 'Ascii'){
   ascii();
  }
}

function blur (){
  out = img2;
  out.loadPixels();
  
  for (let x = 1; x < img.width; x++) {
    for (let y = 1; y < img.height; y++) {
      let sum = 0; 
      for (kx = -1; kx <= 1; kx++) {
        for (ky = -1; ky <= 1; ky++) {
          let xpos = x + kx;
          let ypos = y + ky;
          let val = red(img.get(xpos, ypos));
          sum += kernel[kx+1][ky+1] * val;
        }
      }
      out.set(x, y, color(sum));
    }
  }
  out.updatePixels();
}


function w_and_b(){
  out = img2;
  out.loadPixels();
  for (let x = 1; x < out.width; x++) {
    for (let y = 1; y < out.height; y++) {
      let index = (x + y * out.width) * 4
      let r = out.pixels[index + 0];
      let g = out.pixels[index + 1];
      let b = out.pixels[index + 2];
      let sum = (r + g + b)/3; 
      out.set(x, y, color(sum, sum, sum));
    }
  }
  out.updatePixels();
}

function ascii(){
  let ascii = [];
  let resolution = 7;  
  let letters = "@&%#*vi<>+=^;,:'. ";
  for (let i = 0; i < 256; i++) {
    let index = int(map(i, 0, 256, 0, letters.length));
    ascii[i] = letters[index];
  }
  out = img2;
  out.loadPixels();
  for (let y = 0; y < out.height; y += resolution) {
    for (let x = 0; x < out.width; x += resolution) {
      let index = (x + y * out.width) * 4
      let r = out.pixels[index + 0];
      let g = out.pixels[index + 1];
      let b = out.pixels[index + 2];
      let brig = (r+g+b)/3
      text(ascii[int(brig)], x, y);
    }
  }
}
</script>

---

```javascript
let sel;
let img;
let img2;
let out;
let v = 1.0 / 9.0;
let kernel = [[ v, v, v ], [ v, v, v ], [ v, v, v ]]

function setup() {
  img = loadImage('../data/bird.png');
  img2 = loadImage('../data/bird.png');
  createCanvas(890, 261);
  textAlign(CENTER);
  background(240);
  sel = createSelect();
  sel.position(500, 1500);
  sel.option('Escala de grises');
  sel.option('Blur');
  sel.option('Ascii');
  sel.selected('Sharpen');
  sel.changed(mySelectEvent);
}

function draw(){
  image(img, 445, 0);
  
}

function mySelectEvent() {
  let item = sel.value();
  background(250);
  if(item == 'Blur'){
   blur();
  }
  if(item == 'Escala de grises'){
   w_and_b();
   image(out, 0, 0);
  }
  if(item == 'Ascii'){
   ascii();
  }
}

function blur (){
  out = img2;
  out.loadPixels();
  
  for (let x = 1; x < img.width; x++) {
    for (let y = 1; y < img.height; y++) {
      let sum = 0; 
      for (kx = -1; kx <= 1; kx++) {
        for (ky = -1; ky <= 1; ky++) {
          let xpos = x + kx;
          let ypos = y + ky;
          let val = red(img.get(xpos, ypos));
          sum += kernel[kx+1][ky+1] * val;
        }
      }
      out.set(x, y, color(sum));
    }
  }
  out.updatePixels();
}


function w_and_b(){
  out = img2;
  out.loadPixels();
  for (let x = 1; x < out.width; x++) {
    for (let y = 1; y < out.height; y++) {
      let index = (x + y * out.width) * 4
      let r = out.pixels[index + 0];
      let g = out.pixels[index + 1];
      let b = out.pixels[index + 2];
      let sum = (r + g + b)/3; 
      out.set(x, y, color(sum, sum, sum));
    }
  }
  out.updatePixels();
}

function ascii(){
  let ascii = [];
  let resolution = 7;  
  let letters = "@&%#*vi<>+=^;,:'. ";
  for (let i = 0; i < 256; i++) {
    let index = int(map(i, 0, 256, 0, letters.length));
    ascii[i] = letters[index];
  }
  out = img2;
  out.loadPixels();
  for (let y = 0; y < out.height; y += resolution) {
    for (let x = 0; x < out.width; x += resolution) {
      let index = (x + y * out.width) * 4
      let r = out.pixels[index + 0];
      let g = out.pixels[index + 1];
      let b = out.pixels[index + 2];
      let brig = (r+g+b)/3
      text(ascii[int(brig)], x, y);
    }
  }
}
```

---