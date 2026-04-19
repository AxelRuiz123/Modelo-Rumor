int columnas, filas;
int resolucion = 15;
int[][] poblacion;


float B = 0.4; // probabilidad base de contagio por vecino chismoso
float G = 0.2; // probabilidad de volverse no chismoso

boolean pausado = false;

color colorIgnorante  = color(46, 204, 113);  // Verde (Ignorante)
color colorChismoso   = color(231, 76, 60);   // Rojo  (Chismoso)
color colorNoChismoso = color(52, 152, 219);  // Azul  (No chismoso)

void setup() {
  size(1800, 1800); 
  
  columnas = width / resolucion;
  filas = height / resolucion;
  poblacion = new int[columnas][filas];
  
  for (int i = 0; i < columnas; i++) {
    for (int j = 0; j < filas; j++) {
      poblacion[i][j] = 0;
    }
  }
}

void draw() {
  background(30, 35, 40);

  for (int i = 0; i < columnas; i++) {
    for (int j = 0; j < filas; j++) {
      int x = i * resolucion;
      int y = j * resolucion;

      color colorActual;
      if (poblacion[i][j] == 1) {
        colorActual = colorChismoso;
      }
      
      else if (poblacion[i][j] == 2) { 
        colorActual = colorNoChismoso;
      }
      
      else {
        colorActual = colorIgnorante;
      }

      dibujarPersona(x, y, resolucion, colorActual);
    }
  }

  if (!pausado) aplicarReglas();
}


// Reglas
void aplicarReglas() {
  int[][] siguiente = new int[columnas][filas];

  for (int i = 0; i < columnas; i++) {
    for (int j = 0; j < filas; j++) {
      int estado = poblacion[i][j];

      // Estados absorbentes
      if (estado == 1 || estado == 2) {
        siguiente[i][j] = estado;
        continue;
      }

      // Ignorante
      int n = 0;
      for (int di = -1; di <= 1; di++) {
        for (int dj = -1; dj <= 1; dj++) {
          if (di == 0 && dj == 0) {
            continue;
          }
          
          int ni = i + di;
          int nj = j + dj;
          
          if (ni < 0 || ni >= columnas || nj < 0 || nj >= filas) {
            continue;
          }
          
          if (poblacion[ni][nj] == 1)  {
            n++;
          }
        }
      }

      // permanece ignorante
      if (n == 0) {
        siguiente[i][j] = 0;
        continue;
      }

      // P(0→1) = 1-(1-B)^n
      float probChismoso = 1.0 - pow(1.0 - B, n);
      if (random(1) < probChismoso) {
        siguiente[i][j] = 1;
      } else if (random(1) < G) {
        siguiente[i][j] = 2;
      } else {
        siguiente[i][j] = 0;
      }
    }
  }

  poblacion = siguiente;
}


void dibujarPersona(float x, float y, float tamano, color c) {
  fill(c);
  noStroke();
  
  // Proporciones para la cabeza y el cuerpo
  float tamanoCabeza = tamano * 0.4;
  float anchoCuerpo = tamano * 0.7;
  float altoCuerpo = tamano * 0.5;
  
  // Posición ajustada para centrar en la celda
  float centroX = x + tamano / 2;
  float centroY = y + tamano / 2;
  
  // Dibujar la cabeza (círculo superior)
  ellipse(centroX, centroY - tamano*0.15, tamanoCabeza, tamanoCabeza);
  
  // Dibujar el cuerpo (un semicírculo o arco en la parte inferior)
  arc(centroX, centroY + tamano*0.3, anchoCuerpo, altoCuerpo, PI, TWO_PI);
}

void mouseDragged() { 
  iniciarRumor(); 
}



void iniciarRumor() {
  int i = floor(mouseX / resolucion);
  int j = floor(mouseY / resolucion);
  if (i >= 0 && i < columnas && j >= 0 && j < filas) {
    poblacion[i][j] = 1;
  }
}

void keyPressed() {
  if (key == ' ') 
  {
    pausado = !pausado;
  }
  
  if (key == 'r') {
    for (int i = 0; i < columnas; i++)
      for (int j = 0; j < filas; j++)
        poblacion[i][j] = 0;
    pausado = false;
  }
}
