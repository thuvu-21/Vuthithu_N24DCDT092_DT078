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
    ke = [Int[] for _ in 1:n]
    for (u, v) in canh
        if !(v in ke[u])
            push!(ke[u], v)
        end
        if !(u in ke[v])
            push!(ke[v], u)
        end
    end
    return ke
end

# 3. Thuật toán BFS tô màu đồ thị sử dụng hàng đợi (Queue)
function bfs_to_mau!(ke::Vector{Vector{Int}}, s::Int, mau::Vector{Int})
    n = length(ke)
    queue = Int[]
    
    push!(queue, s)
    mau[s] = 1 # Gắn nhãn màu 1 cho đỉnh bắt đầu
    
    while !isempty(queue)
        u = popfirst!(queue) # Lấy đỉnh ra khỏi hàng đợi
        for v in ke[u]
            if mau[v] == -1
                # Chưa tô màu -> tô màu ngược lại với u (1 hoặc 2)
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
function kiem_mau(ke::Vector{Vector{Int}}, mau::Vector{Int})
    n = length(ke)
    for u in 1:n
        for v in ke[u]
            if mau[u] != -1 && mau[v] != -1 && mau[u] == mau[v]
                return false
            end
        end
    end
    return true
end

# 5. Hàm chính kiểm tra đồ thị hai phía
function hai_phia(n::Int, canh::Vector{Tuple{Int, Int}})
    # Nếu input lỗi, hàm kiem_tra_input sẽ tự ném ra Error
    kiem_tra_input(n, canh)
    
    ke = xay_ke(n, canh)
    n = length(ke)
    mau = fill(-1, n)
    
    nhom1 = Int[]
    nhom2 = Int[]
    xung_dot = Int[]
    
    for i in 1:n
        if mau[i] == -1
            if !bfs_to_mau!(ke, i, mau)
                # Tìm ra các đỉnh xung đột nếu không thỏa mãn
                # Lọc ra các cạnh vi phạm tính chất hai phía
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
                # Phân loại nhóm màu dựa trên mảng mau
                for j in 1:n
                    if mau[j] == 1
                        push!(nhom1, j)
                    elseif mau[j] == 2
                        push!(nhom2, j)
                    end
                end
                sort!(nhom1); sort!(nhom2)
                return (false, (nhom1, nhom2), unique(xung_dot))
            end
        end
    end
    
    # Nếu thành công, phân chia đỉnh vào hai nhóm
    for i in 1:n
        if mau[i] == 1 || mau[i] == 1 # Gán chuẩn nhóm 1
            push!(nhom1, i)
        else
            push!(nhom2, i)
        end
    end
    sort!(nhom1); sort!(nhom2)
    return (true, (nhom1, nhom2), Int[])
end
