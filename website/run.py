#!/usr/bin/env python
import argparse
import os
import subprocess
import signal
import sys


def signal_handler(signal, frame):
    sys.exit(0)


signal.signal(signal.SIGINT, signal_handler)

parser = argparse.ArgumentParser()
parser.add_argument('--production', help='Run production server',
                    action='store_true')
args = parser.parse_args()
if args.production:
    print('Running production server')
    prod_env = os.environ.copy()
    prod_env['MIX_ENV'] = 'prod'
    prod_env['PORT'] = '4000'
    subprocess.call(['mix', 'deps.get', '--only', 'prod'])
    subprocess.call(['mix', 'compile'], env=prod_env)
    os.chdir('assets')
    subprocess.call(['brunch', 'build', '--production'])
    os.chdir('..')
    subprocess.call(['mix', 'phx.digest'])
    subprocess.call(['mix', 'ecto.migrate'], env=prod_env)
    subprocess.call(['mix', 'phx.server'], env=prod_env)
else:
    print('Running development server')
    subprocess.call(['mix', 'deps.get'])
    os.chdir('assets')
    subprocess.call(['brunch', 'build'])
    os.chdir('..')
    subprocess.call(['mix', 'ecto.migrate'])
    subprocess.call(['mix', 'phx.server'])
