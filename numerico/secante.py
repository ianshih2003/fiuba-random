def error_absoluto(p_siguiente, p_actual):
    return abs(p_siguiente - p_actual)


def aproximacion_derivada(f, x0, x1):
    return (f(x1) - f(x0)) / (x1 - x0)


def _secante(f, p_anterior, p_actual, tolerancia, iteraciones):
    p_siguiente = p_actual - f(p_actual) / aproximacion_derivada(f, p_anterior, p_actual)

    iteraciones.append(p_siguiente)

    if error_absoluto(p_siguiente, p_actual) < tolerancia:
        return iteraciones

    return _secante(f, p_actual, p_siguiente, tolerancia, iteraciones)


def secante(f, p_anterior, p_actual, tolerancia):
    iteraciones = [p_actual]

    _secante(f, p_anterior, p_actual, tolerancia, iteraciones)

    return iteraciones


semilla2 = 1106.75
semilla1 = 1013.5

tolerancia = 10 ** -5


def f(x):
    return (0.001 * x * ((x - 1000) ** 2)) - 25000


print(secante(f, semilla1, semilla2, tolerancia))
