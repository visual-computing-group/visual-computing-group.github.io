let img;
let w = 80;
let sel;
let original;
let matrixsize = 3;

// It's possible to convolve the image with many different 
// matrices to produce different effects. This is a high-pass 
// filter; it accentuates the edges. 
let v = 1/9;
let matrix = [ 
              [ 0, 0, 0 ],
              [ 0, 1, 0 ],
              [ 0, 0, 0 ] 
            ]; 

function preload() {
  img = loadImage('/data/bird.png');
}

function setup() {
  myCanvas = createCanvas(445, 261);
  background(img);
  myCanvas.parent('myContainer');
  sel = createSelect();
  sel.parent('btn');
  sel.option('Identity');
  sel.option('Sharpen');
  sel.option('Box blur');
  sel.option('Gaussian blur 3 × 3');
  sel.option('Gaussian blur 5 × 5');
  sel.option('Edge detection');
  sel.selected('Identity');
  sel.changed(mySelectEvent);
  img.loadPixels();

  // pixelDensity(1) for not scaling pixel density to display density
  // for more information, check the reference of pixelDensity()
  //pixelDensity(1);
}

function mySelectEvent() {
  let item = sel.value();
  if(item == 'Identity'){
    matrixsize = 3;
    matrix = [ 
              [ 0, 0, 0 ],
              [ 0, 1, 0 ],
              [ 0, 0, 0 ] 
            ]; 
  }
  if(item == 'Edge detection'){
    matrixsize = 3;
    matrix = [ 
              [ 1, 0, -1 ],
              [ 0, 0, 0 ],
              [ -1, 0, 1 ] 
            ];
  }
  if(item == 'Gaussian blur 3 × 3'){
    v= 1/16
    matrixsize = 3;
    matrix = [ 
              [ v*1, v*2, v*1 ],
              [ v*2, v*4, v*2 ],
              [ v*1, v*2, v*1 ] 
            ];
  }
  if(item == 'Gaussian blur 5 × 5'){
    v= 1/256
    matrixsize = 5;
    matrix = [ 
              [ v*1, v*4, v*6, v*4, v*1 ],
              [ v*4, v*16, v*24, v*16, v*4 ],
              [ v*6, v*24, v*36,v*24, v*6 ],
              [ v*4, v*16, v*24, v*16, v*4 ],
              [ v*1, v*4, v*6,v*4, v*1 ]
            ];
  }
  if(item == 'Sharpen'){
    v= 1/16
    matrixsize = 3;
    matrix = [ 
              [ 0, -1, 0 ],
              [ -1, 5, -1 ],
              [ 0, -1, 0 ] 
            ];
  }
  if(item == 'Box blur'){
    v= 1/9
    matrixsize = 3;
    matrix = [ 
              [ v, v, v ],
              [ v, v, v ],
              [ v, v, v ]
            ];
  }

}

function draw() {
  original = loadImage('/data/bird.png');
  //original.parent('video');
  // We're only going to process a portion of the image
  // so let's set the whole image as the background first

  //image(img, width/2 , 0);
  //image(original, 0, 0, img.height / 2);

  // Calculate the small rectangle we will process
  
  loadPixels();
  // Begin our loop for every pixel in the smaller image
  for (let x = 1; x < img.width; x++) {
    for (let y = 1; y < img.height; y++ ) {
      let c = convolution(x, y, matrix, matrixsize, img);
      
      // retrieve the RGBA values from c and update pixels()
      let loc = (x + y*img.width) * 4;
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
  const offset = Math.floor(matrixsize / 2);
  for (let i = 0; i < matrixsize; i++){
    for (let j = 0; j < matrixsize; j++){
      
      // What pixel are we testing
      const xloc = (x + i - offset);
      const yloc = (y + j - offset);
      let loc = (xloc + img.width * yloc) * 4;

      // Make sure we haven't walked off our image, we could do better here
      loc = constrain(loc, 0 , img.pixels.length - 1);

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