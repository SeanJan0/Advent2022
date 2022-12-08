# part 1
heightmapRaw <- readLines("day8/day8.txt")
rows <- length(heightmapRaw)
cols <- nchar(heightmapRaw[1])
heightmap <- matrix(0, nrow = rows, ncol = cols, byrow = TRUE)
for (i in 1:rows) {
    for (j in 1:cols) {
        heightmap[i, j] <- as.numeric(substr(heightmapRaw[i], j, j))
    }
}
visiblemap <- matrix(FALSE, nrow = rows, ncol = cols, byrow = TRUE)
# loop through each row
for (i in 1:rows) {
    row <- heightmap[i, ]
    currHeight <- -1
    for (j in 1:cols) {
        if (row[j] > currHeight) {
            currHeight <- row[j]
            visiblemap[i, j] <- TRUE
        }
    }
    currHeight <- -1
    for (j in cols:1) {
        if (row[j] > currHeight) {
            currHeight <- row[j]
            visiblemap[i, j] <- TRUE
        }
    }
}

for(i in 1:cols) {
    col <- heightmap[, i]
    currHeight <- -1
    for (j in 1:rows) {
        if (col[j] > currHeight) {
            currHeight <- col[j]
            visiblemap[j, i] <- TRUE
        }
    }
    currHeight <- -1
    for (j in rows:1) {
        if (col[j] > currHeight) {
            currHeight <- col[j]
            visiblemap[j, i] <- TRUE
        }
    }
}
sum(visiblemap)

# part 2

scenicMap <- matrix(0, nrow = rows, ncol = cols, byrow = TRUE)
for (i in 3:rows - 1) {
    for (j in 3:cols - 1) {
        upScore <- 0
        for (k in (i - 1):1) {
            if (heightmap[k, j] < heightmap[i, j]) {
                upScore <- upScore + 1
            }
            if (heightmap[k, j] >= heightmap[i, j]) {
                upScore <- upScore + 1
                break
            }
        }
        downScore <- 0
        for (k in (i + 1):rows) {
            if (heightmap[k, j] < heightmap[i, j]) {
                downScore <- downScore + 1
            }
            if (heightmap[k, j] >= heightmap[i, j]) {
                downScore <- downScore + 1
                break
            }
        }
        leftScore <- 0
        for (k in (j - 1):1) {
            if (heightmap[i, k] < heightmap[i, j]) {
                leftScore <- leftScore + 1
            }
            if (heightmap[i, k] >= heightmap[i, j]) {
                leftScore <- leftScore + 1
                break
            }
        }
        rightScore <- 0
        for (k in (j + 1):cols) {
            if (heightmap[i, k] < heightmap[i, j]) {
                rightScore <- rightScore + 1
            }
            if (heightmap[i, k] >= heightmap[i, j]) {
                rightScore <- rightScore + 1
                break
            }
        }
        scenicMap[i, j] <- upScore * downScore * leftScore * rightScore
    }
}
max(scenicMap)