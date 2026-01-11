#include <hip/hip_runtime.h>
#include <iostream>

#pragma once

namespace 
{
    void hipCheckError(hipError_t err, const char *file, int line)
  {
    if (err != hipSuccess)
    {
      std::cerr << "HIP Error: " << hipGetErrorString(err)
                << " at " << file << ":" << line << std::endl;
      exit(err);
    }
  }

  void hipCheckLastError(const char *file, int line)
  {
    hipError_t err = hipGetLastError();
    if (err != hipSuccess)
    {
      std::cerr << "HIP Kernel Launch Error: " << hipGetErrorString(err)
                << " at " << file << ":" << line << std::endl;
      exit(err);
    }
  }
}

#define HipCheckError(err) (hipCheckError(err, __FILE__, __LINE__)) 
#define HipGetLastError() HipCheckError(hipGetLastError())