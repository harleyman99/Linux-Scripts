#!/bin/env python3

# This is a script to allow for the automatic backup of config files of networking gear.

import paramiko
import time
from datetime import datetime

#========== CONFIGURATION ============
username = "student" # SSH username 
password = "cisco" # SSH password
tftp_server = "192.168.0.0"  # IP of the TFTP server
device_list_file = "devices.txt"
log_file = "backup_log.txt"

# ======== FUNCTION =========
def backup_device(ip):
    try:
        # Create SSH client
        ssh = paramiko.SSHClient()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy)
        ssh.connect(ip, username=username, password=password, timeout=10)

        print(f"Connected to {ip}")

        # Start interactive shell
        remote_conn = ssh.invoke_shell()
        time.sleep(1)

        # Enter enable mode
        remote_conn.send("enable\n")
        time.sleep(1)
        remote_conn.send(password + "\n")
        time.sleep(1)

        # Set terminal length to 0 (avoid pagination)
        remote_conn.send("terminal length 0\n")
        time.sleep(1)

        # Backup commands
        filename = f"{ip}_backup_{datetime.now().strftime('%Y%m%d_%H%M%S')}.cfg"
        cmd = f"copy running-config tftp:\n"
        remote_conn.send(cmd)
        time.sleep(2)
        remote_conn.send(f"{tftp_server}\n")
        time.sleep(2)
        remote_conn.send(f"{filename}\n")
        time.sleep(5)

        # Read output
        output = remote_conn.recv(65535).decode('utf-8')
        ssh.close

        if "OK" in output or "copied" in output or "Copy complete" in output:
            log_message = f"{datetime.now()} - SUCCESS - {ip} - {filename}\n"
        else:
            log_message = f"{datetime.now()} - FAILED - {ip} - See console output. \n"

        print(log_message.strip())
        with open(log_file, "a") as log:
            log.write(log_message)

    except Exception as e:
        error_msg = f"{datetime.now()} - ERROR - {ip} - {str(e)}\n"
        print(error_msg.strip())
        with open(log_file, "a") as log:
            log.write(error_msg)

#========= MAIN SCRIPT ===================

if __name__=="__main__":
    with open(device_list_file) as f:
        devices = [line.strip() for line in f if line.strip()]

    print(f"Starting backup of {len(devices)} devices...\n")
    for device in devices:
        backup_device(device)

    print("\nBackup completed. Check backup_log.txt for details.")        
            

