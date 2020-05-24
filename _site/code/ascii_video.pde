let playing = false;
let simpson;
let button;
let ascii = [];
let resolution = 7;
let fontsize = 12;

function setup() {
  myCanvas = createCanvas(506, 240);
  myCanvas.parent('myContainer');
  let letters = "@&%#*vi<>+=^;,:'. ";
  simpson = createVideo(['/data/homero.mov', '/data/homero.webm']);
  //simpson.setAttribute('crossOrigin', '');

  for (let i = 0; i < 256; i++) {
    let index = int(map(i, 0, 256, 0, letters.length));
    ascii[i] = letters[index];
  }
  button = createButton('play');
  button.mousePressed(toggleVid);
  button.parent('btn');
  noStroke();
  fill(0);
}

function toggleVid() {
  if (playing) {
    simpson.pause();
    button.html('play');
  } else {
    simpson.loop();
    button.html('pause');
  }
  playing = !playing;
}

function draw() {
  simpson.parent('video'); 
  background(255);
  simpson.loadPixels();
  for (let y = 0; y < height; y += resolution) {
    for (let x = 0; x < width; x += resolution) {
      let index = (x + y * simpson.width) * 4
      let r = simpson.pixels[index + 0];
      let g = simpson.pixels[index + 1];
      let b = simpson.pixels[index + 2];
      let brig = (r+g+b)/3
      text(ascii[int(brig)], x, y);
    }
  }
}