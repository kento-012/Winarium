class FlowField {

  PVector[][] field;
  int cols, rows; // Columns and Rows
  int resolution; // How large is each "cell" of the flow field
  float state;
  float vectorScale;
  PVector spot;
  int fieldNum;

  FlowField(int r, int fieldSelect) {
    resolution = r;
    fieldNum = fieldSelect;
    cols = width/resolution;
    rows = height/resolution;
    field = new PVector[cols][rows];
    state = 1000;
    vectorScale = 2.0;
    spot = new PVector(0.0, 0.0);
    init();
  }

  void init() {
    noiseSeed(10000);
    if (fieldNum == 0) {
      createField0(spot);
    } else if (fieldNum == 1) {
      createField1(spot);
    } else if (fieldNum == 2) {
      createField2(spot);
    } else if (fieldNum == 3) {
      createField3(spot);
    }
  }

  //0番目
  void createField0(PVector s) {
    float angleMin = -20.0;
    float angleMax = 10.0;
    float xoff = 0;
    for (int i = 0; i < cols; i++) {
      float yoff = 0;
      for (int j = 0; j < rows; j++) {
        PVector direction = PVector.sub(new PVector(i*resolution, j*resolution), s);
        float angleNoise = map(noise(xoff, yoff, state), 0, 1, angleMin, angleMax);
        direction.normalize();
        direction.mult(vectorScale);
        direction.rotate(radians(angleNoise));
        field[i][j] = direction;
        yoff += 0.2;
      }
      xoff += 0.2;
    }
  }
  //1番目
  void createField1(PVector s) {
    float xoff = 0;
    for (int i = 0; i < cols; i++) {
      float yoff = 0;
      for (int j = 0; j < rows; j++) {
        float theta = map(noise(xoff, yoff, state), 0, 1, 0, TWO_PI*2);
        field[i][j] = new PVector(cos(theta), sin(theta));
        yoff += 0.1;
      }
      xoff += 0.1;
    }
  }
  //2番目
  void createField2(PVector s) {
    float angleMin = -0.0;
    float angleMax = 120.0;
    float xoff = 0;
    for (int i = 0; i < cols; i++) {
      float yoff = 0;
      for (int j = 0; j < rows; j++) {
        PVector direction = PVector.sub(new PVector(i*resolution, j*resolution), s);
        float angleNoise = map(noise(xoff, yoff, state), 0, 1, angleMin, angleMax);
        direction.normalize();
        direction.mult(vectorScale);
        direction.rotate(radians(angleNoise));
        field[i][j] = direction;
        yoff += 0.5;
      }
      xoff += 0.5;
    }

    //float xoff = 0;
    //for (int i = 0; i < cols; i++) {
    //  float yoff = 0;
    //  for (int j = 0; j < rows; j++) {
    //    float theta = map(noise(xoff, yoff, state), 0, 1, 0, TWO_PI*2);
    //    field[i][j] = new PVector(cos(theta), sin(theta));
    //    yoff += 0.1;
    //  }
    //  xoff += 0.1;
    //}

    //float xoff = 0;
    //for (int i = 0; i < cols; i++) {
    //  float yoff = 0;
    //  for (int j = 0; j < rows; j++) {
    //    field[i][j] = new PVector(0, 0);
    //    yoff += 0.1;
    //  }
    //  xoff += 0.1;
    //}
  }
  //3番目
  void createField3(PVector s) {
    float xoff = 0;
    for (int i = 0; i < cols; i++) {
      float yoff = 0;
      for (int j = 0; j < rows; j++) {
        float theta = map(noise(xoff, yoff, state), 0, 1, 0, TWO_PI*2);
        //field[i][j] = new PVector(cos(theta), sin(theta));
        field[i][j] = new PVector(0, 0);
        yoff += 0.1;
      }
      xoff += 0.1;
    }

    //float angleMin = 180.0;
    //float angleMax = 180.0;
    //float xoff = 0;
    //for (int i = 0; i < cols; i++) {
    //  float yoff = 0;
    //  for (int j = 0; j < rows; j++) {
    //    PVector direction = PVector.sub(new PVector(i*resolution, j*resolution), s);
    //    float angleNoise = map(noise(xoff, yoff, state), 0, 1, angleMin, angleMax);
    //    direction.normalize();
    //    direction.mult(vectorScale);
    //    direction.rotate(radians(angleNoise));
    //    field[i][j] = direction;
    //    yoff += 0.2;
    //  }
    //  xoff += 0.2;
    //}
  }

  void display() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        drawVector(field[i][j], i*resolution, j*resolution, resolution-2);
      }
    }
  }

  void drawVector(PVector v, float x, float y, float scayl) {
    pushMatrix();
    translate(x, y);
    stroke(255, 20);
    rotate(v.heading());
    float len = v.mag()*scayl;
    line(0, 0, len, 0);
    popMatrix();
  }

  PVector lookup(PVector lookup) {
    int column = int(constrain(lookup.x/resolution, 0, cols-1));
    int row = int(constrain(lookup.y/resolution, 0, rows-1));
    return field[column][row].get();
  }
}
