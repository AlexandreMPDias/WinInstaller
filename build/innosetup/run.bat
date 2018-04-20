@echo off
if EXIST Output (
    rm -rf Output\\*
)
iscc /Qp InnoSetup.iss
rmdir /s /q ..\\pyinstaller\\build ..\\pyinstaller\\dist