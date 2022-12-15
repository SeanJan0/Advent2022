# part 1

function parse_packet(packet::AbstractString)
    if cmp(packet, "[]") == 0
        return []
    end
    if tryparse(Int, packet) != nothing
        return tryparse(Int, packet)
    end
    prev = 2
    level = 1
    packet_arr = []
    for i in 2:(length(packet))
        if packet[i] == '['
            level += 1
        end
        if packet[i] == ']'
            level -= 1
        end
        if packet[i] == ',' && level == 1
            push!(packet_arr, parse_packet(packet[prev:i-1]))
            prev = i + 1
        end
    end
    push!(packet_arr, parse_packet(packet[prev:end-1]))
    return packet_arr
end

function compare_packet(lside::AbstractArray, rside::AbstractArray)
    result = 0
    i = 1
    while result == 0
        if i > length(lside) && i > length(rside)
            return 0
        end
        if i > length(lside)
            return 1
        end
        if i > length(rside)
            return -1
        end
        result = compare_packet(lside[i], rside[i])
        i += 1
    end
    return result
end

function compare_packet(lside::Int, rside::Int)
    if lside < rside
        return 1
    end
    if lside > rside
        return -1
    end
    return 0
end

function compare_packet(lside::Int, rside::AbstractArray)
    return compare_packet([lside], rside)
end

function compare_packet(lside::AbstractArray, rside::Int)
    return compare_packet(lside, [rside])
end

f = readlines("day13/day13.txt")
filter!(l -> length(l) > 0, f)
compiled_packets = []
for packet in f
    push!(compiled_packets, parse_packet(packet))
end

function part_1(packets)
    sum = 0
    for i in 1:(length(packets) / 2)
        index = Int(2 * i - 1)
        if compare_packet(packets[index], packets[index + 1]) == 1
            sum += i
        end
    end
    return Int(sum)
end

println(part_1(compiled_packets))

# part 2

push!(compiled_packets, parse_packet("[[2]]"))
push!(compiled_packets, parse_packet("[[6]]"))

function sort(packets)
    for i in 1:(length(packets) - 1)
        for j in (i + 1):length(packets)
            if compare_packet(packets[i], packets[j]) == -1
                temp = packets[i]
                packets[i] = packets[j]
                packets[j] = temp
            end
        end
    end
    return packets
end

function part_2(packets)
    sorted_packets = sort(packets)
    index_1 = findall(x -> x == parse_packet("[[2]]"), sorted_packets)
    index_2 = findall(x -> x == parse_packet("[[6]]"), sorted_packets)
    return (index_1[1]) * (index_2[1])
end

println(part_2(compiled_packets))
