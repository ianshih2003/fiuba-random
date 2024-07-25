from math import ceil, log


def error_absoluto(p_siguiente, p_actual):
    return abs(p_siguiente - p_actual)


def biseccion(f, a, b, tolerancia):
    iteraciones = []
    return _biseccion(f, a, b, tolerancia, iteraciones)


def _biseccion(f, a, b, tolerancia, iteraciones):
    if f(a) * f(b) > 0:
        raise Exception("No hay raiz en el intervalo")

    p = (a + b) / 2
    retorno_funcion = f(p)
    iteraciones.append(p)

    a_siguiente = a
    b_siguiente = b

    if f(a) * retorno_funcion < 0:
        b_siguiente = p
    elif f(b) * retorno_funcion < 0:
        a_siguiente = p
    else:
        return iteraciones

    if error_absoluto((a_siguiente + b_siguiente)/2, p) < tolerancia:
        return iteraciones

    return _biseccion(f, a_siguiente, b_siguiente, tolerancia, iteraciones)


def cantidad_iteraciones_biseccion(a, b, tolerancia):
    return ceil((log(b - a) - log(tolerancia))/log(2))
