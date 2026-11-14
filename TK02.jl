# ==========================================================
# CA TỰ THIẾT KẾ 2 (TK02): Đồ thị chu trình lẻ 5 đỉnh C5 (Vi phạm)
# Sinh viên: Vũ Thị Thư – MSSV: N24DCDT092
# ==========================================================

include("hai_phia.jl")

println("--- CHAY CA KIEM THU: TK02 ---")
n_tk2 = 5
canh_tk2 = [(1, 2), (2, 3), (3, 4), (4, 5), (5, 1)]

println("Input: n = $n_tk2, canh = $canh_tk2")
ke_tk2 = xay_ke(n_tk2, canh_tk2)
ket_qua_tk2 = hai_phia(ke_tk2)
println("Actual Output: ", ket_qua_tk2)