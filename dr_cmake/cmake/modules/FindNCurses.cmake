find_path(NCurses_INCLUDE_DIR
	NAMES ncurses.h
	DOC "The directory where ncurses includes reside"
)

find_library(NCurses_LIBRARY
	NAMES ncurses
	DOC "The ncurses library"
)

set(NCurses_INCLUDE_DIRS ${NCurses_INCLUDE_DIR})
set(NCurses_LIBRARIES    ${NCurses_LIBRARY})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(NCurses
	FOUND_VAR NCurses_FOUND
	REQUIRED_VARS NCurses_INCLUDE_DIR NCurses_LIBRARY
)

mark_as_advanced(NCurses_FOUND)
