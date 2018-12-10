find_path(CTemplate_INCLUDE_DIR
	NAMES ctemplate/template.h
	DOC "The directory where ctemplate includes reside"
)

find_library(CTemplate_LIBRARY
	NAMES ctemplate
	DOC "The ctemplate library"
)

set(CTemplate_INCLUDE_DIRS ${CTemplate_INCLUDE_DIR})
set(CTemplate_LIBRARIES    ${CTemplate_LIBRARY})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(CTemplate
	FOUND_VAR CTemplate_FOUND
	REQUIRED_VARS CTemplate_INCLUDE_DIR CTemplate_LIBRARY
)

mark_as_advanced(CTemplate_FOUND)
