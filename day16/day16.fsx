open System.Collections.Generic

// part 1

let input = System.IO.File.ReadAllLines "day16/day16.txt"

let mutable valves : string list = []
let rates = new Dictionary<string, int>()
let distances = new Dictionary<string, int>()

for line in input do
    let parts = line.Split [|' '|]
    let valve = parts.[1]
    valves <- valve :: valves
    let valueStr = parts.[4]
    let value = valueStr.[5..valueStr.Length - 2] |> int
    if value > 0 then
        rates.Add(valve, value)
    for i in 9..parts.Length - 1 do
        let oValve = parts.[i].[0..1]
        let pair = oValve+valve
        distances.Add(pair, 1)

for i in valves do
    let key = i + i
    distances.Add(key, 0)

for i in valves do
    for j in valves do
        let key = i + j
        if not (distances.ContainsKey(key)) then
            distances.Add(key, 1000)

for k in valves do
    for i in valves do
        for j in valves do
            let key1 = i + k
            let key2 = k + j
            let key3 = i + j
            let d1 = distances.[key1]
            let d2 = distances.[key2]
            let d3 = distances.[key3]
            if d1 + d2 < d3 then
                distances.[key3] <- d1 + d2

let copyRates (rates: Dictionary<string, int>) =
    let newRates = new Dictionary<string, int>()
    for ratePair in rates do
        newRates.Add(ratePair.Key, ratePair.Value)
    newRates

let rec p1 (time: int, node: string, rateDict: Dictionary<string, int>): int =
    let mutable max = 0
    for ratePair in rateDict do
        let rate = ratePair.Value
        let valve = ratePair.Key
        let key = valve + node
        let distance = distances.[key]
        let t = time - distance - 1
        let score = 0
        let newRateDict = copyRates rateDict
        newRateDict.Remove(valve) |> ignore
        if distance < time then
            let r = p1 (t, valve, newRateDict)
            let score = rate * t + r
            if score > max then
                max <- score
    max

//let ans1 = p1 (30, "AA", rates)
//printfn "%d" ans1

// part 2

let rec p2 (time: int, node: string, rateDict: Dictionary<string, int>): int =
    let mutable max = 0
    for ratePair in rateDict do
        let rate = ratePair.Value
        let valve = ratePair.Key
        let key = valve + node
        let distance = distances.[key]
        let t = time - distance - 1
        let score = 0
        let newRateDict = copyRates rateDict
        newRateDict.Remove(valve) |> ignore
        if distance < time then
            let r = p2 (t, valve, newRateDict)
            let score = rate * t + r
            if score > max then
                max <- score
    
    let ele = p1 (26, "AA", rateDict)
    if ele > max then
        max <- ele
    max

let ans2 = p2 (26, "AA", rates)
printfn "%d" ans2