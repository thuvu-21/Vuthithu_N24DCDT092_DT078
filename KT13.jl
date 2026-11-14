# =====================================================================
# KT13: Đồ thị chu trình lẻ 5 đỉnh (C5) — Vi phạm tính chất hai phía
# =====================================================================
include("hai_phia.jl")

println("--- KT13: Chu trình lẻ 5 đỉnh (C5) ---")
n_kt13 = 5
canh_kt13 = [(1, 2), (2, 3), (3, 4), (4, 5), (5, 1)]

println("Input: n = $n_kt13, canh = $canh_kt13")
ket_qua_kt13 = hai_phia(n_kt13, canh_kt13)
println("Actual Output: ", ket_qua_kt13)