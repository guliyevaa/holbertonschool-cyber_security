#!/usr/bin/python3
import sys
import re

def error():
    print("Usage: read_write_heap.py pid search_string replace_string")
    sys.exit(1)

if len(sys.argv) != 4:
    error()

pid = sys.argv[1]
search = sys.argv[2].encode()
replace = sys.argv[3].encode()

if len(search) != len(replace):
    error()

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
    sys.exit(1)

with open(f"/proc/{pid}/mem", "rb+") as mem:
    mem.seek(heap_start)
    heap = mem.read(heap_end - heap_start)

    index = heap.find(search)
    if index == -1:
        sys.exit(1)

    mem.seek(heap_start + index)
    mem.write(replace)

print("SUCCESS!")
