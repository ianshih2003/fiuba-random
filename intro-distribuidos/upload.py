from io import BufferedReader
import logging
import socket
from lib import utils

SERVER_ADDRESS = '127.0.0.1'
PORT=12000
CLIENT_INV = 'client_inv'

def create_socket(address: str, port: int):
    address = address or SERVER_ADDRESS
    port = port or PORT

    client_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    return client_socket, (address, port)

def build_segment(file: BufferedReader, file_name: str) -> bytes:
    data = file.read(1024)

    if not data:
        return data
    segment = f"{file_name}\n{data}"
    return segment.encode()
    

def main():
    args = utils.parse_parameters(True, 'Comando principal de carga de archivos.')

    logging.basicConfig(level=args.loglevel)
    
    client_socket, addr = create_socket(args.host, args.port)

    file_name = f"{args.src}/{args.name}"

    logging.debug(f"Sending file to {addr[0]}:{addr[1]} with name {file_name}")

    with open(file_name, 'rb') as file:
        while data := build_segment(file, args.name):
            client_socket.sendto(data, addr)

    client_socket.close()

main()