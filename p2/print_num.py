with open("test_cases/test_5.txt", "r") as input:
    for line in input:
        nums = line.split(" ")

with open("test_cases/test_5.txt", "w") as output:
    for num in nums:
        output.write(str(num)+"\n")