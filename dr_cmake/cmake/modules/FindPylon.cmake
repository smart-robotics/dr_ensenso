include(FindPkgConfig)

find_path(Pylon_INCLUDE_DIR
	NAMES pylon/PylonIncludes.h
	PATHS
		/opt/pylon5/include
	DOC "The Pylon include directories."
)

find_library(
	PylonBase_LIBRARY
	NAMES pylonbase
	PATHS
		/opt/pylon5/lib64
	DOC "The PylonBase libraries."
)

find_library(
	PylonUtility_LIBRARY
	NAMES pylonutility
	PATHS
		/opt/pylon5/lib64
	DOC "The PylonUtility libraries."
)

set(Pylon_INCLUDE_DIRS ${Pylon_INCLUDE_DIR})
set(Pylon_LIBRARIES    ${PylonBase_LIBRARY} ${PylonUtility_LIBRARY})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Pylon
	FOUND_VAR Pylon_FOUND
	REQUIRED_VARS Pylon_LIBRARIES Pylon_INCLUDE_DIRS
)

mark_as_advanced(Pylon_FOUND)
