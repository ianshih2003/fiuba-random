def calc_estimador_de_estimacion(muestras):
    promedio = calc_promedio(muestras)

    numerador = 0

    for muestra in muestras:
        numerador += (muestra - promedio) ** 2

    return (numerador / (len(muestras) - 1)) ** (0.5)


def calc_promedio(muestras):
    return sum(muestras) / len(muestras)


muestras_113 = [9.11, 8.66, 8.34, 8.60, 7.99, 8.58, 8.34, 7.33, 8.64, 9.27, 9.06, 9.25]
muestras_114 = [196.73, 204.37, 201.57, 197.58, 205.89, 199.03, 201.75, 206.53, 199.31, 202.27]

print(calc_estimador_de_estimacion(muestras_114))
print(calc_promedio(muestras_114))
