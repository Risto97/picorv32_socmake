include(../../../deps/deps.cmake)
include(../../cmake/fw_utils.cmake)

cmake_minimum_required(VERSION 3.25)
project(coremark ASM C)

include(deps/deps.cmake)

add_executable(${PROJECT_NAME}
    ../../sdk/crt0.S
    ${coremark_SOURCE_DIR}/core_list_join.c
    ${coremark_SOURCE_DIR}/core_main.c
    ${coremark_SOURCE_DIR}/core_matrix.c
    ${coremark_SOURCE_DIR}/core_state.c
    ${coremark_SOURCE_DIR}/core_util.c

    port/core_portme.c
    port/ee_printf.c
    # port/cvt.c
    )

target_include_directories(${PROJECT_NAME} PRIVATE
    port
    ${coremark_SOURCE_DIR}
    )

target_compile_definitions(${PROJECT_NAME} PUBLIC
    TOTAL_DATA_SIZE=2000
    MAIN_HAS_NOARGC=1
    PERFORMANCE_RUN=1
    ITERATIONS=10
    CLOCKS_PER_SEC=25000000
    )

add_subdirectory("../../sdk/" sdk)
target_link_libraries(${PROJECT_NAME} 
    picorv32_sdk
    gcc
    m
)

gen_hex(${PROJECT_NAME})
