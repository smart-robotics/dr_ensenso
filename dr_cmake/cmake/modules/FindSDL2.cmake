find_path(SDL2_INCLUDE_DIR
	NAMES SDL2/SDL.h
	DOC "The directory where SDL includes reside"
)

find_library(SDL2_LIBRARY
	NAMES SDL2
	DOC "The main SDL2 library"
)

find_library(SDL2_IMAGE_LIBRARY
	NAMES SDL2_image
	DOC "The SDL2 image library"
)

find_library(SDL2_TTF_LIBRARY
	NAMES SDL2_ttf
	DOC "The SDL2 true type font library"
)

set(SDL2_INCLUDE_DIRS ${SDL2_INCLUDE_DIR})
set(SDL2_LIBRARIES    ${SDL2_LIBRARY} ${SDL2_IMAGE_LIBRARY} ${SDL2_TTF_LIBRARY})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(SDL2
	FOUND_VAR SDL2_FOUND
	REQUIRED_VARS SDL2_INCLUDE_DIR SDL2_LIBRARY SDL2_IMAGE_LIBRARY SDL2_TTF_LIBRARY
)

mark_as_advanced(SDL2_FOUND)
