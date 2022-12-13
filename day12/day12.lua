local json = require("json")

local clock = os.clock
function sleep(n)
    local t0 = clock()
    while clock() - t0 <= n do end
end

-- part 1
local map = {}
for line in io.lines("day12/day12.txt") do
    t = {}
    for i = 1, #line do
        t[i] = line:sub(i, i)
    end
    table.insert(map, t)
end

startPos = {}
endPos = {}

for x = 1, #map do
    for y = 1, #(map[x]) do
        if map[x][y] == "S" then
            startPos['x'] = x
            startPos['y'] = y
        end
        if map[x][y] == "E" then
            endPos['x']  = x
            endPos['y'] = y
        end
    end
end

map[startPos['x']][startPos['y']] = "a"
map[endPos['x']][endPos['y']] = "z"

function getNeighbors(x, y)
    local neighbors = {}
    if x > 1 and math.abs(string.byte(map[x-1][y]) - string.byte(map[x][y])) <= 1  then
        location = {}
        location['x'] = x-1
        location['y'] = y
        table.insert(neighbors, location)
    end
    if x < #map and string.byte(map[x+1][y]) - string.byte(map[x][y]) <= 1 then
        location = {}
        location['x'] = x+1
        location['y'] = y
        table.insert(neighbors, location)
    end
    if y > 1 and string.byte(map[x][y-1]) - string.byte(map[x][y]) <= 1 then
        location = {}
        location['x'] = x
        location['y'] = y-1
        table.insert(neighbors, location)
    end
    if y < #(map[x]) and string.byte(map[x][y+1]) - string.byte(map[x][y]) <= 1 then
        location = {}
        location['x'] = x
        location['y'] = y+1
        table.insert(neighbors, location)
    end
    return neighbors
end

function BFS(map, startPos, endPos)
    local toVisit = {}
    local visited = {}
    local startNode = {}
    startNode['location'] = startPos
    startNode['distance'] = 0
    table.insert(toVisit, startNode)
    startNodeKey = startPos['x'] .. "," .. startPos['y']
    visited[startNodeKey] = 0
    while #toVisit > 0 do
        local node = table.remove(toVisit, 1)
        if node['location']['x'] == endPos['x'] and node['location']['y'] == endPos['y'] then
            return node['distance']
        end
        local neighbors = getNeighbors(node['location']['x'], node['location']['y'])
        for i = 1, #neighbors do
            local neighbor = neighbors[i]
            local neighborKey = neighbor['x'] .. "," .. neighbor['y']
            if visited[neighborKey] == nil then
                local newNode = {}
                newNode['location'] = neighbor
                newNode['distance'] = node['distance'] + 1
                table.insert(toVisit, newNode)
                visited[neighborKey] = newNode['distance']
            end
        end  
    end
    return -1
end

print(BFS(map, startPos, endPos))

-- part 2

function getFastest(map, endPos)
    local min = 1000
    for x = 1, #map do
        for y = 1, #(map[x]) do
            if map[x][y] == 'a' then
                startPos = {}
                startPos['x'] = x
                startPos['y'] = y
                local distance = BFS(map, startPos, endPos)
                if distance < min and distance ~= -1 then
                    min = distance
                end
            end
        end
    end
    return min
end

print(getFastest(map, endPos))