# ==========================================
# FILE: hai_phia.jl
# Mô đun kiểm tra đồ thị hai phía bằng BFS
# ==========================================

# 1. Kiểm tra tính hợp lệ của input (đỉnh, danh sách cạnh, khuyên, cạnh lặp)
function kiem_tra_input(n::Int, canh::Vector{Tuple{Int, Int}})
    if n <= 0
        error("Số đỉnh n phải lớn hơn 0")
    end
    for (u, v) in canh
        if u < 1 || u > n || v < 1 || v > n
            error("Đỉnh nằm ngoài khoảng hợp lệ [1, $n]")
        end
        if u == v
            error("Đồ thị không được chứa cạnh khuyên")
        end
    end
    # Kiểm tra cạnh lặp
    tap_canh = Set{Tuple{Int, Int}}()
    for (u, v) in canh
        edge = u < v ? (u, v) : (v, u)
        if edge in tap_canh
            error("Đồ thị không được chứa cạnh lặp")
        end
        push!(tap_canh, edge)
    end
    return true
end

# 2. Xây dựng danh sách kề từ danh sách cạnh
function xay_ke(n::Int, canh::Vector{Tuple{Int, Int}})
    kiem_tra_input(n, canh)
    ke = [Int[] for _ in 1:n] # Không dùng fill([], n) theo giáo trình tr.141
    for (u, v) in canh
        if !(v in ke[u])
            push!(ke[u], v)
        end
        if !(u in ke[v])
            push!(ke[v], u)
        end
    end
    foreach(sort!, ke)
    return ke
end

# 3. Thuật toán BFS tô màu đồ thị sử dụng hàng đợi (Queue)
function bfs_to_mau!(ke::Vector{Vector{Int}}, s::Int, mau::Vector{Int})
    queue = Int[]
    push!(queue, s)
    mau[s] = 1 # Gắn nhãn màu 1 cho đỉnh bắt đầu
    
    while !isempty(queue)
        u = popfirst!(queue)
        for v in ke[u]
            if mau[v] == -1
                # Chưa tô màu -> tô màu ngược lại với u (0 hoặc 1)
                mau[v] = 1 - mau[u]
                push!(queue, v)
            elseif mau[v] == mau[u]
                # Phát hiện hai đỉnh kề nhau cùng màu -> không phải đồ thị hai phía
                return false
            end
        end
    end
    return true
end

# 4. Kiểm tra tính đúng đắn của việc tô màu toàn bộ đồ thị
function kiem_mau(n::Int, ke::Vector{Vector{Int}}, mau::Vector{Int})
    all(c -> c == 0 || c == 1, mau) || return false
    return all(mau[u] != mau[v] for u in 1:n for v in ke[u])
end

# 5. Hàm chính kiểm tra đồ thị hai phía
function hai_phia(n::Int, canh::Vector{Tuple{Int, Int}})
    # Nếu input lỗi, hàm kiem_tra_input sẽ tự ném ra Error
    kiem_tra_input(n, canh)
    
    ke = xay_ke(n, canh)
    mau = fill(-1, n)
    
    for i in 1:n
        if mau[i] == -1
            if !bfs_to_mau!(ke, i, mau)
                # Tìm ra các đỉnh xung đột nếu không thỏa mãn
                xung_dot = Int[]
                for u in 1:n
                    if mau[u] != -1
                        for v in ke[u]
                            if mau[v] == mau[u] && !(u in xung_dot) && !(v in xung_dot)
                                push!(xung_dot, u)
                                push!(xung_dot, v)
                            end
                        end
                    end
                end
                sort!(xung_dot)
                
                # Phân loại nhóm màu dựa trên mảng mau (0 và 1)
                nhom0 = [j for j in 1:n if mau[j] == 0]
                nhom1 = [j for j in 1:n if mau[j] == 1]
                sort!(nhom0); sort!(nhom1)
                
                return (false, (nhom0, nhom1), unique(xung_dot))
            end
        end
    end
    
    # Nếu thành công, phân chia đỉnh vào hai nhóm màu 0 và 1
    nhom0 = [i for i in 1:n if mau[i] == 0]
    nhom1 = [i for i in 1:n if mau[i] == 1]
    sort!(nhom0); sort!(nhom1)
    
    return (true, (nhom0, nhom1), mau)
end
