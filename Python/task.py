import subprocess
import os

def run_task(directory, repo):

    subprocess.run(['sudo', 'mkdir', '-p', directory], check=True)
    os.chdir(directory)
    subprocess.run(['sudo', 'git', 'clone', repo])

if __name__ == "__main__":
    repo = 'https://github.com/TankChirag-1212/React_Task'
    directory = '/var/www/html/my-app'
    print("cloning of repo is successful")
