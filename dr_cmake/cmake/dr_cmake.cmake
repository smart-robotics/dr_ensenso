if(NOT DEFINED DR_LOCAL_DIR)
	get_filename_component(DR_LOCAL_DIR "${CMAKE_SOURCE_DIR}" ABSOLUTE CACHE)
	message(STATUS "Setting DR_LOCALDIR to ${DR_LOCAL_DIR}.")
endif()

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14 -Wall -Wextra")
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/modules")

function(dr_filter_dirs local_dirs system_dirs)
	get_filename_component(DR_LOCAL_DIR "${DR_LOCAL_DIR}" ABSOLUTE)
	set(dr_local_dirs)
	set(dr_system_dirs)
	foreach(dir ${ARGN})
		get_filename_component(path "${dir}" ABSOLUTE)
		string(FIND "${path}" "${DR_LOCAL_DIR}/" is_subdir)
		if (${is_subdir} EQUAL 0)
			list(APPEND dr_local_dirs "${dir}")
		else()
			list(APPEND dr_system_dirs "${dir}")
		endif()
	endforeach(dir)
	set(${local_dirs}  ${dr_local_dirs}  PARENT_SCOPE)
	set(${system_dirs} ${dr_system_dirs} PARENT_SCOPE)
endfunction()


function(dr_include_directories)
	dr_filter_dirs(local system ${ARGN})
	include_directories(${local} SYSTEM ${system})
endfunction()

function(dr_add_gtest test_name)
	set(target "${PROJECT_NAME}_test_${test_name}")
	catkin_add_gtest(${target} ${ARGN})

	set(local_test_list  "${CMAKE_BINARY_DIR}/dr_gtests_${PROJECT_NAME}")
	set(global_test_list "${CMAKE_BINARY_DIR}/dr_gtests")

	# Delete global test list once per configure.
	get_property(test_list_deleted GLOBAL PROPERTY test_list_deleted SET)
	if (NOT test_list_deleted)
		file(REMOVE "${global_test_list}")
		set_property(GLOBAL PROPERTY test_list_deleted true)
	endif()

	# Delete package test list once per configure.
	get_property(test_list_deleted DIRECTORY PROPERTY test_list_deleted SET)
	if (NOT test_list_deleted)
		file(REMOVE "${local_test_list}")
		set_property(DIRECTORY PROPERTY test_list_deleted true)
	endif()

	if (NOT TARGET "dr_tests_${PROJECT_NAME}")
		add_custom_target("dr_tests_${PROJECT_NAME}")
	endif()
	add_dependencies("dr_tests_${PROJECT_NAME}" "${target}")

	# Write test name to package and global test list.
	get_target_property(target_dir ${target} RUNTIME_OUTPUT_DIRECTORY)
	file(APPEND "${local_test_list}"  "${target_dir}/${target}\n")
	file(APPEND "${global_test_list}" "${target_dir}/${target}\n")

endfunction()
