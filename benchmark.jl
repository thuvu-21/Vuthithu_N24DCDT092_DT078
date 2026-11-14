# ==========================================
# SCRIPT KHẢO SÁT THỰC NGHIỆM (BENCHMARK)
# Đề tài: Kiểm tra đồ thị hai phía (DT78)
# ==========================================

include("hai_phia.jl")

# Hàm hỗ trợ sinh đồ thị ngẫu nhiên dạng danh sách kề với kích thước n
function tao_do_thi_ngau_nhien(n, p=0.3)
    ke = [Int[] for _ in 1:n]
    for i in 1:n
        for j in (i+1):n
            if rand() < p
                push!(ke[i], j)
                push!(ke[j], i)
            end
        end
    end
    return ke
end

println("==================================================")
println("      BẮT ĐẦU KHẢO SÁT THỰC NGHIỆM HIỆU NĂNG        ")
println("==================================================")

quy_mo_list = [5, 20, 50]

for n in quy_mo_list
    println("\n[QUY MÔ n = $n]")
    ke = tao_do_thi_ngau_nhien(n, 0.3)
    
    # Warm-up JIT compiler
    _ = hai_phia(ke)
    
    # Đo đạc thời gian và bộ nhớ
    res, t_sec, memory_bytes, gctime, gcstats = @timed hai_phia(ke)
    time_ms = t_sec * 1000.0
    
    println("  - Kết quả kiểm tra (Là đồ thị hai phía?): $(res[1])")
    println("  - Thời gian thực thi: $(round(time_ms, digits = 4)) ms")
    println("  - Bộ nhớ cấp phát: $memory_bytes bytes")
end

println("\n==================================================")
println("           HOÀN TẤT KHẢO SÁT THỰC NGHIỆM          ")
println("==================================================")