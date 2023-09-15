# To build for windows, run:
Edit the toolchain.cmake file with the path to your xwin output. It's not meant to be easily replaceable as everything is hardcoded, but it was a good proof of concept.

```sh
cmake .. -DCMAKE_TOOLCHAIN_FILE=../toolchain.cmake
```
