#include "satHip.hpp"
#include <hip/hip_runtime.h>
#include <iostream>

namespace 
{
__global__ void satHipUint32Kernel(const uint32_t *imgDev, 
    uint64_t *out, 
    const uint32_t w,
    const uint32_t h) 
    {
    // Kernel implementation goes here
    }
} // namespace

// Wrapper function to launch the kernel
void satHipUint32(const uint32_t *imgDev, 
    uint64_t *out, 
    const uint32_t w,
    const uint32_t h) 
    {

    }

int main() {
  std::cout << "Hello World!" << std::endl;
  return 0;
}