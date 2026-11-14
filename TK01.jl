# =====================================================================
# CA TỰ THIẾT KẾ 1 (TK01): Đồ thị đối xứng chẵn 6 đỉnh (Thỏa mãn hai phía)
# Sinh viên: Vũ Thị Thư — MSSV: N24DCDT092
# =====================================================================

function kiem_tra_input(n::Int, canh::Vector{Tuple{Int, Int}})
    for (u, v) in canh
        if u == v error("Không chứa khuyên") end
        if u < 1 || u > n || v < 1 || v > n error("Vượt quá giới hạn") end
    end
    return true
end

function xay_ke(n::Int, canh::Vector{Tuple{Int, Int}})
    kiem_tra_input(n, canh)
    ke = [Vector{Int}() for _ in 1:n]
    for (u, v) in canh
        if !(v in ke[u]) push!(ke[u], v) end
        if !(u in ke[v]) push!(ke[v], u) end
    end
    for i in 1:n sort!(ke[i]) end
    return ke
end

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

function hai_phia(n::Int, canh::Vector{Tuple{Int, Int}})
    ke = xay_ke(n, canh)
    mau = fill(-1, n)
    for s in 1:n
        if mau[s] == -1
            res = bfs_to_mau!(ke, s, mau)
            if res !== nothing return (false, res, mau) end
        end
    end
    mau0 = [i for i in 1:n if mau[i] == 0]
    mau1 = [i for i in 1:n if mau[i] == 1]
    return (true, (mau0, mau1), mau)
end

# --- THỰC THI TK01 ---
println("--- CHAY CA KIEM THU: TK01 ---")
n_tk1 = 6
canh_tk1 = [(1, 2), (1, 3), (2, 4), (3, 5), (4, 6), (5, 6)]

println("Input: n = $n_tk1, canh = $canh_tk1")
ket_qua_tk1 = hai_phia(n_tk1, canh_tk1)
println("Actual Output: ", ket_qua_tk1)