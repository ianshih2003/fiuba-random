def error_absoluto(p_siguiente, p_actual):
    return abs(p_siguiente - p_actual)


def punto_fijo(f, p_actual, tolerancia):
    if error_absoluto(f(p_actual), p_actual) < tolerancia:
        return [f(p_actual)]

    return [p_actual] + punto_fijo(f, f(p_actual), tolerancia)
