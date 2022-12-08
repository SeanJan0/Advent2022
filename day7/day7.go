package main

import (
	"fmt"
	"os"
	"bufio"
	"strings"
	"strconv"
	"math"
)

type dir struct {
	name string
	size int
	// a field to store the subdirectories
	subDir map[string]*dir
	parent *dir
}



func main() {
	// part 1
	logs, err := os.Open("day7/day7.txt")
	if err != nil {
		fmt.Println(err)
	}
	defer logs.Close()

	root := dir{"head", -1, make(map[string]*dir), nil}
	curr := &root

	scanner := bufio.NewScanner(logs)
	for scanner.Scan() {
		command := scanner.Text()
		if command[:4] == "$ cd" {
			dirName := command[5:]
			if dirName == "/" {
				curr = &root
			} else if dirName == ".." {
				curr = curr.parent
			} else {
				curr = curr.subDir[dirName]
			}
		} else if command[:4] == "$ ls" {
			// do nothing
		} else if command[:3] == "dir" {
			dirName := command[4:]
			if _, exists := curr.subDir[dirName]; !exists {
				curr.subDir[dirName] = &dir{dirName, 0, make(map[string]*dir), curr}
			}
		} else {
			file := strings.Split(command, " ")
			fileSize, err := strconv.Atoi(file[0])
			if err != nil {
				fmt.Println(err)
			}
			fileName := file[1]
			curr.subDir[fileName] = &dir{fileName, fileSize, nil, curr}
		}
	}

	setSize(&root)
	fmt.Println(AddSizeU100000(&root))

	// part 2
	toDelete := root.size - 40000000
	fmt.Println(smallestDelete(&root, toDelete))
}

func setSize(curr *dir) {
	if curr.subDir == nil {
		return
	}
	for _, sub := range curr.subDir {
		setSize(sub)
		curr.size += sub.size
	}
}

func AddSizeU100000(curr *dir) int {
	if curr.subDir == nil {
		return 0
	}
	sum := 0
	if curr.size <= 100000 {
		sum += curr.size
	}
	for _, sub := range curr.subDir {
		sum += AddSizeU100000(sub)
	}
	return sum
}

func smallestDelete(curr *dir, min int) int {
	if curr.subDir == nil {
		return math.MaxInt32
	}
	smallest := math.MaxInt32
	if curr.size > min {
		smallest = curr.size
	}
	for _, sub := range curr.subDir {
		smallest = int(math.Min(float64(smallest), float64(smallestDelete(sub, min))))
	}
	return smallest
}