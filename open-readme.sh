#!/bin/bash
file_path=$(wslpath -w README.md)
powershell.exe -Command "Start-Process 'chrome' 'file:///$file_path'"

