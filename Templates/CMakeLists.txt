cmake_minimum_required(VERSION 3.21)
project(ProjectName)

include(GNUInstallDirs)

add_executable(${PROJECT_NAME} main.cpp)
target_include_directories(${PROJECT_NAME} PUBLIC ${MY_INCLUDES})
install(TARGETS ${PROJECT_NAME})
