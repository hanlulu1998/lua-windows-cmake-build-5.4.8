# Lua Windows Cmake Build 5.4.8
本项目仅适配**Windows**系统下的**Lua5.4.x**编译安装，请确保您的系统已经安装了**Cmake**（版本大于**3.20**）和**MSVC**编译环境。

1. 安装方式如下：
```bash
./install.bat C:/your/path/to/install/directory
```
2. 相关说明：
- 默认在CMakeLists.txt中**关闭**了`LUA_USE_C89`（使用C89语法兼容）和`BUILD_SHARED_LIBS`（构建共享库），并**开启**了`LUA_COMPAT_5_3`（Lua5.3兼容），如需修改请自行修改CMakeLists.txt。
- `src`中的原始代码来自：[https://github.com/lua/lua](https://github.com/lua/lua)，项目中备份了`onelua.c`和`luaconf.h`（后缀为`.bak`），并根据`CMakeLists.txt`中的配置在`luaconf.h`基础上创建了`luaconf.h.in`。
3. 注意事项：
如果您的`MSVC`版本较低，编译失败时请开启`LUA_USE_C89`。

# Lua Windows Cmake Build 5.4.8
This project is only compatible with **Lua 5.4.x** on **Windows**. Please make sure your system has CMake (version ≥**3.20**) and the **MSVC** build environment installed.

1. Installation
Run the installation script as follows:
```bash
./install.bat C:/your/path/to/install/directory
```

2. Notes
- By default, `LUA_USE_C89`(C89 syntax compatibility) and `BUILD_SHARED_LIBS`(build shared libraries) are **disabled** in `CMakeLists.txt`, while `LUA_COMPAT_5_3`(Lua 5.3 compatibility) is **enabled**. If you need to change these settings, please modify `CMakeLists.txt` accordingly.
- The original source code in the src directory comes from: [https://github.com/lua/lua](https://github.com/lua/lua). The project includes backups of `onelua.c` and `luaconf.h` (with `.bak` extensions), and creates `luaconf.h.in` based on `luaconf.h` according to the configurations in `CMakeLists.txt`.

3. Important
If your `MSVC` version is too low and the build fails, try enabling `LUA_USE_C89`.