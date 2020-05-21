Tecnológico de Costa Rica
Introducción al Reconocimiento de Ratrones
Proyecto 1: Redes neuronales artificiales y el algoritmo de retropropagación.

************************************************************************************************************************************************************************************************************************************************************************

Equipo Arajo:
Óscar Andrés Arias Cruz - 2016004986
Jung Hwan Bak - 2016193299
Hamlet Loría Mesén - 2016185336
Daniel Rojas Marín - 2016089821

************************************************************************************************************************************************************************************************************************************************************************

Descripción de la ejecución predeterminada:
Entrenamiento, validación y gráficación de los resultados de una red neuronal con:
Set de entrenamiento de 1000 muestras con 5 clases en su salida, con representación de pie curveado..
Tres capas ocultas de 16 neuronas con función de activación Leaky ReLU y capa de salida con función de activación sigmoide.
Capa con cálculo de error caudrático.
Técnica de descenso de gradiente con momento con parámetro de inercia de 0.06.
Ejecución de 2000 épocas de entrenamiento en total, con una condición de parada cuando el error se menor a 0.03.
Tamaño de minilotes de 10 muestras.
Taza de aprendizaje Alpha de 0.01.
Set de validación de 400 muestras.

************************************************************************************************************************************************************************************************************************************************************************

Para realizar la ejecución predeterminada:
1.Ejecute Octave.
2.Ubíquese en el repositorio del proyecto.
3.Escriba el comando "main" en la ventana de comandos.
4.Se imprimirán los valores de error de las épocas mientras se realice el entrenamiento.
5.Una vez finalizado el entrenamiento se graficaran 4 figuras:
	Figura 1: Muestra los datos del set de entrenamiento con sus cursores representativos de cada clase.
	Figura 2: Muestra los espacios pintados del color representativo de cada clase según sea la ganadora en cada punto.
	Figura 3: Muestra los espacios pintados del color representativo de cada clase variando la intensidad según la probabilidad de estas en cada punto.
	Figura 4: Muestra la curva de aprendizaje de la red con el error respecto al número de épocas ejecutadas.

************************************************************************************************************************************************************************************************************************************************************************

Para editar set de entrenamiento y validación:
1.Ejecute el GUI de Octave.
2.Ubíquese en el directorio del proyecto.
3.Abra el archivo "main.m".
4.Para cambiar el número de muestras del set de entrenamiento edite la variable "n".
5.Para cambiar el número de clases del set de entrenamiento edite la variable "c".
6.Para cambiar la forma de las muetras del set de entrenamiento edite la variable "forma".
7.Para cambiar el número de muestras del set de validación edite la variable "datosval".

************************************************************************************************************************************************************************************************************************************************************************

Para editar la estructura de la red neuronal:
1.Ejecute el GUI de Octave.
2.Ubíquese en el directorio del proyecto.
3.Abra el archivo "model.m".
4.Para cambiar el número de neuronas en las capas escondidas 1, 2 y 3, edite las variables "hiddenNeurons1", "hiddenNeurons2" y "hiddenNeurons3" respectivamente.
5.Para cambiar el número de épocas de entrenamiento edite la variable "nEpochs".
6.Para cambiar el número de muestras por minilote edite la variable "MLSize".
7.Para cambiar la taza de aprendizaje edite la variable "alpha".
8.Para cambiar el factor de inercia edite la variable "bet".
9.Para cambiar la función de activación de las capas ocultas y de salida, vaya a la sección "Layers", comente la declaración de la capa de activación actual "l1b", "l2b", "l3bb" o "l4b" que quiera cambiar y descomente la que posea la función de activación deseada.
10.Para cambiar la función de error de la capa de cálculo de error, vaya a la sección "Layers", comente la declaración de la capa de cálculo de error actual "J" que quiere cambiar y descomente la que posea la función de error deseada.
11.Para cambiar la técnica de optimización de la minimización del error vaya a la sección "Backprop.", comente la asignación actual del cálculo de los pesos "W1", "W2", "W3" y "W4" que quiera cambiar y descomente la que posea la técnica deseada.

************************************************************************************************************************************************************************************************************************************************************************



