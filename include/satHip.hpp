#include <stdint.h>

#pragma once

/*
 * Performs sum of area table of image on the AMD GPU.
 * The result is clamped to the maximum value of uint64_t to prevent overflow.
 * @param imgDev Pointer to the input image on the device (GPU).
 * @param out Pointer to the output sum of area table on the device (GPU).
 * @param w Width of the input image.
 * @param h Height of the input image.
 */
void satHipUint32(const uint32_t *imgDev, uint64_t *out, const uint32_t w,
                  const uint32_t h);