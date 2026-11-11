include("hai_phai.jl")
println("--- KT09: Đồ thị K3 (Tam giác) ---")
# K3 có 3 đỉnh nối đủ vòng tròn -> Chu trình lẻ -> false
res = hai_phia(3, [(1, 2), (2, 3), (3, 1)])
println("Actual: ", res)