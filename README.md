# buffer overflow segfaults
tested on kali 2021


## Dependencies
```sh
sudo apt update && sudo apt upgrade -y
sudo apt install make mingw-w64 valgrind clang-format

# you may want to disable ASLR
sudo sysctl kernel.randomize_va_space=0
```

## Testing

### Run a one-off test
```sh
make test TRY_BUFFER_SIZE=5
```

### Compile and run tests (iteration)
```sh
make iter
```

### View test results
```sh
cat segfaults.csv
```

## Docker

### Build
```sh
docker build . -t buffer-overflow-segfaults
```

### Run
```sh
docker run -t buffer-overflow-segfaults
```

### Shell
```sh
docker run --entrypoint /bin/bash -i -t buffer-overflow-segfaults
```

### Run and output `segfaults.csv`
```sh
docker run --entrypoint /bin/bash -i -t buffer-overflow-segfaults \
-c 'make iter |& cat >> /dev/null; cat segfaults.csv' | tee segfaults.csv
```


## Show make targets
```sh
make help
```
