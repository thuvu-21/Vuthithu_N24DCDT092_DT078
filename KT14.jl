# =====================================================================
# KT14: Đồ thị đầy đủ K4 — Vi phạm tính chất hai phía
# =====================================================================
include("hai_phia.jl")

println("--- KT14: Đồ thị đầy đủ K4 ---")
n_kt14 = 4
canh_kt14 = [(1, 2), (1, 3), (1, 4), (2, 3), (2, 4), (3, 4)]

println("Input: n = $n_kt14, canh = $canh_kt14")
ket_qua_kt14 = hai_phia(n_kt14, canh_kt14)
println("Actual Output: ", ket_qua_kt14)