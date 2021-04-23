cmake_minimum_required(VERSION 3.7)

project(groopsio LANGUAGES CXX Fortran)
set(CMAKE_CXX_STANDARD 14)

set(CMAKE_MACOSX_RPATH 1)

find_package(JlCxx)
get_target_property(JlCxx_location JlCxx::cxxwrap_julia LOCATION)
get_filename_component(JlCxx_location ${JlCxx_location} DIRECTORY)
set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib;${JlCxx_location}")

find_package(EXPAT  REQUIRED)
include_directories(${EXPAT_INCLUDE_DIRS})

find_package(BLAS   REQUIRED)
find_package(LAPACK REQUIRED)

find_library(LIB_Z z)
if(LIB_Z)
  find_path(ZLIB_INCLUDE_DIR NAMES zlib.h)
  include_directories(${ZLIB_INCLUDE_DIR})
  set(BASE_LIBRARIES ${BASE_LIBRARIES} ${LIB_Z})
else()
  add_definitions(-DNOLIB_Z)
  message(WARNING "Z library *NOT* found (https://www.zlib.net). groopsio will not be able to read/write compressed *.gz files.")
endif()

set(BASE_LIBRARIES ${BLAS_LIBRARIES} ${LAPACK_LIBRARIES} ${EXPAT_LIBRARIES} ${LIB_Z} ${Python3_LIBRARIES} JlCxx::cxxwrap_julia stdc++fs)

include(sources.list)
set(GROOPS_SOURCE_DIR "" CACHE PATH "path to GROOPS source directory")
include_directories(${GROOPS_SOURCE_DIR})
list(TRANSFORM SOURCES PREPEND ${GROOPS_SOURCE_DIR}//)

add_library(groopsio SHARED ${PROJECT_SOURCE_DIR}/groopsio.cpp ${SOURCES})

target_link_libraries(groopsio ${BASE_LIBRARIES})

install(TARGETS groopsio
LIBRARY DESTINATION lib
ARCHIVE DESTINATION lib
RUNTIME DESTINATION lib)
