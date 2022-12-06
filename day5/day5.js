const { readFileSync } = require('fs'); 

var contents = readFileSync("./day5/day5.txt", 'utf-8');
contents = contents.split("\r").join("").split("\n");

// part 1

var stacks = []
for (var i = 0; i < 9; i++) {
    stacks.push([])
}

var i = 0
var readingPile = true;
while (readingPile) {
    var iToPut = 0
    for (var j = 1; j < contents[i].length; j += 4) {
        if (contents[i].charAt(j) !== " ") {
            stacks[iToPut].push(contents[i].charAt(j))
        }
        iToPut++
    }
    i++
    if (!isNaN(contents[i].charAt(1))) {
        readingPile = false
    }
}

for (var i = 0; i < stacks.length; i++) {
    stacks[i].reverse()
}

var stacksCopy = JSON.parse(JSON.stringify(stacks))

i += 1
var startInstruction = i

while (i < contents.length) {
    var instructions = contents[i].split(" ")
    var amount = parseInt(instructions[1])
    var startStack = parseInt(instructions[3]) - 1
    var endStack = parseInt(instructions[5]) - 1
    for (var j = 0; j < amount; j++) {
        stacks[endStack].push(stacks[startStack].pop())
    }
    i++
}

var output = ""
for (var i = 0; i < stacks.length; i++) {
    output += stacks[i][stacks[i].length - 1]
}
console.log(output)

// part 2

var stacks = stacksCopy
i = startInstruction

while (i < contents.length) {
    var instructions = contents[i].split(" ")
    var amount = parseInt(instructions[1])
    var startStack = parseInt(instructions[3]) - 1
    var endStack = parseInt(instructions[5]) - 1
    var toMove = stacks[startStack].splice(stacks[startStack].length - amount, amount)
    stacks[endStack] = stacks[endStack].concat(toMove)
    i++
}

var output = ""
for (var i = 0; i < stacks.length; i++) {
    output += stacks[i][stacks[i].length - 1]
}
console.log(output)