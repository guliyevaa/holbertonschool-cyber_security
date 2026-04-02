#!/usr/bin/env python3
import sys
import re

def error():
    print("Usage: read_write_heap.py pid search_string replace_string")
    sys.exit(1)

# Check arguments
if len(sys.argv) != 4:
    error()

pid = sys.argv[1]
search = sys.argv[2].encode()
replace = sys.argv[3].encode()

# Length must match
if len(search) != len(replace):
    error()

# Step 1: Find heap in /proc/pid/maps
heap_start = None
heap_end = None

with open(f"/proc/{pid}/maps", "r") as maps:
    for line in maps:
        if "[heap]" in line:
            match = re.match(r"([0-9a-f]+)-([0-9a-f]+)", line)
            if match:
                heap_start = int(match.group(1), 16)
                heap_end = int(match.group(2), 16)
                break

if heap_start is None:
    print("Heap not found")
    sys.exit(1)

print(f"[+] Heap found: {hex(heap_start)} - {hex(heap_end)}")

# Step 2: Read heap
with open(f"/proc/{pid}/mem", "rb+") as mem:
    mem.seek(heap_start)
    heap = mem.read(heap_end - heap_start)

    index = heap.find(search)

    if index == -1:
        print("String not found")
        sys.exit(1)

    print(f"[+] String found at offset: {hex(heap_start + index)}")

    # Step 3: Replace string
    mem.seek(heap_start + index)
    mem.write(replace)

    print("[+] String replaced successfully!")
