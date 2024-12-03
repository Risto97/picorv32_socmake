
add_library(picorv32_sdk INTERFACE)

target_include_directories(picorv32_sdk INTERFACE
    ${CMAKE_CURRENT_LIST_DIR}/include
    )

target_link_options(${PROJECT_NAME} PUBLIC
        -T${CMAKE_CURRENT_LIST_DIR}/sections.lds
        )
