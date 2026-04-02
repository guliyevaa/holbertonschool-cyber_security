#!/usr/bin/python3
import sys


def get_heap_bounds(pid):
    with open(f'/proc/{pid}/maps', 'r') as maps_file:
        for line in maps_file:
            if "[heap]" in line:
                addr_range = line.split(' ')[0]
                start_str, end_str = addr_range.split('-')
                return int(start_str, 16), int(end_str, 16)
    sys.exit(1)


def main():
    if len(sys.argv) != 4:
        print("Usage: read_write_heap.py pid search_string replace_string")
        sys.exit(1)

    pid = sys.argv[1]
    search = sys.argv[2].encode()
    replace = sys.argv[3].encode()

    # length must match
    if len(search) != len(replace):
        sys.exit(1)

    heap_start, heap_end = get_heap_bounds(pid)

    with open(f'/proc/{pid}/mem', 'rb+') as mem:
        mem.seek(heap_start)
        heap = mem.read(heap_end - heap_start)

        offset = heap.find(search)
        if offset == -1:
            sys.exit(1)

        mem.seek(heap_start + offset)
        mem.write(replace)

    print("SUCCESS!")


if __name__ == "__main__":
    main()
