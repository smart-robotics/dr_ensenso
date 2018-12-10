find_path(Assimp_INCLUDE_DIR
	NAMES assimp/Importer.hpp
	DOC "The directory where Assimp includes reside"
)

find_library(Assimp_LIBRARY
	NAMES assimp
	DOC "The Assimp library"
)

set(Assimp_INCLUDE_DIRS ${Assimp_INCLUDE_DIR})
set(Assimp_LIBRARIES    ${Assimp_LIBRARY})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Assimp
	FOUND_VAR Assimp_FOUND
	REQUIRED_VARS Assimp_INCLUDE_DIR Assimp_LIBRARY
)

mark_as_advanced(Assimp_FOUND)
