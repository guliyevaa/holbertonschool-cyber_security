#!/usr/bin/python3
"""
A script that finds a string in the heap of a running process
and replaces it with another string of equal or shorter length.
"""
import sys

def get_heap_bounds(pid):
    try:
        with open(f'/proc/{pid}/maps', 'r') as f:
            for line in f:
                if "[heap]" in line:
                    addr = line.split()[0]
                    start, end = addr.split('-')
                    return int(start, 16), int(end, 16)
    except Exception:
        sys.exit(1)
    sys.exit(1)

def main():
    if len(sys.argv) != 4:
        print("Usage: read_write_heap.py pid search_string replace_string")
        sys.exit(1)

    pid = sys.argv[1]
    search = sys.argv[2].encode()
    replace = sys.argv[3].encode()

    if len(replace) > len(search):
        sys.exit(1)

    replace = replace.ljust(len(search), b'\x00')

    heap_start, heap_end = get_heap_bounds(pid)

    try:
        with open(f'/proc/{pid}/mem', 'rb+') as mem:
            mem.seek(heap_start)
            data = mem.read(heap_end - heap_start)

            index = data.find(search)
            if index == -1:
                sys.exit(0)

            mem.seek(heap_start + index)
            mem.write(replace)

            print("SUCCESS!")

    except Exception:
        sys.exit(1)

if __name__ == "__main__":
    main()
