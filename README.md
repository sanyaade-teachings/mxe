MXE (M cross environment) for Performous
========================================

This repository contains MXE with some modifications that allow it to cross-compile Performous' Windows dependencies.
The main issue is that CMake can't resolve recursive static lib dependencies, so we build most of the deps as DLLs.

