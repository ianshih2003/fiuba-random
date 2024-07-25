def maximizarGanancias(estaciones, facturaciones):
    n = len(estaciones)
    ganancias = [0] * n
    estaciones_elegidas = [[] for _ in range(n)]

    ganancias[0] = facturaciones[0]
    estaciones_elegidas[0] = [estaciones[0]]

    for i in range(1, n):
        ganancia_elegir_estacion = facturaciones[i]
        ganancia_no_elegir_estacion = ganancias[i-1]

        if i >= 2:
            ganancia_elegir_estacion += ganancias[i-2]

        if ganancia_elegir_estacion > ganancia_no_elegir_estacion:
            ganancias[i] = ganancia_elegir_estacion
            estaciones_elegidas[i] = estaciones_elegidas[i-2] + [estaciones[i]]
        else:
            ganancias[i] = ganancia_no_elegir_estacion
            estaciones_elegidas[i] = estaciones_elegidas[i-1]

    return estaciones_elegidas[-1]

# Ejemplo de uso:
estaciones = ["Estación A", "Estación B", "Estación C", "Estación D", "Estación E"]
facturaciones = [100, 200, 150, 300, 250]

estaciones_elegidas = maximizarGanancias(estaciones, facturaciones)
print("Estaciones elegidas para maximizar ganancias:", estaciones_elegidas)

def resolver(numeros):
    lista = [1] * len(numeros)
    for i in range(len(numeros)):
        posibles = []
        for j in range(i):
            if numeros[i] > numeros[j]:
                posibles.append(lista[j])
        if len(posibles) > 0:
            lista[i] = max(posibles) + 1

    return lista


print(resolver([2, 1, 4, 2, 3, 9, 4, 6, 5, 4, 7]))