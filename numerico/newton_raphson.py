def error_absoluto(p_siguiente, p_actual):
    return abs(p_siguiente - p_actual)


def _newton_raphson(f, f_derivada, p_actual, tolerancia, iteraciones):
    p_siguiente = p_actual - (f(p_actual) / f_derivada(p_actual))
    iteraciones.append(p_siguiente)

    if error_absoluto(p_siguiente, p_actual) < tolerancia:
        return iteraciones

    return _newton_raphson(f, f_derivada, p_siguiente, tolerancia, iteraciones)


def newton_raphson(f, f_derivada, p_actual, tolerancia):
    iteraciones = [p_actual]
    return _newton_raphson(f, f_derivada, p_actual, tolerancia, iteraciones)


def _newton_raphson_mod(f, f_derivada, f_derivada2, p_actual, tolerancia, iteraciones):
    p_siguiente = p_actual - ((f(p_actual) * f_derivada(p_actual)) / (
            (f_derivada(p_actual) ** 2) - f(p_actual) * f_derivada2(p_actual)))
    iteraciones.append(p_siguiente)
    if (error_absoluto(p_siguiente, p_actual) < tolerancia) or (len(iteraciones) > 100):
        return iteraciones

    return _newton_raphson_mod(f, f_derivada, f_derivada2, p_siguiente, tolerancia, iteraciones)


def newton_raphson_mod(f, f_derivada, f_derivada2, p_actual, tolerancia):
    iteraciones = [p_actual]

    return _newton_raphson_mod(f, f_derivada, f_derivada2, p_actual, tolerancia, iteraciones)


semilla = 1100

tolerancia_grande = 10 ** -5

tolerancia_chica = 10 ** -13


def f(x):
    return (0.001 * x * ((x - 1000) ** 2)) - 25000


def f_derivada(x):
    return 0.003 * (x ** 2) - (4 * x) + 1000


print(newton_raphson(f, f_derivada, semilla, tolerancia_chica))
print(newton_raphson(f, f_derivada, semilla, tolerancia_grande))
