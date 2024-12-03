
function(gen_hex EXE)
    get_target_property(BINARY_DIR ${EXE} BINARY_DIR)

    set(HEX_FILE ${BINARY_DIR}/${EXE}.hex)
    set(BIN_FILE ${BINARY_DIR}/${EXE}.bin)
    set(ASM_FILE ${BINARY_DIR}/${EXE}.asm)
    add_custom_command(TARGET ${EXE} POST_BUILD
        BYPRODUCTS ${HEX_FILE} ${BIN_FILE}
        COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:${EXE}> ${BIN_FILE}
        COMMAND ${CMAKE_OBJDUMP} -DgrwCS $<TARGET_FILE:${EXE}> > ${ASM_FILE}
        COMMAND python ${CMAKE_CURRENT_FUNCTION_LIST_DIR}/makehex.py ${BIN_FILE} 32768 > ${HEX_FILE}
        COMMENT "Generating hex file for ${EXE}"
        )

endfunction()
