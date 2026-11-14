# Tệp runtests.jl chạy toàn bộ tập test
println("==========================================")
println(" TỔNG KẾT BỘ KIỂM THỬ TỰ ĐỘNG (DT078)      ")
println("==========================================")

include("hai_phia.jl")

ca_test = [
    ("VD01 (Vòng 4 đỉnh)", 4, [(1, 2), (2, 3), (3, 4), (4, 1)], true),
    ("VD02 (Tam giác 3 đỉnh)", 3, [(1, 2), (2, 3), (3, 1)], false),
    ("TK01 (Đối xứng 6 đỉnh)", 6, [(1, 2), (1, 3), (2, 4), (3, 5), (4, 6), (5, 6)], true),
    ("TK02 (Không liên thông lỗi)", 5, [(1, 2), (3, 4), (4, 5), (5, 3)], false),
    ("BIEN01 (1 đỉnh cô lập)", 1, Tuple{Int,Int}[], true),
    ("BIEN02 (1 cạnh đơn)", 2, [(1, 2)], true),
    ("BIEN03 (Đường đi 4 đỉnh)", 4, [(1, 2), (2, 3), (3, 4)], true),
    ("KT09 (Đồ thị K3)", 3, [(1, 2), (2, 3), (3, 1)], false),
    ("KT10 (Đồ thị hình sao)", 4, [(1, 2), (1, 3), (1, 4)], true),
    ("KT11 (Chu trình C6)", 6, [(1, 2), (2, 3), (3, 4), (4, 5), (5, 6), (6, 1)], true),
    ("KT12 (Đồ thị K2)", 2, [(1, 2)], true)
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

println("==========================================")
println(" TỔNG KẾT: $pass_count PASS, $fail_count FAIL trên tổng số $(length(ca_test)) ca.")
println("==========================================")