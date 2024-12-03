cmake_minimum_required(VERSION 3.25)
project(picorv32 NONE)

include(deps/deps.cmake)

add_ip(picorv32)

ip_sources(picorv32 VERILOG
    ${CMAKE_CURRENT_LIST_DIR}/picorv32.v
    )
