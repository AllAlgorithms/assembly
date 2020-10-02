# Knuth–Morris–Pratt string searching algorithm
This program searches for the first occurrence of a string within another string using KMP algorithm.

### Compiling
Just use the makefile with ``make``

### Usage
Run with ``./kmp <STRING>``, then enter search string
example run:
```
./kmp AAAAABCBCDDDDDAAAAACCC
Search pattern: DDDAAA
Prefix table:
012000

First position: 11 (index starting from 0)
```
