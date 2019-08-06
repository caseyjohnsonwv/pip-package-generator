import subprocess

def test():
    print("Test")

def pipify(directory_name):
    """Organize a Python project into a pip package hierarchy (or create a new pip-compliant project)"""
    command = ["sh", "pipify.sh", directory_name]
    subprocess.run(command)

def depipify(directory_name):
    """Convert a package structure back to its original form - for testing only - shell script"""
    command = ["sh", "depipify.sh", directory_name]
    subprocess.run(command)

def update(directory_name, location='local'):
    """Build package and install in location - 'local', 'test', or 'prod' - shell script"""
    command = ["sh", "pippush.sh", directory_name, location]
    subprocess.run(command)
