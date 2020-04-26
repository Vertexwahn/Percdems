## ======================================================================== ##
## Copyright 2009-2017 Intel Corporation                                    ##
##                                                                          ##
## Licensed under the Apache License, Version 2.0 (the "License");          ##
## you may not use this file except in compliance with the License.         ##
## You may obtain a copy of the License at                                  ##
##                                                                          ##
##     http://www.apache.org/licenses/LICENSE-2.0                           ##
##                                                                          ##
## Unless required by applicable law or agreed to in writing, software      ##
## distributed under the License is distributed on an "AS IS" BASIS,        ##
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. ##
## See the License for the specific language governing permissions and      ##
## limitations under the License.                                           ##
## ======================================================================== ##

if (WIN32)
  find_path(EMBREE_TBB_ROOT include/tbb/tbb.h
    DOC "Root of TBB installation"
    PATHS ${PROJECT_SOURCE_DIR}/tbb "C:/Program Files (x86)/Intel/Composer XE/tbb"
    NO_DEFAULT_PATH
  )
  find_path(EMBREE_TBB_ROOT include/tbb/tbb.h)

  if (CMAKE_SIZEOF_VOID_P EQUAL 8)
    SET(TBB_ARCH intel64)
  else()
    SET(TBB_ARCH ia32)
  endif()
  
  if (${MSVC_VERSION} GREATER_EQUAL 1910)
	set(TBB_VCVER vc15)
  endif()
  
  message(${EMBREE_TBB_ROOT}/lib/${TBB_ARCH}/${TBB_VCVER})
  
  set(TBB_LIBDIR ${EMBREE_TBB_ROOT}/lib/${TBB_ARCH}/${TBB_VCVER})
  set(TBB_BINDIR ${EMBREE_TBB_ROOT}/bin/${TBB_ARCH}/${TBB_VCVER})

  if (EMBREE_TBB_ROOT STREQUAL "")
    find_path(TBB_INCLUDE_DIR tbb/task_scheduler_init.h)
    find_library(TBB_LIBRARY tbb)
    find_library(TBB_LIBRARY_MALLOC tbbmalloc)
  else()
    set(TBB_INCLUDE_DIR TBB_INCLUDE_DIR-NOTFOUND)
    set(TBB_LIBRARY TBB_LIBRARY-NOTFOUND)
    set(TBB_LIBRARY_MALLOC TBB_LIBRARY_MALLOC-NOTFOUND)
    find_path(TBB_INCLUDE_DIR tbb/task_scheduler_init.h PATHS ${EMBREE_TBB_ROOT}/include NO_DEFAULT_PATH)
    #find_library(TBB_LIBRARY tbb PATHS ${TBB_LIBDIR} NO_DEFAULT_PATH)
    #find_library(TBB_LIBRARY_MALLOC tbbmalloc PATHS ${TBB_LIBDIR} NO_DEFAULT_PATH)
	message(${EMBREE_TBB_ROOT})
	find_path(TBB_LIBRARY_DIR
		NAMES
			tbb.lib
		HINTS
			${EMBREE_TBB_ROOT}/lib/intel64/${TBB_VCVER}
	)
	
	# Find debug and release version of tbb.lib
	find_library(TBB_LIBRARY_RELEASE			tbb.lib 			PATHS ${TBB_LIBRARY_DIR})
	find_library(TBB_LIBRARY_DEBUG				tbb_debug.lib		PATHS ${TBB_LIBRARY_DIR})
	
	set(TBB_LIBRARY 
		optimized 	${TBB_LIBRARY_RELEASE}
		debug		${TBB_LIBRARY_DEBUG}
	)
		
	set(TBB_LIBRARIES ${TBB_LIBRARY_RELEASE} ${TBB_LIBRARY_DEBUG})
	
	# Find debug and release version of tbbmalloc.lib
	find_library(TBB_LIBRARY_MALLOC_RELEASE			tbbmalloc.lib 			PATHS ${TBB_LIBRARY_DIR})
	find_library(TBB_LIBRARY_MALLOC_DEBUG			tbbmalloc_debug.lib		PATHS ${TBB_LIBRARY_DIR})
	
	set(TBB_LIBRARY_MALLOC 
		optimized 	${TBB_LIBRARY_MALLOC_RELEASE}
		debug		${TBB_LIBRARY_MALLOC_DEBUG}
	)
		
	set(TBB_LIBRARY_MALLOC ${TBB_LIBRARY_MALLOC_RELEASE} ${TBB_LIBRARY_MALLOC_DEBUG})
	
  endif()

else ()

  find_path(EMBREE_TBB_ROOT include/tbb/tbb.h
    DOC "Root of TBB installation"
    PATHS ${PROJECT_SOURCE_DIR}/tbb /opt/intel/composerxe/tbb 
    NO_DEFAULT_PATH
  )
  find_path(EMBREE_TBB_ROOT include/tbb/tbb.h)

  if (EMBREE_TBB_ROOT STREQUAL "")
    find_path(TBB_INCLUDE_DIR tbb/task_scheduler_init.h)
    find_library(TBB_LIBRARY tbb)
    find_library(TBB_LIBRARY_MALLOC tbbmalloc)
  else()
    set(TBB_INCLUDE_DIR TBB_INCLUDE_DIR-NOTFOUND)
    set(TBB_LIBRARY TBB_LIBRARY-NOTFOUND)
    set(TBB_LIBRARY_MALLOC TBB_LIBRARY_MALLOC-NOTFOUND)
    if (APPLE)
      find_path(TBB_INCLUDE_DIR tbb/task_scheduler_init.h PATHS ${EMBREE_TBB_ROOT}/include NO_DEFAULT_PATH)
      find_library(TBB_LIBRARY tbb PATHS ${EMBREE_TBB_ROOT}/lib NO_DEFAULT_PATH)
      find_library(TBB_LIBRARY_MALLOC tbbmalloc PATHS ${EMBREE_TBB_ROOT}/lib NO_DEFAULT_PATH)
    else()
      find_path(TBB_INCLUDE_DIR tbb/task_scheduler_init.h PATHS ${EMBREE_TBB_ROOT}/include NO_DEFAULT_PATH)
      find_library(TBB_LIBRARY tbb PATHS ${EMBREE_TBB_ROOT}/lib/intel64/gcc4.4 ${EMBREE_TBB_ROOT}/lib ${EMBREE_TBB_ROOT}/lib64  /usr/libx86_64-linux-gnu/ NO_DEFAULT_PATH)
      find_library(TBB_LIBRARY_MALLOC tbbmalloc PATHS ${EMBREE_TBB_ROOT}/lib/intel64/gcc4.4 ${EMBREE_TBB_ROOT}/lib ${EMBREE_TBB_ROOT}/lib64  /usr/libx86_64-linux-gnu/ NO_DEFAULT_PATH)
    endif()
  endif()

endif()

include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(TBB DEFAULT_MSG TBB_INCLUDE_DIR TBB_LIBRARY TBB_LIBRARY_MALLOC)

if (TBB_FOUND)
  set(TBB_INCLUDE_DIRS ${TBB_INCLUDE_DIR})
  set(TBB_LIBRARIES ${TBB_LIBRARY} ${TBB_LIBRARY_MALLOC})
endif()

MARK_AS_ADVANCED(TBB_INCLUDE_DIR)
MARK_AS_ADVANCED(TBB_LIBRARY)
MARK_AS_ADVANCED(TBB_LIBRARY_MALLOC)

##############################################################
# Install TBB
##############################################################

if (WIN32)
  INSTALL(PROGRAMS ${TBB_BINDIR}/tbb.dll ${TBB_BINDIR}/tbbmalloc.dll DESTINATION ${CMAKE_INSTALL_BINDIR} COMPONENT examples)
  INSTALL(PROGRAMS ${TBB_BINDIR}/tbb.dll ${TBB_BINDIR}/tbbmalloc.dll DESTINATION ${CMAKE_INSTALL_LIBDIR} COMPONENT lib)
elseif (EMBREE_ZIP_MODE)
  if (APPLE)
    INSTALL(PROGRAMS ${EMBREE_TBB_ROOT}/lib/libtbb.dylib ${EMBREE_TBB_ROOT}/lib/libtbbmalloc.dylib DESTINATION ${CMAKE_INSTALL_LIBDIR} COMPONENT lib)
  else()
    INSTALL(PROGRAMS ${EMBREE_TBB_ROOT}/lib/intel64/gcc4.4/libtbb.so.2 ${EMBREE_TBB_ROOT}/lib/intel64/gcc4.4/libtbbmalloc.so.2 DESTINATION ${CMAKE_INSTALL_LIBDIR} COMPONENT lib)
  endif()
endif()
