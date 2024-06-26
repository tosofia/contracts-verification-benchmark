"""
Operates on either a single file or every file within a directory.
"""
from pathlib import Path
import argparse
import glob
import os

import utils
from tools.solcmc import run_all

DEFAULT_TIMEOUT = '10m'
DEFAULT_SOLVER = 'z3'


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument(
            '--contracts',
            '-c',
            help='Contracts dir or contract file.',
            required=True)
    parser.add_argument(  # build/
            '--output',
            '-o',
            help='Output directory.')
    parser.add_argument(
            '--timeout',
            '-t',
            help='Timeout time.')
    parser.add_argument(
            '--solver',
            '-s',
            help='Model checker: {z3, eld}')
    parser.add_argument(
            '--version',
            '-v',
            help='Run experiments on this version only.')
    parser.add_argument(
            '--property',
            '-p',
            help='Run experiments on this property only.')
    args = parser.parse_args()

    contracts = Path(args.contracts)

    # Get contracts paths
    contracts_paths = (
            glob.glob(f'{contracts}/*.sol')
            if os.path.isdir(contracts)
            else [str(contracts)])

    if args.version:
        contracts_paths = [c for c in contracts_paths if args.version in c]

    if args.property:
        contracts_paths = [c for c in contracts_paths if args.property in c]

    timeout = args.timeout if args.timeout else DEFAULT_TIMEOUT
    solver = args.solver if args.solver else DEFAULT_SOLVER

    if args.output:
        output_dir = Path(args.output)
        logs_dir = output_dir.joinpath('logs/')

        outcomes = run_all(contracts_paths, timeout, logs_dir, solver)

        out_csv = [utils.OUT_HEADER]
        for id in outcomes.keys():
            p = id.split('_')[0]
            v = id.split('_')[1]
            out_csv.append([p, v, outcomes[id]])

        utils.write_csv(output_dir.joinpath('out.csv'), out_csv)
    else:
        run_all(contracts_paths, timeout, solver=solver)
