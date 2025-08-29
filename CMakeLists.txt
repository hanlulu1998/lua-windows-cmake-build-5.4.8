cmake_minimum_required(VERSION 3.20)
project(lua LANGUAGES C)

option(LUA_USE_C89 "Use only C89 features." OFF)
option(LUA_COMPAT_5_3 "Enable backwards compatibility options with lua-5.3." ON)

set(INSTALL_DIR ${CMAKE_INSTALL_PREFIX})
set(INSTALL_BIN ${INSTALL_DIR}/bin)
set(INSTALL_LIB ${INSTALL_DIR}/lib)
set(INSTALL_INC ${INSTALL_DIR}/include)

set(LUA_MODULE_SUFFIX ${CMAKE_SHARED_MODULE_SUFFIX})
set(LUA_LDIR lib)
set(LUA_CDIR lib)
set(LUA_DIR ${INSTALL_DIR}/)

set(LUA_PATH_DEFAULT "./?.lua;${LUA_DIR}${LUA_LDIR}/?.lua;${LUA_DIR}${LUA_LDIR}/?/init.lua")
set(LUA_CPATH_DEFAULT "./?${LUA_MODULE_SUFFIX};${LUA_DIR}${LUA_CDIR}/?${LUA_MODULE_SUFFIX};${LUA_DIR}${LUA_CDIR}/loadall${LUA_MODULE_SUFFIX}")

if(WIN32 AND NOT CYGWIN)
  # Windows systems
  option(LUA_USE_WINDOWS "Windows specific build." ON)
  option(LUA_BUILD_AS_DLL "Build Lua library as Dll." ${BUILD_SHARED_LIBS})

  # Paths (Double escapes needed)
  set(LUA_DIRSEP "\\\\")
  string(REPLACE "/" ${LUA_DIRSEP} LUA_DIR "${LUA_DIR}")
  string(REPLACE "/" ${LUA_DIRSEP} LUA_PATH_DEFAULT "${LUA_PATH_DEFAULT}")
  string(REPLACE "/" ${LUA_DIRSEP} LUA_CPATH_DEFAULT "${LUA_CPATH_DEFAULT}")
else()
  message(FATAL_ERROR "Current cmake config is not supported on Posix systems.")
endif()

configure_file(src/luaconf.h.in ${CMAKE_CURRENT_BINARY_DIR}/luaconf.h)

include_directories(src ${CMAKE_CURRENT_BINARY_DIR})

file(GLOB SRC_LIB src/*.c)
list(REMOVE_ITEM SRC_LIB "${CMAKE_CURRENT_SOURCE_DIR}/src/lua.c")


add_library(liblua ${SRC_LIB})
set_target_properties(liblua PROPERTIES OUTPUT_NAME lua)

if(LUA_BUILD_AS_DLL)
  set_target_properties(liblua PROPERTIES COMPILE_DEFINITIONS LUA_BUILD_AS_DLL)
endif()

add_executable(lua src/lua.c)
target_link_libraries(lua liblua)

install(TARGETS lua DESTINATION ${INSTALL_BIN})
install(TARGETS liblua DESTINATION ${INSTALL_LIB})
install(FILES src/lualib.h src/lauxlib.h src/lua.h ${CMAKE_CURRENT_BINARY_DIR}/luaconf.h DESTINATION ${INSTALL_INC})
