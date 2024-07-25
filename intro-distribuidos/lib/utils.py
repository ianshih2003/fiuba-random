import argparse
import logging

def parse_parameters(upload: bool, description: str):
    parser = argparse.ArgumentParser(description=description)
    parser.add_argument('-v', '--verbose', help='increase output verbosity', action="store_const", dest="loglevel", const=logging.DEBUG)
    parser.add_argument('-q', '--quiet', help='decrease output verbosity', action="store_const", dest="loglevel", const=logging.ERROR)
    parser.add_argument('-H', '--host', help='Direccion IP del servidor')
    parser.add_argument('-p', '--port', type=int, help='Puerto del servidor')
    if upload:
        parser.add_argument('-s', '--src', required=True, help='Ruta del archivo fuente')
    else:
        parser.add_argument('-d', '--dst', required=True, help='Ruta al archivo destino')
   
    parser.add_argument('-n', '--name', required=True, help='Nombre del archivo en el servidor')

    return parser.parse_args()