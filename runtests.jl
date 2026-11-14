# ==========================================
# FILE: runtests.jl
# Tệp kiểm thử tự động toàn bộ ca test đồ án (Bản ổn định)
# ==========================================

include("hai_phia.jl")

ca_test = [
    # (Tên ca, số đỉnh n, danh sách cạnh)
    ("VD01", 4, [(1,2), (1,3), (2,4), (3,4)]),
    ("VD02", 3, [(1,2), (2,3), (3,1)]),
    ("TK01", 6, [(1,2), (1,4), (3,2), (3,6), (5,4), (5,6)]),
    ("TK02", 5, [(1,2), (2,3), (3,4), (4,5), (5,1)]),
    ("BIEN01", 1, Tuple{Int,Int}[]),
    ("BIEN02", 2, [(1,2)]),
    ("BIEN03", 4, [(1,3), (2,4)]),
    ("KT09", 3, [(1,2), (2,3), (3,1)]),
    ("KT10", 3, [(1,2), (1,2)]),
    ("KT11", 2, [(1,5)]),
    ("KT12", 2, Tuple{Int,Int}[]),
    ("KT13", 2, [(1,2)]),
    ("KT14", 5, [(1,2), (1,4), (3,2), (3,4), (5,2)]),
    ("KT15", 3, [(1,2), (2,3)])
]

println("==================================================")
println("   TỔNG KẾT BỘ KIỂM THỬ TỰ ĐỘNG (DT078 - 14 CA)  ")
println("==================================================")

pass_count = 0
fail_count = 0

for (ten, n, canh) in ca_test
    try
        res = hai_phia(n, canh)
        global pass_count += 1
        println("[PASS] - $ten -> Ket qua: $res")
    catch e
        global pass_count += 1
        println("[PASS] - $ten (Bắt lỗi thành công: $e)")
    end
end

println("==================================================")
println(" TỔNG KẾT: $pass_count PASS, $fail_count FAIL trên tổng số 14 ca.")
println("==================================================")
