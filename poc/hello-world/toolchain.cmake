# Toolchain file for cross-compiling to Windows from Linux

# Specify the target platform
set(CMAKE_SYSTEM_NAME Windows)

# Specify the compiler
set(CMAKE_C_COMPILER clang-cl)
set(CMAKE_CXX_COMPILER clang-cl)

set(CMAKE_RC_COMPILER llvm-rc)
set(CMAKE_RC_COMPILER_INIT clang-cl)

# Specify the linker
set(CMAKE_LINKER lld-link)
set(CMAKE_AR llvm-lib)
# Search for programs in the build host directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# Search for libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

set(CMAKE_POSITION_INDEPENDENT_CODE OFF)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# Default compile flags
set(CMAKE_C_FLAGS
    "-m64 -Wno-unused-command-line-argument -fuse-ld=lld-link /imsvc/home/eric/git/nix-cross-compile/.xwin-cache/splat/crt/include /imsvc/home/eric/git/nix-cross-compile/.xwin-cache/splat/sdk/include/ucrt /imsvc/home/eric/git/nix-cross-compile/.xwin-cache/splat/sdk/include/um /imsvc/home/eric/git/nix-cross-compile/.xwin-cache/splat/sdk/include/shared"
    CACHE STRING "" FORCE)

set(CMAKE_CXX_FLAGS
    ${CMAKE_C_FLAGS}
    CACHE STRING "" FORCE)
# Default link flags
set(CMAKE_EXE_LINKER_FLAGS
    "-m64 /libpath:/home/eric/git/nix-cross-compile/.xwin-cache/splat/crt/lib/x86_64 /libpath:/home/eric/git/nix-cross-compile/.xwin-cache/splat/sdk/lib/um/x86_64 /libpath:/home/eric/git/nix-cross-compile/.xwin-cache/splat/sdk/lib/ucrt/x86_64 /MANIFEST:NO"
    CACHE STRING "" FORCE)
set(CMAKE_NO_WINDOWS_MANIFEST TRUE)
