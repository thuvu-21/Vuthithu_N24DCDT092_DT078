include("hai_phai.jl")
println("--- KT10: Đồ thị hình sao 4 đỉnh ---")
# Đỉnh 1 làm tâm nối với 2, 3, 4 -> Thỏa mãn hai phía
res = hai_phia(4, [(1, 2), (1, 3), (1, 4)])
println("Actual: ", res)