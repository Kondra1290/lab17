# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appLAb17_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appLAb17_autogen.dir\\ParseCache.txt"
  "appLAb17_autogen"
  )
endif()
