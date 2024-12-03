add_subdirectory("../" picorv32)

cmake_minimum_required(VERSION 3.25)
project(picorv32_testbench NONE)

#############################
#### TESTBENCH_EZ ###########
#############################
# add_ip(testbench_ez)
#
# ip_sources(${IP} VERILOG
#     ${CMAKE_CURRENT_LIST_DIR}/testbench_ez.v
#     )
# ip_compile_definitions(${IP} VERILOG
#     COMPRESSED_ISA
#     )
#
# ip_link(${IP} picorv32)

# iverilog(${IP})
# xcelium(${IP} ARGS -sv)

#############################
#### TESTBENCH ##############
#############################
add_ip(testbench)

ip_sources(${IP} VERILOG
    ${CMAKE_CURRENT_LIST_DIR}/testbench.v
    )
ip_compile_definitions(${IP} VERILOG
    COMPRESSED_ISA
    )

ip_link(${IP} picorv32)

# verilator(${IP} MAIN TOP_MODULE testbench)

add_subdirectory("../firmware/tests/" tests)

set_property(GLOBAL PROPERTY CTEST_TARGETS_ADDED 1) # Remove additional targets
include(CTest)
enable_testing()

modelsim(${IP} NO_RUN_TARGET)
iverilog(${IP} NO_RUN_TARGET)
xcelium(${IP} NO_RUN_TARGET)
verilator(${IP} MAIN TOP_MODULE testbench VERILATOR_ARGS -Wno-fatal --timing NO_RUN_TARGET)

foreach(test_name hexfile IN ZIP_LISTS test_list hex_list)
    foreach(sim IN ITEMS modelsim iverilog verilator xcelium)
        unset(__additional_args)
        if(sim STREQUAL verilator)
            set(__additional_args MAIN)
        endif()
        cmake_language(CALL ${sim} ${IP} ${__additional_args}
            RUN_ARGS +firmware=${hexfile}
            RUN_TARGET_NAME run_${test_name}_${sim}
            )
        add_dependencies(run_${test_name}_${sim} ${test_name})
        add_test(NAME run_${test_name}_${sim}
            COMMAND make run_${test_name}_${sim}
            )
    endforeach()

endforeach()


#############################
#### TESTBENCH VERILATOR ####
#############################
#
# enable_language(CXX)
# add_executable(testbench_verilator
#     ${CMAKE_CURRENT_LIST_DIR}/testbench.cc
#     )
# 

help()
