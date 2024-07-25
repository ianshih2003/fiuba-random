# TP: malloc

## Desarrollo del proyecto 

Al comenzar el trabajo, decidimos empezar por las funcionalidades más pequeñas y no modificar demasiado el esqueleto. Comenzamos utilizando la lista de regiones proporcionada por la cátedra para almacenar las regiones de un único bloque. 

La primer funcionalidad implementada fue la búsqueda de regiones libres mediante first_fit. Al comenzar con un solo bloque, no nos fue difícil la implementación.

Seguimos con la implementación de *splitting* luego de hacer malloc(), la cual nos permitió hacer un mejor uso de las regiones al pedir memoria. También modificamos el esqueleto en la función grow_heap() reemplazando la forma de pedir memoria por mmap(). Luego, agregamos soporte para implementar *coalescing,* después de liberar una región.

A medida que avanzábamos, creábamos tests para verificar que todo funcionara como esperábamos. En este punto surgió la necesidad de agregar más estadísticas (cantidad de memoria mapeada, cantidad de memoria liberada, cantidad de regiones creadas, etc) para chequear varios casos de prueba. 

Habiendo agregado soporte de las funcionalidades de la parte 1, tuvimos que pensar una estructura para guardar las regiones en un bloque (por el momento sólo utilizábamos la lista de regiones provista por el esqueleto), que fuera escalable para almacenar varios bloques a la vez. Hicimos una modificación importante de las estructuras que teníamos hasta el momento, agregando nuevos campos a la estructura de región, ya que ahora debía tener una referencia al bloque en la cual la misma estaba creada. Decidimos implementar una estructura **bloque** que tenga referencia a una lista de regiones pertenecientes al mismo. Para almacenar cada bloque, creamos una lista de bloques para tener una buena administración de los mismos.

Para implementar la segunda parte tuvimos que realizar algunos ajustes sobre las implementaciones de *split_region,* *coalesce_region* y *free* principalmente, ya que debíamos tener en cuenta los múltiples bloques, y actualizar la *block_list* cuando fuera necesario. También modificamos la función de first_fit para buscar regiones en más de un bloque.

La parte 3 del trabajo no tuvo mayores dificultades; la implementación de best_fit no fue muy diferente a first_fit. Por otro lado, calloc() nos resultó la función más sencilla y al utilizar malloc() por debajo, no fue complicado. 

La última función implementada fue realloc(). Si bien utiliza malloc() por debajo al igual que calloc(), tuvimos que contemplar varios casos borde antes de realocar la data actual en otra dirección de memoria, ya que podía suceder que no fuera necesario crear una nueva región para almacenar el nuevo tamaño requerido por el usuario. 

Una vez creadas todas las funciones principales, nos dedicamos a testear varios casos no contemplados anteriormente y ajustar las funcionalidades en base a los resultados de los tests. 

---

## Estructura final del trabajo
Nuestra versión final del trabajo soporta el manejo de un heap administrado por múltiples bloques de tres tamaños distintos, con dos estrategias de búsqueda de regiones libres. Las estructuras finales utilizadas para la implementación del proyecto son:
- Región: 
  - Referencias a la región anterior y a la siguiente: Nos facilita el coalescing al evitar la iteracion de todo la lista de regiones.
  - Referencia al bloque al cual pertence: Para poder liberar un bloque si es la region es la unica dentro de un bloque.
  - Booleano que nos dice si esta libre.
- Bloque:
  - Referencias al bloque anterior y al siguiente.
  - Referencia a la primer región contenida en ese bloque.
- Lista de bloques: 
  - Referencia al primer y último bloque contenido en la lista: Nos permite soportar varios bloques dentro del malloc.

Definimos 3 listas estaticas dentro del malloc, una para cada tipo de tamaño de bloque, esto nos permitia poder buscar la region libre en los bloques mas pequeños y luego en los bloques mas grandes.


---

## Conclusiones

En conclusión, el trabajo nos pareció una buena forma de aprender cómo se implementa un *heap* y cómo la librería estandar de C administra internamente la memoria.

