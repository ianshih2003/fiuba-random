![](https://i.imgur.com/P0aqOMI.jpg)

# **Ejercicio 03 - Numeros**

| Nombre y apellido:                  | Numero de padron | Correo electronico  |
| ----------------------------------- | ---------------- | ------------------- |
| Manuel Sanchez Fernandez de la Vega | 107951           | msanchezf@fi.uba.ar |
| Ian Shih                            | 108349           | ishih@fi.uba.ar     |

## Aporte de los mensajes de DD
*En un double dispatch (DD), ¿qué información aporta cada uno de los dos llamados?*

El primer llamado nos dice de qué clase es el objeto número a la izquierda de una operación. Por el otro lado, el segundo llamado nos dice cómo se relacionan este objeto número previamente mencionado con el objeto número de la derecha. Es decir, como se procede según la clase X del objeto de la derecha, sabiendo que el objeto de la izquierda es de cierta clase Y.

## Lógica de instanciado
*Con lo que vieron y saben hasta ahora, ¿donde les parece mejor tener la lógica de cómo instanciar un objeto? ¿por qué? ¿Y si se crea ese objeto desde diferentes lugares y de diferentes formas? ¿cómo lo resuelven?*

La lógica sobre cómo instanciar un objeto debería estar en un método de inicialización de la clase del objeto. Este método define los valores iniciales de los colaboradores del objeto y se ejecuta cada vez que creamos un objeto nuevo. Esto lo hacemos con el fin de no romper encapsulamiento, evitar crear setters y tener que usarlos cada vez que creamos un objeto.

Si se creara desde diferentes lugares y de diferentes formas, lo que haríamos sería realizar subclases por cada una de las diferentes formas en las que se crea el objeto, creando así objetos “polimórficos”.

## Nombres de las categorías de métodos
*Con lo que vieron y trabajaron hasta ahora, ¿qué criterio están usando para categorizar métodos?*

Si un método debería ser únicamente llamado por otros métodos de nuestra clase, es decir, que no sea accesible al usuario, lo categorizamos como un método privado. Luego, si tenemos un método que el usuario puede utilizar tranquilamente, lo categorizamos como público.

Aparte de esto, categorizamos a los métodos según su función. En otras palabras, terminamos con una clasificación doble, en la que las categorías se ven algo como:

```
Proposito - Acceso
```

Donde el propósito es la función de los métodos dentro de la categoría (qué acción realizan en líneas generales) y el acceso es si son públicos o privados. Aquellos que no tienen definido el acceso, los consideramos públicos.

## Subclass Responsibility
*Si todas las subclases saben responder un mismo mensaje, ¿por qué ponemos ese mensaje sólo con un “self subclassResponsibility” en la superclase? ¿para qué sirve?*

Cada subclase puede responder de forma distinta al mensaje. En consecuencia, no tiene sentido realizar una generalización por lo que el método de la superclase dice algo como “esto es responsabilidad de la subclase”. Básicamente, delega el comportamiento del método a la subclase.

Asimismo, si estuviéramos desarrollando una subclase y de casualidad nos olvidamos de implementar un método polimórfico, al correr los tests, nos encontramos con un error que dice algo como:

```smalltalk
Error: my subclass should have overridden #nombreDelMetodo
```

Que quiere decir que la subclase tenía la responsabilidad de definir el comportamiento del método pero no lo hizo.

## No rompas
*¿Por qué está mal/qué problemas trae romper encapsulamiento?*

Encapsulamiento es una buena práctica que nos ayuda a preservar el código, haciendo que este sea más sencillo de comprender, y en consecuencia, mantener. Asimismo, permite que el usuario, al usar los objetos, deje de tener en cuenta el “cómo” y se centre en el “que”.

Por lo contrario, si rompieramos encapsulamiento, el estado de cada objeto se vuelve más impredecible haciéndolo vulnerable a cambios inesperados. Esto trae consecuencias en todo el código haciendo que no funcione correctamente. También, esto trae consigo una dificultad más elevada al debuggear ya que se hace más difícil seguirle el flujo al código.


