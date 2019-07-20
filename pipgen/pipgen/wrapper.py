import subprocess
import platform

def getOS():
    return platform.system()

def pipify(directory_name):
    """Organize a Python project into a pip package hierarchy (or create a new pip-compliant project)"""
    command = ["sh", "pipify.sh", directory_name]
    if (getOS() == 'Windows'):
        command = command[1:]
    subprocess.run(command, shell=True, stdin=subprocess.PIPE)

def depipify(directory_name):
    """Convert a package structure back to its original form - for testing only - shell script"""
    command = ["sh", "depipify.sh", directory_name]
    if (getOS() == 'Windows'):
        command = command[1:]
    subprocess.run(command, shell=True, stdin=subprocess.PIPE)

def update(directory_name, location='local'):
    """Build package and install in location - 'local', 'test', or 'prod' - shell script"""
    command = ["sh", "update.sh", directory_name, location]
    if (getOS() == 'Windows'):
        command = command[1:]
    subprocess.run(command, shell=True, stdin=subprocess.PIPE)
