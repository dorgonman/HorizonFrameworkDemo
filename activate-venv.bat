@echo off
REM Activate virtual environment for HorizonFrameworkDemo
if exist ".venv\Scripts\activate.bat" (
    call .venv\Scripts\activate.bat
    echo Virtual environment activated
    python --version
) else (
    echo Virtual environment not found at .venv\
    echo Create it with: python -m venv .venv
)
