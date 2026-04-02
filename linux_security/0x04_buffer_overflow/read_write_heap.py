#!/usr/bin/python3
import sys


def error():
    print("Usage: read_write_heap.py pid search_string replace_string")
    sys.exit(1)


# Check arguments
if len(sys.argv) != 4:
    error()

pid = sys.argv[1]
search = sys.argv[2].encode()
replace = sys.argv[3].encode()

# Replacement must be same length or shorter
if len(replace) > len(search):
    print("Error: replace_string must not be longer than search_string")
    sys.exit(1)

# Pad replacement if shorter
replace = replace.ljust(len(search), b'\x00')

# Step 1: Find heap in /proc/<pid>/maps
heap_start = None
heap_end = None

try:
    with open(f"/proc/{pid}/maps", "r") as maps:
        for line in maps:
            if "[heap]" in line:
                parts = line.split()
                addresses = parts[0]
                heap_start, heap_end = addresses.split('-')
                heap_start = int(heap_start, 16)
                heap_end = int(heap_end, 16)
                break
except Exception as e:
    print(f"Error reading maps: {e}")
    sys.exit(1)

if heap_start is None:
    print("Heap not found")
    sys.exit(1)

print(f"[+] Heap found: {hex(heap_start)} - {hex(heap_end)}")

# Step 2: Read heap memory
try:
    with open(f"/proc/{pid}/mem", "rb+") as mem:
        mem.seek(heap_start)
        heap_data = mem.read(heap_end - heap_start)

        index = heap_data.find(search)

        if index == -1:
            print("String not found in heap")
            sys.exit(0)

        print(f"[+] Found at address: {hex(heap_start + index)}")

        # Step 3: Write replacement
        mem.seek(heap_start + index)
        mem.write(replace)

        print("[+] Replacement done!")

except PermissionError:
    print("Permission denied (try with sudo)")
    sys.exit(1)
except Exception as e:
    print(f"Error: {e}")
    sys.exit(1)
