# Hàm kiểm tra đầu vào
function kiem_tra_input(n::Int, canh::Vector{Tuple{Int, Int}})
    if n <= 0
        error("Số đỉnh n phải lớn hơn 0")
    end
    for (u, v) in canh
        if u == v
            error("Đồ thị không được chứa khuyên (vertex u == v)")
        end
        if u < 1 || u > n || v < 1 || v > n
            error("Chỉ số đỉnh vượt quá giới hạn cho phép n")
        end
    end
    return true
end

# Hàm xây dựng danh sách kề
function xay_ke(n::Int, canh::Vector{Tuple{Int, Int}})
    kiem_tra_input(n, canh)
    ke = [Vector{Int}() for _ in 1:n]
    for (u, v) in canh
        push!(ke[u], v)
        push!(ke[v], u)
    end
    for i in 1:n
        sort!(ke[i])
        unique!(ke[i])
    end
    return ke
end

# Hàm lõi BFS tô màu
function bfs_to_mau!(ke::Vector{Vector{Int}}, s::Int, mau::Vector{Int})
    mau[s] = 0
    hang = [s]
    dau = 1
    while dau <= length(hang)
        u = hang[dau]
        dau += 1
        for v in ke[u]
            if mau[v] == -1
                mau[v] = 1 - mau[u]
                push!(hang, v)
            elseif mau[v] == mau[u]
                return (min(u, v), max(u, v))
            end
        end
    end
    return nothing
end

# Hàm tổng quát hai phía
function hai_phia(n::Int, canh::Vector{Tuple{Int, Int}})
    ke = xay_ke(n, canh)
    mau = fill(-1, n)
    
    for s in 1:n
        if mau[s] == -1
            res = bfs_to_mau!(ke, s, mau)
            if res !== nothing
                return (false, res, mau)
            end
        end
    end
    
    mau0 = [i for i in 1:n if mau[i] == 0]
    mau1 = [i for i in 1:n if mau[i] == 1]
    return (true, (mau0, mau1), mau)
end

# --- THỰC THI VÍ DỤ 1 (VD01) ---
println("--- CHAY CA KIEM THU: VD01 ---")
n_vd1 = 4
canh_vd1 = [(1, 2), (2, 3), (3, 4), (4, 1)]

println("Input n = $n_vd1, canh = $canh_vd1")
ket_qua_vd1 = hai_phia(n_vd1, canh_vd1)
println("Actual Output: ", ket_qua_vd1)
