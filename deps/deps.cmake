set(FETCHCONTENT_BASE_DIR ${CMAKE_CURRENT_LIST_DIR}/_deps CACHE INTERNAL "")

set(CPM_DOWNLOAD_VERSION 0.40.2)
include(${CMAKE_CURRENT_LIST_DIR}/CPM.cmake)

CPMAddPackage(
    NAME SoCMake  
    GIT_TAG 5212b1
    GIT_REPOSITORY "https://github.com/HEP-SoC/SoCMake.git"
    )