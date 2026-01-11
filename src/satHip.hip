#include "satHip.hpp"
#include <hip/hip_runtime.h>
#include <iostream>
#include "hipErrorCheck.hpp"

namespace 
{
  __global__ void satHipUint32Kernel(const uint32_t *imgDev, 
    uint64_t *out, 
    const uint32_t w,
    const uint32_t h) 
    {
    // Kernel implementation goes here

    }

    // Sobel 3x3 kernel implementation
  __global__ void sobel3x3Kernel(const int32_t *imgDev,
    int32_t *out,
    const uint32_t w,
    const uint32_t h)
    {
        constexpr int32_t sobelX[9] = {-1,0,1
                            ,-2,0,2 
                            ,-1,0,1};
        constexpr int32_t scale = 1;
        constexpr int32_t kradius = 1;
        constexpr int32_t ksize = 2 * kradius + 1;
        constexpr int32_t sSize =(32 + ksize - 1) * (16 + ksize - 1);
        __shared__ int32_t smem[sSize];

        int x = blockIdx.x * blockDim.x + threadIdx.x;
        int y = blockIdx.y * blockDim.y + threadIdx.y;
        int tidx = threadIdx.x;
        int tidy = threadIdx.y;
        int tid = tidy * blockDim.x + tidx;

        // Load data to shared memory
        // Dirichlet boundary conditions
        while(tid < sSize){
            int gx = tidx - ksize / 2;
            int gy = tidy - ksize / 2;
            int imgX = blockIdx.x * blockDim.x + gx;
            int imgY = blockIdx.y * blockDim.y + gy;

            imgX = imgX < 0 ? 0 : imgX;
            imgX = imgX > (w -1) ? (w -1) : imgX;
            imgY = imgY < 0 ? 0 : imgY;
            imgY = imgY > (h -1) ? (h -1) : imgY;

            smem[tid] = imgDev[imgY * w + imgX];
           
            tid += blockDim.x * blockDim.y;
        }
        __syncthreads();

        if(x < w && y < h){
            int32_t sumX = 0;
            for(int ky = -1; ky <= 1; ky++){
                for(int kx = -1; kx <= 1; kx++){
                    int smemX = tidx + kx + 1;
                    int smemY = tidy + ky + 1;
                    int smemIdx = smemY * (32 + 2 * kradius) + smemX;
                    sumX += smem[smemIdx] * sobelX[((ksize - 1) - (ky + 1)) * 3 + ((ksize - 1) - (kx + 1))];
                }
            }
            sumX = sumX / scale;
            out[y * w + x] = sumX;
        } 
    }
} // namespace

// Wrapper function to launch the kernel
void satHipUint32(const uint32_t *imgDev, 
    uint64_t *out, 
    const uint32_t w,
    const uint32_t h) 
    {
      dim3 blockSize(32, 16);
      dim3 gridSize((w + blockSize.x - 1) / blockSize.x,
                    (h + blockSize.y - 1) / blockSize.y);
      satHipUint32Kernel<<<gridSize, blockSize>>>(imgDev, out, w, h);
      
      HipCheckError(hipDeviceSynchronize());
      HipGetLastError();  
    }

int main() {
  std::cout << "Hello World!" << std::endl;
  return 0;
}