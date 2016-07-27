# sha256-simd

Accelerate SHA256 computations in pure Go for both Intel (AVX2, AVX, SSE) as well as ARM (arm64) platforms.

## Introduction

This package is designed as a drop-in replacement for `crypto/sha256`. For Intel CPUs it has three flavors for AVX2, AVX and SSE whereby the fastest method is automatically chosen depending on CPU capabilities. For ARM CPUs with the Cryptography Extensions advantage is taken of the SHA2 instructions resulting in a massive performance improvement.

This package uses Golang assembly and as such does not depend on cgo. The Intel versions are based on the implementations as described in "Fast SHA-256 Implementations on Intel Architecture Processors" by J. Guilford et al.

## Performance

Below is the speed in MB/s for a single core (ranked fast to slow) as well as the factor of improvement over `crypto/sha256` (when applicable).

| Processor                         | Package                      |       Speed | Improvement |
| --------------------------------- | ---------------------------- | -----------:| -----------:|
| 1.2 GHz ARM Cortex-A53            | minio/sha256-simd (ARM64)    |  638.2 MB/s |        105x |
| 2.4 GHz Intel Xeon CPU E5-2620 v3 | minio/sha256-simd (AVX2) (*) |  355.0 MB/s |       1.88x |
| 2.4 GHz Intel Xeon CPU E5-2620 v3 | minio/sha256-simd (AVX)      |  306.0 MB/s |       1.62x |
| 2.4 GHz Intel Xeon CPU E5-2620 v3 | minio/sha256-simd (SSE)      |  298.7 MB/s |       1.58x |
| 2.4 GHz Intel Xeon CPU E5-2620 v3 | crypto/sha256                |  189.2 MB/s |             |
| 1.2 GHz ARM Cortex-A53            | crypto/sha256                |    6.1 MB/s |             |

(*) Measured with the "unrolled"/"demacro-ed" AVX2 version. Due to some Golang assembly restrictions the AVX2 version that uses `defines` loses about 15% performance. The optimized version is contained in the git history so for maximum speed you want to do this after getting: `git cat-file blob 586b6e > sha256blockAvx2_amd64.s`.
 
## Comparison to other hashing techniques

As measured on Intel Xeon (same as above) with AVX2 version:

| Method  | Package            |    Speed |
| ------- | -------------------| --------:|
| BLAKE2B | [minio/blake2b-simd](https://github.com/minio/blake2b-simd) | 851 MB/s |
| MD5     | crypto/md5         | 607 MB/s |
| SHA1    | crypto/sha1        | 522 MB/s |
| SHA256  | minio/sha256-simd  | 355 MB/s |
| SHA512  | crypto/sha512      | 306 MB/s |

License
-------

Released under the Apache License v2.0. You can find the complete text in the file LICENSE.

Contributing
------------

Contributions are welcome, please send PRs for any enhancements.
