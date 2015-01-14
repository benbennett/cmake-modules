#.rst
# FindAntTweakBar
# ------------
#
# Created by Chen Zheng.
# Locate and configure AntTweakBar
#
# Interface Targets
# ^^^^^^^^^^^^^^^^^
#   FindAntTweakBar::FindAntTweakBar
#
# Variables
# ^^^^^^^^^
#   AntTweakBar_DIR
#   AntTweakBar_FOUND
#   AntTweakBar_INCLUDE_DIR
#   AntTweakBar_LIBRARIES
#   AntTweakBar_64_BIT - can be overridden
#
find_path(AntTweakBar_DIR
          NAMES include/AntTweakBar.h
          PATH_SUFFIXES AntTweakBar)
		  
find_path(
    AntTweakBar_INCLUDE_DIR
    NAMES include/AntTweakBar.h
    HINTS ${AntTweakBar_ROOT_DIR}
    PATH_SUFFIXES include    
    NO_DEFAULT_PATH
    )

if(DEFINED BUILD_64_BIT)
  set(AntTweakBar_64_BIT ON)
endif()

if(NOT DEFINED AntTweakBar_64_BIT)
  if (CMAKE_SIZEOF_VOID_P EQUAL 8) # 64bit
    set(AntTweakBar_64_BIT ON)
  else() # 32bit
    set(AntTweakBar_64_BIT OFF)
  endif()   
endif()

if(MSVC)
  if(AntTweakBar_64_BIT)
    find_library(AntTweakBar_LIBRARY_RELEASE "AntTweakBar64.lib" HINTS "${AntTweakBar_DIR}" PATH_SUFFIXES lib)
    find_library(AntTweakBar_LIBRARY_DEBUG "AntTweakBar64.lib" HINTS "${AntTweakBar_DIR}" PATH_SUFFIXES lib/debug)
  else()
    find_library(AntTweakBar_LIBRARY_RELEASE "AntTweakBar.lib" HINTS "${AntTweakBar_DIR}" PATH_SUFFIXES lib)
    find_library(AntTweakBar_LIBRARY_DEBUG "AntTweakBar.lib" HINTS "${AntTweakBar_DIR}" PATH_SUFFIXES lib/debug)
  endif()
else()
# TODO: Need more logic on Mac/Linux
  find_library(AntTweakBar_LIBRARY_RELEASE "libAntTweakBar.a" HINTS "${AntTweakBar_DIR}" PATH_SUFFIXES lib)
  find_library(AntTweakBar_LIBRARY_DEBUG "libAntTweakBar.a" HINTS "${AntTweakBar_DIR}" PATH_SUFFIXES lib/debug)
endif()

include(SelectConfigurations)
select_configurations(AntTweakBar LIBRARY LIBRARIES)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(	AntTweakBar DEFAULT_MSG 
									AntTweakBar_DIR AntTweakBar_INCLUDE_DIR 
									AntTweakBar_LIBRARY_RELEASE AntTweakBar_LIBRARY_DEBUG)

include(CreateImportTargetHelpers)

generate_import_target(AntTweakBar STATIC)
