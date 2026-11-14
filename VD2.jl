# =====================================================================
# ĐỀ TÀI: Kiểm tra đồ thị hai phía bằng BFS tô hai màu (DT078)
# Sinh viên thực hiện: Vũ Thị Thư — MSSV: N24DCDT092 — Lớp: D24CQDT01-N
# =====================================================================

# 1. Kiểm tra tính hợp lệ của dữ liệu đầu vào
function kiem_tra_input(n::Int, canh::Vector{Tuple{Int, Int}})
    if n <= 0
        error("Số đỉnh n phải lớn hơn 0.")
    end
    for (u, v) in canh
        if u == v
            error("Đồ thị không được chứa khuyên (đỉnh u = v = $u).")
        end
        if u < 1 || u > n || v < 1 || v > n
            error("Chỉ số đỉnh ($u, $v) vượt quá giới hạn cho phép từ 1 đến $n.")
        end
    end
    return true
end

# 2. Xây dựng danh sách kề vô hướng, sắp xếp và loại bỏ cạnh trùng
function xay_ke(n::Int, canh::Vector{Tuple{Int, Int}})
    kiem_tra_input(n, canh)
    ke = [Vector{Int}() for _ in 1:n]
    for (u, v) in canh
        # Tránh thêm cạnh trùng lặp vô hướng nếu có sẵn
        if !(v in ke[u])
            push!(ke[u], v)
        end
        if !(u in ke[v])
            push!(ke[v], u)
        end
    end
    for i in 1:n
        sort!(ke[i])
    end
    return ke
end

# 3. Hàm bfs_to_mau!: Tô màu BFS cho một thành phần liên thông
# Trả về nothing nếu tô thành công, hoặc trả về cạnh xung đột (u, v) nếu phát hiện mâu thuẫn màu
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
                # Phát hiện hai đầu mút kề nhau cùng màu -> Vi phạm tính chất hai phía
                return (min(u, v), max(u, v))
            end
        end
    end
    return nothing
end

# 4. Hàm kiem_mau: Kiểm tra lại toàn bộ các cạnh của kết quả đồ thị hai phía
function kiem_mau(ke::Vector{Vector{Int}}, mau::Vector{Int})
    n = length(ke)
    for u in 1:n
        for v in ke[u]
            if u < v && mau[u] == mau[v]
                return false
            end
        end
    end
    return true
end

# 5. Hàm tổng quát hai_phia: Kiểm tra toàn đồ thị (xử lý cả đồ thị không liên thông)
function hai_phia(n::Int, canh::Vector{Tuple{Int, Int}})
    ke = xay_ke(n, canh)
    mau = fill(-1, n)
    
    # Lặp qua tất cả các đỉnh theo thứ tự nhãn tăng dần để vét cạn các thành phần liên thông
    for s in 1:n
        if mau[s] == -1
            res = bfs_to_mau!(ke, s, mau)
            if res !== nothing
                return (false, res, mau)
            end
        end
    end
    
    # Kiểm tra tính đúng đắn bổ sung bằng hàm kiem_mau
    if !kiem_mau(ke, mau)
        return (false, (-1, -1), mau)
    end
    
    mau0 = [i for i in 1:n if mau[i] == 0]
    mau1 = [i for i in 1:n if mau[i] == 1]
    return (true, (mau0, mau1), mau)
end

# =====================================================================
# CHẠY 5 CA KIỂM TRA BẮT BUỘC TRÊN PHIẾU
# =====================================================================
println("==================================================")
println(" CHƯƠNG TRÌNH KIỂM TRA ĐỒ THỊ HAI PHÍA (DT078)     ")
println(" Sinh viên: Vũ Thị Thư - MSSV: N24DCDT092           ")
println("==================================================")

ca_kiem_tra = [
    ("Ca 1: Một đỉnh không cạnh", 1, Tuple{Int,Int}[]),
    ("Ca 2: Một cạnh 1-2", 2, [(1, 2)]),
    ("Ca 3: Vòng 4 đỉnh (VD01)", 4, [(1, 2), (2, 3), (3, 4), (4, 1)]),
    ("Ca 4: Tam giác 3 đỉnh (VD02)", 3, [(1, 2), (2, 3), (3, 1)]),
    ("Ca 5: Hai thành phần (1 cạnh và 1 tam giác)", 5, [(1, 2), (3, 4), (4, 5), (5, 3)])
]

for (ten_ca, n_test, canh_test) in ca_kiem_tra
    println("\n--- $ten_ca ---")
    println("Input: n = $n_test, canh = $canh_test")
    ket_qua = hai_phia(n_test, canh_test)
    println("Kết quả Actual: $ket_qua")
end
println("\n==================================================")
