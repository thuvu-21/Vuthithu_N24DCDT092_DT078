include("hai_phia.jl")
println("--- KT11: Chu trình chẵn 6 đỉnh (C6) ---")
res = hai_phia(6, [(1, 2), (2, 3), (3, 4), (4, 5), (5, 6), (6, 1)])
println("Actual: ", res)