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

(*) Measured with the "unrolled"/"demacro-ed" AVX2 version. Due to some Golang assembly restrictions the AVX2 version that uses `defines` loses about 15% performance. The optimized version is contained in the git history so for maximum speed you want to do this after getting: `git cat-file blob 586b6e > sha256blockAvx2_amd64.s` (or vendor it for your project; see [here](https://github.com/minio/sha256-simd/blob/13b11bdf9b0580a756a111492d2ae382bab7ec79/sha256blockAvx2_amd64.s) to view it in its full glory).
 
## Comparison to other hashing techniques

As measured on Intel Xeon (same as above) with AVX2 version:

| Method  | Package            |    Speed |
| ------- | -------------------| --------:|
| BLAKE2B | [minio/blake2b-simd](https://github.com/minio/blake2b-simd) | 851 MB/s |
| MD5     | crypto/md5         | 607 MB/s |
| SHA1    | crypto/sha1        | 522 MB/s |
| SHA256  | minio/sha256-simd  | 355 MB/s |
| SHA512  | crypto/sha512      | 306 MB/s |

Detailed benchmarks
-------------------

Example performance metrics were generated on  Intel(R) Xeon(R) CPU E5-2620 v3 @ 2.40GHz - 6 physical cores, 12 logical cores running Ubuntu GNU/Linux with kernel version 4.4.0-24-generic (vanilla with no optimizations).

### AVX2

```
$ benchcmp go.txt avx2.txt
benchmark                  old ns/op     new ns/op     delta
BenchmarkHash8Bytes-12     446           364           -18.39%
BenchmarkHash1K-12         5919          3279          -44.60%
BenchmarkHash8K-12         43791         23655         -45.98%
BenchmarkHash1M-12         5544989       2969305       -46.45%

benchmark                  old MB/s     new MB/s     speedup
BenchmarkHash8Bytes-12     17.93        21.96        1.22x
BenchmarkHash1K-12         172.98       312.27       1.81x
BenchmarkHash8K-12         187.07       346.31       1.85x
BenchmarkHash1M-12         189.10       353.14       1.87x
```

### AVX

```
$ benchcmp go.txt avx.txt 
benchmark                  old ns/op     new ns/op     delta
BenchmarkHash8Bytes-12     446           346           -22.42%
BenchmarkHash1K-12         5919          3701          -37.47%
BenchmarkHash8K-12         43791         27222         -37.84%
BenchmarkHash1M-12         5544989       3426938       -38.20%

benchmark                  old MB/s     new MB/s     speedup
BenchmarkHash8Bytes-12     17.93        23.06        1.29x
BenchmarkHash1K-12         172.98       276.64       1.60x
BenchmarkHash8K-12         187.07       300.93       1.61x
BenchmarkHash1M-12         189.10       305.98       1.62x
```

### SSE

```
$ benchcmp go.txt sse.txt 
benchmark                  old ns/op     new ns/op     delta
BenchmarkHash8Bytes-12     446           362           -18.83%
BenchmarkHash1K-12         5919          3751          -36.63%
BenchmarkHash8K-12         43791         27396         -37.44%
BenchmarkHash1M-12         5544989       3444623       -37.88%

benchmark                  old MB/s     new MB/s     speedup
BenchmarkHash8Bytes-12     17.93        22.05        1.23x
BenchmarkHash1K-12         172.98       272.92       1.58x
BenchmarkHash8K-12         187.07       299.01       1.60x
BenchmarkHash1M-12         189.10       304.41       1.61x
```

License
-------

Released under the Apache License v2.0. You can find the complete text in the file LICENSE.

Contributing
------------

Contributions are welcome, please send PRs for any enhancements.
