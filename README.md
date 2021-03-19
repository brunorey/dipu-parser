# dipu-parser

## Descripción

Un parser muy sencillo hecho para correr sobre la página de la Honorable Cámara de Diputados Nacionales (HCDN): https://www.hcdn.gob.ar/diputados/listadip.html

Para un proyecto de incidencia política de una ONG se necesitaba obtener la lista de proyectos presentado por cada diputado con el fin de saber cuáles podían estar interesados en el tema a tratar. Esta información no estaba disponible en la [interfaz de datos abiertos de HCDN](https://datos.hcdn.gob.ar/dataset). Para obtenerla creé un script (muy rudimentario) en bash que obtiene la lista de diputados, por cada uno navega las páginas de proyectos presentados y junta toda la información en una tabla simple de HTML.

Esta información puede ser copiada para luego ser pegada en una hoja de cálculo (google sheets, excel, etc).

Lo hice en bash porque lo escribí durante mis vacaciones y al momento de hacerlo no tenía acceso a una computadora con un entorno de desarrollo instalado. Con esta solución sencilla pude obtener los datos que necesitaba.

## Screenshots

### Ejemplo de las páginas

#### Lista de diputados
https://www.hcdn.gob.ar/diputados/listadip.html
<img width="816" alt="image" src="https://user-images.githubusercontent.com/10224603/111819625-53bda280-88bf-11eb-8ea9-93078cfa7581.png">

#### Proyectos de un diputado
https://www.hcdn.gob.ar/diputados/marce/listadodeproy.html?pagina=13
<img width="905" alt="image" src="https://user-images.githubusercontent.com/10224603/111819580-430d2c80-88bf-11eb-857f-5930fa7b4d58.png">

### Ejemplo de los datos producidos

<img width="1679" alt="image" src="https://user-images.githubusercontent.com/10224603/111819899-a1d2a600-88bf-11eb-97a6-6cdf5f0efd9c.png">

<img width="1144" alt="image" src="https://user-images.githubusercontent.com/10224603/111819973-b616a300-88bf-11eb-8447-2e28285541b6.png">
