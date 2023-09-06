"""
Script Name: mdtable_gen
Description:
    Creates a markdown table from a csv file with this scheme:
    cols, rows, data.

Usage:
    python mdtable_gen.py --input file.csv
"""

import argparse
import csv
import sys


MIN_CELL_WIDTH = 5
MARGIN = 2   # between cells


def gen_from_dict(data):
    """
    Writes the markdown table as a list of rows.

    Args:
        data (dict): { (col, row): data }

    Returns:
        str: markdown table
    """

    cols = sorted(set([c for c, _ in data.keys()]))
    rows = sorted(set([r for _, r in data.keys()]))

    max_c_length = max([len(c) for c in cols])
    max_r_length = max([len(r) for r in rows])

    cell_width = max(
            MIN_CELL_WIDTH,
            max_c_length + MARGIN,
            max_r_length + MARGIN
    )

    # Create the header row
    header = (
            "|" + " " * (max_r_length + 6) + "| " +
            "| ".join([c + " "*(cell_width-len(c)-1) for c in cols]) +
            "|"
    )
    separator = (
            "|" + "-" * (max_r_length + 6) + "|" +
            "|".join([
                "-" * len(header.split('|')[i])
                for i in range(2, len(cols) + 2)
            ]) + "|"
    )

    # Create the rows
    table_rows = []
    for r in rows:
        row_str = "| **" + r + "** |"
        for c in cols:
            d = data[(c,r)]
            if d is not None:
                row_str += " " + d + " " * (cell_width-len(d)-1) + "|"
            else:
                row_str += cell_width

        table_rows.append(row_str)

    # Combine everything into a Markdown table
    mdtable = "\n".join([header, separator] + table_rows)

    return mdtable 


def gen_from_csv(input_file):
    mdtable = []

    # Read data from input file
    with open(input_file, 'r') as f:
        csv_reader = csv.reader(f)

        next(csv_reader)

        data = {}      # (c,r): data

        for row in csv_reader:
            c, r, d = row[0], row[1], row[2]
            data.update({(c,r): d})

        mdtable = gen_from_dict(data)

    return mdtable


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
            '--input',
            '-i',
            help='CSV input file',
            required=True
    )
    args = parser.parse_args()

    mdtable = gen_from_csv(args.input)

    sys.stdout.write(mdtable)
