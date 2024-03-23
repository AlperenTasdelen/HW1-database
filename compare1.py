## in this code you should compare result1.csv and answer1.csv whether they are equal or not

## note: answer1.csv is in answers folder

## you should see all row and columns as strings because sometimes 0 and "0" is possible you should return true again

## and if they are not equal you should print the different rows with an newline at the end of each row

import csv
import os

def compare1():
    with open('result1.csv', 'r') as file1:
        with open('answers/answer1.csv', 'r') as file2:
            csv_reader1 = csv.reader(file1)
            csv_reader2 = csv.reader(file2)
            for row_num, (row1, row2) in enumerate(zip(csv_reader1, csv_reader2), start=1):
                if row1 != row2:
                    print(f"Different rows at row number {row_num}:")
                    print(row1)
                    print(row2)
                    return False
    return True

if __name__ == '__main__':
    print(compare1())

