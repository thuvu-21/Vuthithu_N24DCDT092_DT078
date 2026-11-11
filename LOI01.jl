include("hai_phai.jl")
println("--- CA LOI01 (Chứa khuyên) ---")
try
    hai_phia(3, [(1, 1), (2, 3)])
catch e
    println("Bắt lỗi thành công: ", e)
end