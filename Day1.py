# part 1

calories = []

f = open("day1.txt", "r")
lines = f.readlines()
total = 0
for line in lines:
    if line[:-1].isdigit():
        total += int(line[:-1])
    else:
        calories.append(total)
        total = 0

print(max(calories))

# part 2

calories.sort(reverse=True)
print(sum(calories[:3]))
