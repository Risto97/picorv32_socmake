

SUBDIRLIST(TEST_SUBDIRS ${CMAKE_CURRENT_LIST_DIR})

include(ExternalProject)
foreach(test ${TEST_SUBDIRS})
    ExternalProject_Add(${test}
        SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/${test}

        DOWNLOAD_COMMAND ""
        UPDATE_COMMAND ""
        PATCH_COMMAND ""
        INSTALL_COMMAND ""

        BUILD_ALWAYS TRUE

        CMAKE_ARGS
            -DCMAKE_TOOLCHAIN_FILE=${CMAKE_CURRENT_LIST_DIR}/../cmake/riscv_toolchain.cmake
            -DRISCV_TOOLCHAIN=${RISCV_TOOLCHAIN}

            # Use already fetched deps
            -DCPM_SoCMake_SOURCE=${SoCMake_SOURCE_DIR}

            # Dont do compiler checks to save time
            # -DCMAKE_C_COMPILER_WORKS=1
            # -DCMAKE_CXX_COMPILER_WORKS=1
            # -DCMAKE_ASM_COMPILER_WORKS=1
            # -DCMAKE_C_COMPILER_FORCED=1
            # -DCMAKE_CXX_COMPILER_FORCED=1

        )
    set_target_properties(${test} PROPERTIES EXCLUDE_FROM_ALL TRUE)

    ExternalProject_Get_Property(${test} BINARY_DIR)
    ExternalProject_Get_Property(${test} STAMP_DIR)
    list(APPEND TEST_CLEAN_COMMANDS 
        COMMAND make -C ${BINARY_DIR} clean
        COMMAND touch ${STAMP_DIR}/${test}-configure
        )

    list(APPEND hex_list ${BINARY_DIR}/${test}.hex)
    list(APPEND test_list ${test})
endforeach()

add_custom_target(clean-tests
    ${TEST_CLEAN_COMMANDS}
    )

set(hex_list ${hex_list} PARENT_SCOPE)
set(test_list ${test_list} PARENT_SCOPE)
