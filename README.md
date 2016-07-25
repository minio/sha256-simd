# sha256-simd

Accelerate SHA256 computations in Golang for both Intel (AVX2, AVX, SSE) as well as ARM (arm64) platforms. This package is designed as a drop-in replacement for `crypto/sha256`.

## Performance

Below is the speed in MB/s for a single core (sorted in fast to slow) as well as the factor of improvement over `crypto/sha256` (when applicable).

| Processor                         | Package                  |       Speed | Improvement |
| --------------------------------- | ------------------------ | -----------:| -----------:|
| 1.2 GHz ARM Cortex-A53            | minio/sha256-simd        |  615.7 MB/s |        101x |
| 2.4 GHz Intel Xeon CPU E5-2620 v3 | minio/sha256-simd (AVX)  |  306.0 MB/s |       1.62x |
| 2.4 GHz Intel Xeon CPU E5-2620 v3 | minio/sha256-simd (SSE)  |  298.7 MB/s |       1.58x |
| 2.4 GHz Intel Xeon CPU E5-2620 v3 | crypto/sha256            |  189.2 MB/s |             |
| 1.2 GHz ARM Cortex-A53            | crypto/sha256            |   6.07 MB/s |             |
