
include(../../../deps/deps.cmake)
include(../../cmake/fw_utils.cmake)
# set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_LIST_DIR}/cmake/riscv_toolchain.cmake)
cmake_minimum_required(VERSION 3.25)
project(full_test CXX C ASM)


add_executable(${PROJECT_NAME}
    start.S
    hello.c
    irq.c
    print.c
    sieve.c
    stats.c
    multest.c
    )

target_include_directories(${PROJECT_NAME} PRIVATE ../)

set(TESTS 
    tests/addi.S
    tests/beq.S
    tests/bne.S
    tests/j.S
    tests/lui.S
    tests/mul.S
    tests/sb.S
    tests/slti.S
    tests/srl.S
    tests/add.S
    tests/bge.S
    tests/div.S
    tests/lb.S
    tests/lw.S
    tests/ori.S
    tests/sh.S
    tests/slt.S
    tests/sub.S
    tests/andi.S
    tests/bgeu.S
    tests/divu.S
    tests/lbu.S
    tests/mulh.S
    tests/or.S
    tests/simple.S
    tests/srai.S
    tests/sw.S
    tests/and.S
    tests/blt.S
    tests/jalr.S
    tests/lh.S
    tests/mulhsu.S
    tests/rem.S
    tests/slli.S
    tests/sra.S
    tests/xori.S
    tests/auipc.S
    tests/bltu.S
    tests/jal.S
    tests/lhu.S
    tests/mulhu.S
    tests/remu.S
    tests/sll.S
    tests/srli.S
    tests/xor.S
    )

foreach(test ${TESTS})
    get_filename_component(testname ${test} NAME_WE)
    add_library(${testname} OBJECT
        ${test}
        )
    target_compile_definitions(${testname} PRIVATE
        -DTEST_FUNC_NAME=${testname}
        -DTEST_FUNC_TXT="${testname}"
        -DTEST_FUNC_RET=${testname}_ret
        )
    target_link_libraries(${PROJECT_NAME} ${testname})
endforeach()

target_link_libraries(${PROJECT_NAME}
    gcc
    )

add_subdirectory("../../sdk/" sdk)
target_link_libraries(${PROJECT_NAME} picorv32_sdk)

gen_hex(${PROJECT_NAME})
