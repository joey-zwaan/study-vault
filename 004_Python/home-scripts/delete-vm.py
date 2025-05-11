#!/usr/bin/env python3

import os

while True:
    vmid = input("VM ID to delete: ")
    os.system(f"qm destroy {vmid} --purge")
    again = input("Delete another? (yes/no): ")
    if again.lower() != "yes":
        break