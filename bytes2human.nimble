# Package

version       = "0.1.0"
author        = "juancarlospaco"
description   = "Convert bytes to kilobytes, megabytes, gigabytes, etc."
license       = "LGPLv3"
srcDir        = "src"
bin           = @["bytes2human.nim"]

# Dependencies

requires "nim >= 0.18.1"
requires "pylib"
