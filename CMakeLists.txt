cmake_minimum_required(VERSION 3.21)

set(libname SumAreaTableRocm)
project(${libname} LANGUAGES CXX HIP)

option(BUILD_TESTING "Build tests" OFF)
include(CTest)
message(STATUS "BUILD_TESTING value: ${BUILD_TESTING}")

# HIP
set(ROCM_ROOT
        "/opt/rocm"
        CACHE PATH
        "Root directory of the ROCm installation"
)

list(APPEND CMAKE_PREFIX_PATH "${ROCM_ROOT}")
find_package(hip REQUIRED)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


# Create Library
add_executable(${libname} src/satHip.hip)

target_link_libraries(${libname} PRIVATE hip::device)
target_include_directories(${libname} PRIVATE ${CMAKE_SOURCE_DIR}/include)

# testing 
if(BUILD_TESTING)
    enable_testing()
    include(FetchContent)
    
    FetchContent_Declare(
         googletest
         URL https://github.com/google/googletest/archive/03597a01ee50ed33e9dfd640b249b4be3799d395.zip
    )

    # Prevent GoogleTest from overriding our compiler options
    set(gtest_force_shared_crt OFF CACHE BOOL "" FORCE)

    FetchContent_MakeAvailable(googletest)

    add_subdirectory(tests)
endif()
