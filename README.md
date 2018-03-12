# assert.bash

Simple assert function for bash.

## Usage

```
$ source assert.bash
$ assert "str_val" "str_val"   # string comparison
OK
$ assert "str_val" "str_val2"  # if assertion failure, show arguments.
ERR str_val str_val2
$ assert 2 -gt 1               # numeric comparison
OK
$ assert 2 -lt 1
ERR 2 -lt 1
$ assert "str_val" match val$  # regexp
OK
$ assert "str_val" match ^val
ERR str_val /^val/
$ asseret -f exits.txt         # file exists
OK
$ asseret -d nothing/dir       # directory exists
ERR -d nothing/dir
```

## License

[MIT License](LICENSE)

## Version

0.1.0
