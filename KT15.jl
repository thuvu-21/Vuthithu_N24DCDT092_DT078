# =====================================================================
# KT15: Đồ thị gồm các thành phần liên thông rời nhau hợp lệ (2 cạnh rời)
# =====================================================================
include("hai_phia.jl")

println("--- KT15: Đồ thị hai thành phần rời nhau hợp lệ ---")
n_kt15 = 4
canh_kt15 = [(1, 2), (3, 4)]

println("Input: n = $n_kt15, canh = $canh_kt15")
ket_qua_kt15 = hai_phia(n_kt15, canh_kt15)
println("Actual Output: ", ket_qua_kt15)