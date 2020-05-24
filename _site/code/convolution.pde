let img;

const matrix = [ [ 1/9, 1/9, 1/9 ],
                 [ 1/9, 1/9, 1/9 ],
                 [ 1/9, 1/9, 1/9 ] ]; 

function preload() {
  img = loadImage('/data/bird.png');
}

function setup() {
  myCanvas = createCanvas(720, 400);
  img.loadPixels();
  //pixelDensity(1);
  myCanvas.parent('myContainer');
}

function draw() {
  background(img);

  // Calculate the small rectangle we will process
  const matrixsize = 3;

  loadPixels();
  // Begin our loop for every pixel in the smaller image
  for (let x = 1; x < img.width; x++) {
    for (let y = 1; y < img.height; y++ ) {
      let c = convolution(x, y, matrix, matrixsize, img);
      // retrieve the RGBA values from c and update pixels()
      let loc = (x + y * img.width) * 4;
      pixels[loc] = red(c);
      pixels[loc + 1] = green(c);
      pixels[loc + 2] = blue(c);
      pixels[loc + 3] = alpha(c);
    }
  }
  updatePixels();
}

function convolution(x, y, matrix, matrixsize, img) {
  let rtotal = 0.0;
  let gtotal = 0.0;
  let btotal = 0.0;
  const offset = matrixsize;
  for (let i = 0; i < matrixsize; i++){
    for (let j = 0; j < matrixsize; j++){
      let loc = (i + j * img.width) * 4;

      //loc = constrain(loc, 0 , img.pixels.length - 1);

      // Calculate the convolution
      // retrieve RGB values
      rtotal += (img.pixels[loc]) * matrix[i][j];
      gtotal += (img.pixels[loc + 1]) * matrix[i][j];
      btotal += (img.pixels[loc + 2]) * matrix[i][j];
    }
  }
  // Make sure RGB is within range
  rtotal = constrain(rtotal, 0, 255);
  gtotal = constrain(gtotal, 0, 255);
  btotal = constrain(btotal, 0, 255);
  
  // Return the resulting color
  return color(rtotal, gtotal, btotal);
} 