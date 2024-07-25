import socket
import argparse
import logging
import os

SERVER_ADDRESS = '127.0.0.1'
PORT=12000
HOST="127.0.0.1"
SERVER_INV_PATH='./server_inv'

def parse_parameters():
    parser = argparse.ArgumentParser(description='Comandos del servidor de archivos.')
    parser.add_argument('-v', '--verbose', help='increase output verbosity', action="store_const", dest="loglevel", const=logging.DEBUG)
    parser.add_argument('-q', '--quiet', help='decrease output verbosity', action="store_const", dest="loglevel", const=logging.ERROR)
    parser.add_argument('-H', '--host', help='service IP address')
    parser.add_argument('-p', '--port', type=int, help='service port')
    parser.add_argument('-i', '--inventory', action="store_true", help='Listar archivos del servidor')
    parser.add_argument('-s', '--storage', help='storage dir path')
    return parser.parse_args()


def list_inv_files(server_inv_path):
    path = server_inv_path or SERVER_INV_PATH
    if not os.path.isdir(path):
        os.mkdir(path)

    archivos = os.listdir(path)

    for archivo in archivos:
        print(archivo)

def create_socket(host: str, port: int):
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    server_socket.bind((host or HOST, port or PORT))
    return server_socket

def parse_data(data: bytes) -> (str, bytes):
    name, file = data.decode().splitlines()

    return name, file[2:len(file)-1].encode()

def main():
    args = parse_parameters()

    logging.basicConfig(level=args.loglevel)

    storage = args.storage or SERVER_INV_PATH

    if args.inventory:
        list_inv_files(storage)

    server_socket = create_socket(args.host, args.port)

    logging.debug(f"Starting server in PORT: {args.port or PORT}")

    try:
        while True:
            data, address = server_socket.recvfrom(1024)

            logging.debug(f"Receiving data from {address}")

            name, file_data = parse_data(data)

            with open(f"{storage}/{name}", 'ab') as archivo_salida:
                archivo_salida.write(file_data)
    
    except socket.timeout:
        logging.error("Request timed out")

    logging.info("Closing socket")
    server_socket.close()

main()