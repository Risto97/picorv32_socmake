include(../../../deps/deps.cmake)
include(../../cmake/fw_utils.cmake)
cmake_minimum_required(VERSION 3.25)
project(hello_world C ASM)


add_executable(${PROJECT_NAME}
    ../../sdk/crt0.S
    main.c
    )

# target_link_libraries(${PROJECT_NAME}
#     gcc
#     )

add_subdirectory("../../sdk/" sdk)
target_link_libraries(${PROJECT_NAME} picorv32_sdk)

gen_hex(${PROJECT_NAME})

