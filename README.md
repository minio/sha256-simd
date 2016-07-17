# sha256-simd

Accelerate SHA256 computations in Golang for both Intel (AVX2, AVX, SSE) as well as ARM (arm64) platforms.

## Performance

| Processor                         | Package           |       Speed |
| --------------------------------- | ----------------- | -----------:|
| 1.2 GHz ARM Cortex-A53            | crypto/sha256     |   6.07 MB/s |
| 1.2 GHz ARM Cortex-A53            | minio/sha256-simd |  615.7 MB/s |
| 2.4 GHz Intel Xeon CPU E5-2620 v3 | crypto/sha256     |  189.2 MB/s |
