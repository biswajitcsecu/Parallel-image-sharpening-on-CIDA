#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Environment
MKDIR=mkdir
CP=cp
GREP=grep
NM=nm
CCADMIN=CCadmin
RANLIB=ranlib
CC=gcc
CCC=nvcc
CXX=nvcc
FC=gfortran
AS=as

# Macros
CND_PLATFORM=GNU-Linux
CND_DLIB_EXT=so
CND_CONF=Debug
CND_DISTDIR=dist
CND_BUILDDIR=build

# Include project Makefile
include Makefile

# Object Directory
OBJECTDIR=${CND_BUILDDIR}/${CND_CONF}/${CND_PLATFORM}

# Object Files
OBJECTFILES= \
	${OBJECTDIR}/main.o


# C Compiler Flags
CFLAGS=

# CC Compiler Flags
CCFLAGS=
CXXFLAGS=

# Fortran Compiler Flags
FFLAGS=

# Assembler Flags
ASFLAGS=

# Link Libraries and Options
LDLIBSOPTIONS=-L/opt/arrayfire/lib -lOpenCL -laccinj64 -laf -lafcpu -lafcuda -lafopencl -lcublas -lcublas_device -lcublas_static -lcudadevrt -lcudart -lcudart_static -lcudnn_static_v7 -lcufft -lcufft_static -lcufftw -lcufftw_static -lcuinj64 -lculibos -lcurand -lcurand_static -lcusolver -lcusolver_static -lcusparse -lcusparse_static -lforge -lmkl_avx -lmkl_avx2 -lmkl_avx512 -lmkl_core -lmkl_def -lmkl_gnu_thread -lmkl_intel_lp64 -lmkl_mc -lmkl_mc3 -lnccl -lnccl_static -lnppc -lnppc_static -lnppial -lnppial_static -lnppicc -lnppicc_static -lnppicom -lnppicom_static -lnppidei -lnppidei_static -lnppif -lnppif_static -lnppig -lnppig_static -lnppim -lnppim_static -lnppist -lnppist_static -lnppisu -lnppisu_static -lnppitc -lnppitc_static -lnpps -lnpps_static -lnvToolsExt -lnvblas -lnvgraph -lnvgraph_static -lnvrtc-builtins -lnvrtc -lnvvm

# Build Targets
.build-conf: ${BUILD_SUBPROJECTS}
	"${MAKE}"  -f nbproject/Makefile-${CND_CONF}.mk ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/sharpennppapplication

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/sharpennppapplication: ${OBJECTFILES}
	${MKDIR} -p ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}
	${LINK.cc} -o ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/sharpennppapplication ${OBJECTFILES} ${LDLIBSOPTIONS}

${OBJECTDIR}/main.o: main.cu
	${MKDIR} -p ${OBJECTDIR}
	$(COMPILE.cc) -g -I/opt/arrayfire/include -std=c++14 -o ${OBJECTDIR}/main.o main.cu

# Subprojects
.build-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r ${CND_BUILDDIR}/${CND_CONF}

# Subprojects
.clean-subprojects:
