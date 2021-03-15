import os
import sys
import re

def regExCheck(cardnum):
    reObj1 = re.compile(r'^(4|5|6)\d{3}-\d{4}-\d{4}-\d{4}$')   #Starting with 4 or 5 or 6, groups of 4 hyphenated digits
    reObj2 = re.compile(r'\d{16}')     #Only digits
    reObj3 = re.compile(r'(\d)\1{3,}')    #must NOT have 4 or more consecutive repeated digits
    match1 = reObj1.search(cardnum)
    match2 = reObj2.search(cardnum)

    if match1 != None or match2 != None:
        rem_hyph = cardnum.replace("-","")
        match3 = reObj3.search(rem_hyph)
        if match3 == None:
            return True
    else:
      return False

def c_length(ccnum):
    length = len(ccnum)
    if length <= 19 and length >= 16:
        if ccnum [0] == "4" or ccnum [0] == "5" or ccnum [0] == "6":
            return True
    else:
        return False

def line_num(content_list):
    try:
      int(content_list[0])
    except:
      print('Total number of credit cards should be a valid number')
      sys.exit()
    if int(content_list[0]) < 1 or int(content_list[0]) > 99 or int(content_list[0]) != len(content_list) - 1:
      print('First line of input should be a positive integer from 1 to 99 and should match the total number of credit card entries mentioned in the input file')
      sys.exit()
    if len(content_list) > 100 or len(content_list) < 2:
      print('Total number of entries should be between 1 to 100')
      sys.exit()

def main():
    filename = input("What is the name of your input file? \n")
    print('')
    cwd = os.getcwd()
    files = os.listdir(cwd)
    infile= open(filename, "r")
    content = infile.read()
    colist = list(filter(bool, content.split('\n')))
    line_num(colist)
    infile.close()

    cc = colist
    for i in range(len(cc)):
        if i == 0:
          continue
        regExOut = regExCheck(cc[i])
        c_len = c_length(cc[i])
        if c_len == True and regExOut == True:
            print("Valid")
        else:
            print("Invalid")


main()

