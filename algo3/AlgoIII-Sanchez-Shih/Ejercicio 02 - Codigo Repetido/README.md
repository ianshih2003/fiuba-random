![](https://i.imgur.com/P0aqOMI.jpg)

# **Ejercicio 02 - Codigo Repetido**

| Nombre y apellido:                  | Numero de padron | Correo electronico  |
| ----------------------------------- | ---------------- | ------------------- |
| Manuel Sanchez Fernandez de la Vega | 107951           | msanchezf@fi.uba.ar |
| Ian Shih                            | 108349           | ishih@fi.uba.ar     |

## Abstracción de los tests 01 y 02
*En los test 01 y 02 hay código repetido. Cuando lo extrajeron crearon algo nuevo. Eso es algo que estaba en la realidad y no estaba representado en nuestro código, por eso teníamos código repetido. ¿Cuál es esa entidad de la realidad que crearon?*

El ente que creamos y previamente no estaba representado es un cronómetro o algún tipo de herramienta que permita medir la duración de un evento. Esto se debe a que ambos tests tienen en cuenta la duración temporal.

## Cómo representar en Smalltalk
*¿Cuáles son las formas en que podemos representar entes de la realidad en Smalltalk que conocés? Es decir, ¿qué cosas del lenguaje Smalltalk puedo usar para representar entidades de la realidad?*

Las representaciones de entes de la realidad en smalltalk consisten de:
- Objetos: Representan a los entes concretos de la realidad.
- Clases: Representan conceptos o ideas abstractas en Smalltalk


## Teoría de Naur
*¿Qué relación hay entre sacar código repetido (creando abstracciones) y la teoría del modelo/sistema (del paper de Naur)?*

Poder sacar código repetido implica tener conocimiento de todos los objetos creados, si no tenemos la teoría del sistema que queremos modelar, vamos a reescribir métodos que el programador que tenía la teoría ya escribió lo que produce código repetido. Es decir, para generar abstracciones adecuadas, es necesario disponer de la teoría del sistema. Es muy difícil realizar las abstracciones desconociendo cómo se comporta el sistema en su totalidad.

Asimismo, al quitar código repetido, se simplifica la comprensión del mismo. Consecuentemente, es más sencillo transmitir la teoría del modelo a nuevos programadores.