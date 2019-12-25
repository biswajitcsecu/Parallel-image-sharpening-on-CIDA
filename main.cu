
#define cimg_display 0

#include "CImg.h"
#include <cuda_runtime.h>
#include <npp.h>
#include <nppdefs.h>
#include <nppcore.h>
#include <nppi.h>
#include <npps.h>
#include <stdlib.h>
#include <iostream>


#define kNumCh 3

using namespace std;
using namespace cimg_library;

void sharpenNPP(Npp8u *arr, int w, int h) {
    //variables
    Npp8u *d_in = 0, *d_out = 0;
    Npp32f *d_filter = 0;
    
    const Npp32f filter[9] = {-1.0, -1.0, -1.0,
    -1.0, 9.0, -1.0,
    -1.0, -1.0, -1.0};
    
    //memory allocation
    cudaMalloc(&d_out, kNumCh*w*h*sizeof(Npp8u));
    cudaMalloc(&d_in, kNumCh*w*h*sizeof(Npp8u));
    cudaMalloc(&d_filter, 9*sizeof(Npp32f));
    cudaMemcpy(d_in, arr, kNumCh*w*h*sizeof(Npp8u),cudaMemcpyHostToDevice);
    cudaMemcpy(d_filter, filter, 9*sizeof(Npp32f),cudaMemcpyHostToDevice);
    
    //Parameters
    const NppiSize oKernelSize = {3, 3};
    const NppiPoint oAnchor = {1, 1};
    const NppiSize oSrcSize = {w, h};
    const NppiPoint oSrcOffset = {0, 0};
    const NppiSize oSizeROI = {w, h};
    
    //Filter
    nppiFilterBorder32f_8u_C3R(d_in, kNumCh*w*sizeof(Npp8u), oSrcSize, oSrcOffset, d_out, kNumCh*w*sizeof(Npp8u), oSizeROI, d_filter,
oKernelSize, oAnchor, NPP_BORDER_REPLICATE);    
    
    //from device to host
    cudaMemcpy(arr, d_out, kNumCh*w*h*sizeof(Npp8u),  cudaMemcpyDeviceToHost);
    
    //device deallocation
    cudaFree(d_in);
    cudaFree(d_out);
    cudaFree(d_filter);
}



int main(int argc, char** argv) {
    try{
    //load image
    cimg_library::CImg<unsigned char> image("src.bmp");
    
    const int w = image.width();
    const int h = image.height();

    Npp8u *arr = (Npp8u*)malloc(kNumCh*w*h*sizeof(Npp8u));
    
    for (int r = 0; r < h; ++r) {
        for (int c = 0; c < w; ++c) {
            for (int ch = 0; ch < kNumCh; ++ch) {
                arr[kNumCh*(r*w + c) + ch] = image(c, r, ch);
            }
        }
    }

    // method call
    sharpenNPP(arr, w, h);
    
    for (int r = 0; r < h; ++r) {
        for (int c = 0; c < w; ++c) {
            for (int ch = 0; ch < kNumCh; ++ch) {
                image(c, r, ch) = arr[kNumCh*(r*w + c) + ch];
            }
        }
    }
    
    image.save_bmp("out.bmp");
    free(arr);
    }catch(std::exception &orb){
        std::cerr<<""<<orb.what()<<std::endl;
        return EXIT_FAILURE;
    }
    return EXIT_SUCCESS;

}






