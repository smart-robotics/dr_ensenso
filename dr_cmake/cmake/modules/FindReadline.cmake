find_path(Readline_INCLUDE_DIR
	NAMES readline/readline.h
	DOC "The directory where readline includes reside"
)

find_library(Readline_LIBRARY
	NAMES readline
	DOC "The readline library"
)

set(Readline_INCLUDE_DIRS ${Readline_INCLUDE_DIR})
set(Readline_LIBRARIES    ${Readline_LIBRARY})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Readline
	FOUND_VAR Readline_FOUND
	REQUIRED_VARS Readline_INCLUDE_DIR Readline_LIBRARY
)

mark_as_advanced(Readline_FOUND)
