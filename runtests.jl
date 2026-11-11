# =====================================================================
# TỆP TỔNG HỢP KIỂM THỬ TỰ ĐỘNG (runtests.jl) — ĐỀ TÀI DT078
# Sinh viên: Vũ Thị Thư — MSSV: N24DCDT092 — Lớp: D24CQDT01-N
# =====================================================================

println("==================================================")
println(" TỔNG KẾT BỘ KIỂM THỬ TỰ ĐỘNG (DT078 - 14 CA)    ")
println("==================================================")

# Nhúng tệp mã nguồn chính của thuật toán
include("hai_phai.jl")

# Danh sách 14 ca kiểm thử độc lập (đáp ứng yêu cầu >= 12 ca của đề bài)
ca_test = [
    ("VD01 (Vòng 4 đỉnh - Thỏa mãn)", 4, [(1, 2), (2, 3), (3, 4), (4, 1)], true),
    ("VD02 (Tam giác 3 đỉnh - Vi phạm)", 3, [(1, 2), (2, 3), (3, 1)], false),
    ("TK01 (Đối xứng 6 đỉnh - Thỏa mãn)", 6, [(1, 2), (1, 3), (2, 4), (3, 5), (4, 6), (5, 6)], true),
    ("TK02 (Không liên thông chứa tam giác)", 5, [(1, 2), (3, 4), (4, 5), (5, 3)], false),
    ("BIEN01 (Đồ thị 1 đỉnh cô lập)", 1, Tuple{Int,Int}[], true),
    ("BIEN02 (Đồ thị 1 cạnh đơn)", 2, [(1, 2)], true),
    ("BIEN03 (Đường đi dài 4 đỉnh)", 4, [(1, 2), (2, 3), (3, 4)], true),
    ("KT09 (Đồ thị K3 đầy đủ - Vi phạm)", 3, [(1, 2), (2, 3), (3, 1)], false),
    ("KT10 (Đồ thị hình ngôi sao - Thỏa mãn)", 4, [(1, 2), (1, 3), (1, 4)], true),
    ("KT11 (Chu trình chẵn C6 - Thỏa mãn)", 6, [(1, 2), (2, 3), (3, 4), (4, 5), (5, 6), (6, 1)], true),
    ("KT12 (Đồ thị K2 cơ bản - Thỏa mãn)", 2, [(1, 2)], true),
    ("KT13 (Chu trình lẻ 5 đỉnh C5 - Vi phạm)", 5, [(1, 2), (2, 3), (3, 4), (4, 5), (5, 1)], false),
    ("KT14 (Đồ thị đầy đủ K4 - Vi phạm)", 4, [(1, 2), (1, 3), (1, 4), (2, 3), (2, 4), (3, 4)], false),
    ("KT15 (Đồ thị hai thành phần rời nhau hợp lệ)", 4, [(1, 2), (3, 4)], true)
]

pass_count = 0
fail_count = 0

for (ten, n, canh, expected_bool) in ca_test
    res = hai_phia(n, canh)
    is_pass = (res[1] == expected_bool)
    if is_pass
        global pass_count += 1
        println("[PASS] - $ten")
    else
        global fail_count += 1
        println("[FAIL] - $ten")
    end
end

println("==================================================")
println(" TỔNG KẾT: $pass_count PASS, $fail_count FAIL trên tổng số $(length(ca_test)) ca.")
println("==================================================")