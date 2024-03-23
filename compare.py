## format: python3 compare.py argument1.csv argument2.csv

## in this code you should compare argument1.csv and argument2.csv whether they are equal or not

## note: answer1.csv is in answers folder

## you should see all row and columns as strings because sometimes 0 and "0" is possible you should return true again

## and if they are not equal you should print the different rows with an newline at the end of each row

import csv
import sys

def compare_csv(file1, file2):
    with open(file1, 'r') as f1, open(file2, 'r') as f2:
        reader1 = csv.reader(f1)
        reader2 = csv.reader(f2)

        rows1 = list(reader1)
        rows2 = list(reader2)

        if len(rows1) != len(rows2):
            return False, "Number of rows are different"

        for i, (row1, row2) in enumerate(zip(rows1, rows2), start=1):
            if len(row1) != len(row2):
                return False, f"Number of columns in row {i} are different"

            for j, (cell1, cell2) in enumerate(zip(row1, row2), start=1):
                if cell1.strip() != cell2.strip() and not (cell1.strip() == "0" and cell2.strip() == "0"):
                    return False, f"Value mismatch at row {i}, column {j}: '{cell1}' != '{cell2}'"

    return True, "Files are identical"

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python3 comparecsv.py <file1.csv> <file2.csv>")
        sys.exit(1)

    file1 = sys.argv[1]
    file2 = sys.argv[2]

    result, message = compare_csv(file1, file2)
    print(message)
    sys.exit(not result)


