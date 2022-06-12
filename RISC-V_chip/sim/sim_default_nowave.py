import sys
import filecmp
import subprocess
import sys
import os

def main():
    #print(sys.argv[0] + ' ' + sys.argv[1] + ' ' + sys.argv[2])

    # 1.compile rtl files
    cmd = r'python compile_rtl.py' + r' ..'
    f = os.popen(cmd)
    f.close()

    # 2.run vvp out.vvp
    vvp_cmd = [r'vvp']
    vvp_cmd.append(r'out.vvp')
    process = subprocess.Popen(vvp_cmd)
    try:
        process.wait(timeout=10)
    except subprocess.TimeoutExpired:
        print('!!!Fail, vvp exec timeout!!!')
        process.terminate()


if __name__ == '__main__':
    sys.exit(main())