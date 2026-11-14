# ... (Phần khai báo ca_test giữ nguyên) ...

pass_count = 0
fail_count = 0

for (ten, n, canh, expected_bool) in ca_test
    ke = [Int[] for _ in 1:n]
    for (u, v) in canh
        push!(ke[u], v)
        push!(ke[v], u)
    end
    res = hai_phia(ke)
    is_pass = (res[1] == expected_bool)
    if is_pass
        global pass_count += 1
        println("[PASS] - $ten")
    else
        global fail_count += 1
        println("[FAIL] - $ten")
    end
end

println("==================================================")
println(" TỔNG KẾT: $pass_count PASS, $fail_count FAIL trên tổng số $(length(ca_test)) ca.")
println("==================================================")
