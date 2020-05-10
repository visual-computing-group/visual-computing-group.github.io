---
title: Convertir video a Ascii
layout: page
meta-title: Convertir video a Ascii
tags: [p5.js, javascript, ascii]
---

<div id="sketch-holder"></div>

En este ejemplo se convierte un video a ascii

Este es el código utilizado para este ejercicio.

---

<script src="https://cdnjs.cloudflare.com/ajax/libs/p5.js/1.0.0/p5.js"></script>

<script>
let playing = false;
let fingers;
let button;
let ascii = [];
let resolution = 7;
let fontsize = 12;

function setup() {
  createCanvas(503, 238);
  // especifica múltples formatos para distintos navegadores
  //textSize(fontsize);
  let letters = "@&%#*vi<>+=^;,:'. ";//" .`-_':,;^=+/\"|)\\<>)iv%xclrs{*}I?!][1taeo7zjLu" +
  //"nT#JCwfy325Fp6mqSghVd4EgXPGZbYkOA&8U$@";
  fingers = createVideo(['../data/homero.mov', '../data/homero.webm']);
  for (let i = 0; i < 256; i++) {
    let index = int(map(i, 0, 256, 0, letters.length));
    ascii[i] = letters[index];
  }
  //console.log(ascii)
  button = createButton('play');
  button.mousePressed(toggleVid);
  //fingers.loop();
  noStroke();
  fill(0);
}

function toggleVid() {
  if (playing) {
    fingers.pause();
    button.html('play');
  } else {
    fingers.loop();
    button.html('pause');
  }
  playing = !playing;
}

function draw() {
  background(255);
  fingers.loadPixels();
  for (let y = 0; y < height; y += resolution) {
    for (let x = 0; x < width; x += resolution) {
      let index = (x + y * fingers.width) * 4
      let r = fingers.pixels[index + 0];
      let g = fingers.pixels[index + 1];
      let b = fingers.pixels[index + 2];
      let brig = (r+g+b)/3
      text(ascii[int(brig)], x, y);
    }
  }
}
</script>

---

```javascript
let playing = false;
let fingers;
let button;
let ascii = [];
let resolution = 7;
let fontsize = 12;

function setup() {
  createCanvas(599, 317);
  // especifica múltples formatos para distintos navegadores
  //textSize(fontsize);
  let letters = " .`-_':,;^=+/\"|)\\<>)iv%xclrs{*}I?!][1taeo7zjLu" +
  "nT#JCwfy325Fp6mqSghVd4EgXPGZbYkOA&8U$@";
  fingers = createVideo(['../data/pixar.mov', '../data/pixar.webm']);
  for (let i = 0; i < 256; i++) {
    let index = int(map(i, 0, 256, 0, letters.length));
    //console.log(int(abs(index)));
    ascii[255-i] = letters[index];
  }
  //console.log(ascii)
  button = createButton('play');
  button.mousePressed(toggleVid);
  //fingers.loop();
  noStroke();
  fill(0);

}

function toggleVid() {
  if (playing) {
    fingers.pause();
    button.html('play');
  } else {
    fingers.loop();
    button.html('pause');
  }
  playing = !playing;
}

function draw() {
  background(255);
  fingers.loadPixels();
  for (let y = 0; y < height; y += resolution) {
    for (let x = 0; x < width; x += resolution) {
      let index = (x + y * fingers.width) * 4
      let r = fingers.pixels[index + 0];
      let g = fingers.pixels[index + 1];
      let b = fingers.pixels[index + 2];
      let brig = (r+g+b)/3
      text(ascii[int(brig)], x, y);
    }
  }
}
```

---