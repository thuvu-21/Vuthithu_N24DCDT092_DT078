# ==============================================================================
# ĐỀ TÀI DT078: KIỂM TRA ĐỒ THỊ HAI PHÍA BẰNG BFS TÔ HAI MÀU
# Sinh viên thực hiện: Vũ Thị Thư - MSSV: N24DCDT092
# Ngôn ngữ: Julia
# ==============================================================================

# 1. Hàm dựng danh sách kề (sắp xếp láng giềng tăng dần theo nhãn)
function xay_ke(n, canh)
    ke = [Int[] for _ in 1:n]
    for (u, v) in canh
        push!(ke[u], v)
        push!(ke[v], u)
    end
    for l in ke
        sort!(l) # Đảm bảo láng giềng sắp tăng dần theo yêu cầu đề
    end
    return ke
end

# 2. Hàm BFS tô màu một thành phần liên thông
function bfs_to_mau!(ke, s, mau)
    mau[s] = 0
    hang = [s] # Queue
    dau = 1
    while dau <= length(hang)
        u = hang[dau]; dau += 1
        for v in ke[u]
            if mau[v] == -1
                mau[v] = 1 - mau[u] # Tô màu xen kẽ
                push!(hang, v)
            elseif mau[v] == mau[u]
                return (min(u, v), max(u, v)) # Chuẩn hóa cạnh xung đột (nhỏ, lớn)
            end
        end
    end
    return nothing # Không có xung đột
end

# 3. Hàm chính xử lý toàn bộ đồ thị (bao gồm đồ thị không liên thông)
function hai_phia(n, ke)
    mau = fill(-1, n)
    for s in 1:n
        if mau[s] == -1
            res = bfs_to_mau!(ke, s, mau)
            if res !== nothing
                return (false, res, mau) # Không hai phía: trả về false, cạnh xung đột và mảng mau
            end
        end
    end
    mau0 = [i for i in 1:n if mau[i] == 0]
    mau1 = [i for i in 1:n if mau[i] == 1]
    return (true, (mau0, mau1), mau) # Hai phía: trả về true, hai tập màu và mảng mau
end

# 4. Hàm kiểm tra lại kết quả tô màu (Hàm con kiểm nghiệm kiem_mau)
function kiem_mau(n, ke, mau)
    if any(m == -1 for m in mau)
        return false # Còn đỉnh chưa tô màu
    end
    for u in 1:n
        for v in ke[u]
            if u < v
                if mau[u] == mau[v]
                    return false # Hai đỉnh kề nhau cùng màu
                end
            end
        end
    end
    return true
end

# 5. Hàm kiểm tra tính hợp lệ của đầu vào (Validator kiem_tra_input)
function kiem_tra_input(n, canh)
    if n < 1 || n > 100
        return false, "Loi: So dinh n phai tu 1 den 100."
    end
    set_canh = Set{Tuple{Int, Int}}()
    for (u, v) in canh
        if u < 1 || u > n || v < 1 || v > n
            return false, "Loi: Dinh vuot qua pham vi [1, n]."
        end
        if u == v
            return false, "Loi: Do thi chua khuyen ($u, $v)."
        end
        c_chuan = (min(u, v), max(u, v))
        if c_chuan in set_canh
            return false, "Loi: Do thi chua canh lap $c_chuan."
        end
        push!(set_canh, c_chuan)
    end
    return true, "Hop le"
end

# ==============================================================================
# KỊCH BẢN KIỂM THỬ ĐẦY ĐỦ 12 CA (SUITE TEST CHƯƠNG 4)
# ==============================================================================

function chay_test_case(ma_ca, ten_ca, n, canh)
    println("----------------------------------------------------------------------")
    println("[$ma_ca] $ten_ca")
    println("Input: n = $n, canh = $canh")
    
    # Bước 1: Kiểm tra đầu vào
    hop_le, thong_bao = kiem_tra_input(n, canh)
    if !hop_le
        println("Actual: Tu choi input - $thong_bao")
        return
    end
    
    # Bước 2: Dựng kề và chạy BFS
    ke = xay_ke(n, canh)
    ket_qua, chi_tiet, mau = hai_phia(n, ke)
    
    if ket_qua
        println("Actual: true | mau0 = $(chi_tiet[1]), mau1 = $(chi_tiet[2])")
        println("Moi mảng màu: $mau")
        # Kiểm tra lại bằng kiem_mau
        println("Kiem tra kiem_mau(): $(kiem_mau(n, ke, mau) ? "PASS" : "FAIL")")
    else
        println("Actual: false | Canh xung dot = $chi_tiet")
        println("Moi mảng màu: $mau")
    end
end

println("======================================================================")
println("          KET QUA CHAY BO KIEM THU 12 CA DE TAI DT078                 ")
println("======================================================================")

# 1. VD01 (Phiếu 3): Vòng 4 đỉnh
chay_test_case("VD01", "Vong 4 dinh (1-2-3-4-1)", 4, [(1,2), (2,3), (3,4), (4,1)])

# 2. VD02 (Phiếu 4): Tam giác 3 đỉnh
chay_test_case("VD02", "Tam giac 3 dinh (1-2-3-1)", 3, [(1,2), (2,3), (3,1)])

# 3. BIEN01 (Phiếu 1): n = 1, không cạnh
chay_test_case("BIEN01", "Bien n = 1, khong canh", 1, Tuple{Int,Int}[])

# 4. BIEN02 (Phiếu 2): n = 2, 1 cạnh 1-2
chay_test_case("BIEN02", "Bien n = 2, 1 canh (1,2)", 2, [(1,2)])

# 5. BIEN03: Biên n = 100 (Đường đi 1-2-...-100)
canh_duong_di = [(i, i+1) for i in 1:99]
chay_test_case("BIEN03", "Bien n = 100, duong di dai 99 canh", 100, canh_duong_di)

# 6. TK01: Tự thiết kế 1 - Hai thành phần đều hai phía
chay_test_case("TK01", "Hai thanh phan deu hai phia (1-2 va 3-4-5-3 khong co)", 5, [(1,2), (3,4), (4,5)])

# 7. TK02: Tự thiết kế 2 - Vòng 5 đỉnh có đuôi
chay_test_case("TK02", "Vong 5 dinh le co duoi", 6, [(1,2), (2,3), (3,4), (4,5), (5,1), (5,6)])

# 8. LOI01: Input sai chứa khuyên (3,3)
chay_test_case("LOI01", "Input sai chua khuyen (3,3)", 4, [(1,2), (3,3)])

# 9. KT09 (Phiếu 5): Hai thành phần: 1 cạnh + 1 tam giác
chay_test_case("KT09", "Hai thanh phan (1 canh va 1 tam giac)", 5, [(1,2), (3,4), (4,5), (5,3)])

# 10. KT10: Ca hàm con kiem_mau (Đồ thị hai phía hợp lệ)
chay_test_case("KT10", "Kiem tra kiem_mau cho do thi 2 phia hop le", 4, [(1,2), (2,3)])

# 11. KT11: Ca hàm con kiem_mau sai (Mảng màu cố tình gán sai)
println("----------------------------------------------------------------------")
println("[KT11] Ca ham con kiem_mau voi mang mau sai")
ke_kt11 = xay_ke(3, [(1,2), (2,3)])
mau_sai = [0, 0, 1] # Đỉnh 1 và 2 kề nhau nhưng cùng màu 0
println("Actual kiem_mau: $(kiem_mau(3, ke_kt11, mau_sai)) (Ky vong: false)")

# 12. KT12: Ca hàm con kiem_mau chưa tô hết (Chứa màu -1)
println("----------------------------------------------------------------------")
println("[KT12] Ca ham con kiem_mau chua to het (chua mau -1)")
mau_chua_to = [0, -1, 1]
println("Actual kiem_mau: $(kiem_mau(3, ke_kt11, mau_chua_to)) (Ky vong: false)")
println("======================================================================")