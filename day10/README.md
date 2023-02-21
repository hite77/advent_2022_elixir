# Day10

**Part one**

- addx V adds or subtracts after two cycles
- noop takes one cycle no effect
- starts at 1

```
noop
addx 3
addx -5
```

- cycle 1 start noop
- cycle 2 addx 3 X=1
- cycle 3 X=1
- cycle 4 X=4 start of addx -5
- cycle 5 still 4
- cycle 6 after 5 -5 for -1.