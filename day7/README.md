# Day7

**Part 1**
- Need to free up space.
- Sample input below
```
$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k

```
- $ are commands executed
- cd means `change directory`
- `cd x` moves in one level into that folder
- `cd ..` moves out one level
- `cd /` moves to outermost directory
- `ls` means list.

1 `123 abc` means file abc with size 123

2 `dir xyz` means that current directory contains directory xyz

- determine the size of each directory
- From above this is the size of the directories

```

    The total size of directory e is 584 because it contains a single file i of size 584 and no other directories.
    The directory a has total size 94853 because it contains files f (size 29116), g (size 2557), and h.lst (size 62596), plus file i indirectly (a contains e which contains i).
    Directory d has total size 24933642.
    As the outermost directory, / contains every file. Its total size is 48381165, the sum of the size of every file.

```

- find all directories with a total size of `at most 100000` then calculate the sum of those.
- From above a and e - which iis 95437 (94853 + 584)