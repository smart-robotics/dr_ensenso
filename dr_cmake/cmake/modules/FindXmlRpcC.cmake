# First find the config script from which to obtain other values.
find_program(XmlRpcC_CONFIG NAMES xmlrpc-c-config)

set(XmlRpcC_REQUIRED_VARS)
mark_as_advanced(XmlRpcC_REQUIRED_VARS)
list(APPEND XmlRpcC_REQUIRED_VARS "XmlRpcC_CONFIG")
list(APPEND XmlRpcC_REQUIRED_VARS "XmlRpcC_INCLUDE_DIRS")

# Lookup the include directories needed for the components requested.
if(XmlRpcC_CONFIG)
	# Use the newer EXECUTE_PROCESS command if it is available.
	execute_process(
		COMMAND ${XmlRpcC_CONFIG} ${XmlRpcC_FIND_COMPONENTS} "--cflags"
		OUTPUT_VARIABLE XmlRpcC_CONFIG_CFLAGS
		OUTPUT_STRIP_TRAILING_WHITESPACE
		RESULT_VARIABLE XmlRpcC_CONFIG_RESULT
	)

	# Parse the include flags.
	if("${XmlRpcC_CONFIG_RESULT}" STREQUAL "0")
		# Convert the compile flags to a CMake list.
		string(REGEX REPLACE " +" ";"
			XmlRpcC_CONFIG_CFLAGS "${XmlRpcC_CONFIG_CFLAGS}")

		# Look for -I options.
		set(XmlRpcC_INCLUDE_DIRS)
		foreach(flag ${XmlRpcC_CONFIG_CFLAGS})
			if("${flag}" MATCHES "^-I(.+)")
				file(TO_CMAKE_PATH "${CMAKE_MATCH_1}" DIR)
				list(APPEND XmlRpcC_INCLUDE_DIRS "${DIR}")
			endif()
		endforeach()
	else()
		set(XmlRpcC_CONFIG false)
	endif()
endif()

# Lookup the libraries needed for the components requested.
if(XmlRpcC_CONFIG)
	# Use the newer EXECUTE_PROCESS command if it is available.
	execute_process(
		COMMAND ${XmlRpcC_CONFIG} ${XmlRpcC_FIND_COMPONENTS} --libs
		OUTPUT_VARIABLE XmlRpcC_CONFIG_LIBS
		OUTPUT_STRIP_TRAILING_WHITESPACE
		RESULT_VARIABLE XmlRpcC_CONFIG_RESULT
	)

	# Parse the library names and directories.
	if("${XmlRpcC_CONFIG_RESULT}" STREQUAL "0")
		string(REGEX REPLACE " +" ";" XmlRpcC_CONFIG_LIBS "${XmlRpcC_CONFIG_LIBS}")

		# Look for -L flags for directories and -l flags for library names.
		set(XmlRpcC_LIBRARY_DIRS)
		set(XmlRpcC_LIBRARY_NAMES)
		foreach(flag ${XmlRpcC_CONFIG_LIBS})
			if("${flag}" MATCHES "^-L(.+)")
				file(TO_CMAKE_PATH "${CMAKE_MATCH_1}" DIR)
				list(APPEND XmlRpcC_LIBRARY_DIRS "${DIR}")
			elseif("${flag}" MATCHES "^-l(.+)")
				list(APPEND XmlRpcC_LIBRARY_NAMES "${CMAKE_MATCH_1}")
			endif()
		endforeach()

		# Search for each library needed using the directories given.
		set(XmlRpcC_LIBRARIES)
		foreach(name ${XmlRpcC_LIBRARY_NAMES})
			# Look for this library.
			find_library(XmlRpcC_${name}_LIBRARY
				NAMES ${name}
				HINTS ${XmlRpcC_LIBRARY_DIRS}
			)

			mark_as_advanced(XmlRpcC_${name}_LIBRARY)
			list(APPEND XmlRpcC_REQUIRED_VARS "XmlRpcC_${name}_LIBRARY")
			list(APPEND XmlRpcC_LIBRARIES "${XmlRpcC_${name}_LIBRARY}")
		endforeach()
	else()
		set(XmlRpcC_CONFIG false)
	endif()
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(XmlRpcC
	FOUND_VAR XmlRpcC_FOUND
	REQUIRED_VARS ${XmlRpcC_REQUIRED_VARS}
)

mark_as_advanced(XmlRpcC_FOUND)
