#!/usr/bin/python3
import sys


def error():
    print("Usage: read_write_heap.py pid search_string replace_string")
    sys.exit(1)


if len(sys.argv) != 4:
    error()

pid = sys.argv[1]
search = sys.argv[2].encode()
replace = sys.argv[3].encode()

if len(replace) > len(search):
    sys.exit(1)

replace = replace.ljust(len(search), b'\x00')

heap_start = None
heap_end = None

try:
    with open(f"/proc/{pid}/maps", "r") as maps:
        for line in maps:
            if "[heap]" in line:
                addr = line.split()[0]
                heap_start, heap_end = addr.split('-')
                heap_start = int(heap_start, 16)
                heap_end = int(heap_end, 16)
                break
except Exception:
    sys.exit(1)

if heap_start is None:
    sys.exit(1)

try:
    with open(f"/proc/{pid}/mem", "rb+") as mem:
        mem.seek(heap_start)
        data = mem.read(heap_end - heap_start)

        index = data.find(search)
        if index == -1:
            sys.exit(0)

        mem.seek(heap_start + index)
        mem.write(replace)

        print("SUCCESS!")
        sys.exit(0)

except Exception:
    sys.exit(1)
