// Xóa chương trình cũ nếu tồn tại
capture program drop lecodebook

*! version 1.5.0 19Mar2025
program define lecodebook, rclass byable(recall)
    // Chương trình tạo data dictionary cho toàn bộ dữ liệu
    syntax [varlist] [, CONT(string)]
    
    // Xác định vị trí lưu file (mặc định trong thư mục làm việc hiện tại)
    local save "datadictionary.html"
    local title "Data Dictionary"
    
    // CSS Style hiện đại hơn
    local css_style "<style>"
    local css_style `"`css_style' :root { --primary-color: #4472C4; --secondary-color: #5B9BD5; --accent-color: #70AD47; --hover-color: #2E5AAC; --text-color: #333; --light-bg: #f8f9fa; --border-color: #dee2e6; --card-shadow: 0 4px 6px rgba(0,0,0,0.1); --quant-color: #217346; --binary-color: #BF8F00; --nominal-color: #7030A0; --ordinal-color: #843C0B; --string-color: #C55A11; }"'
    local css_style `"`css_style' body { font-family: 'Segoe UI', Arial, sans-serif; margin: 0; padding: 0; color: var(--text-color); background-color: #f5f7fa; line-height: 1.6; }"'
    local css_style `"`css_style' .container { width: 95%; max-width: 1200px; margin: 20px auto; padding: 20px; background: white; border-radius: 8px; box-shadow: var(--card-shadow); }"'
    local css_style `"`css_style' table { border-collapse: collapse; width: 100%; margin: 20px 0; box-shadow: var(--card-shadow); border-radius: 5px; overflow: hidden; }"'
    local css_style `"`css_style' th { background-color: var(--primary-color); color: white; font-weight: 600; text-align: left; padding: 15px; text-transform: uppercase; font-size: 14px; position: sticky; top: 0; z-index: 10; }"'
    local css_style `"`css_style' td { padding: 12px 15px; border-bottom: 1px solid var(--border-color); vertical-align: top; }"'
    local css_style `"`css_style' tr:nth-child(even) { background-color: var(--light-bg); }"'
    local css_style `"`css_style' tr:hover { background-color: rgba(91, 155, 213, 0.1); }"'
    local css_style `"`css_style' .btn { padding: 10px 16px; background-color: var(--primary-color); color: white; border: none; border-radius: 4px; cursor: pointer; font-weight: 500; transition: all 0.3s ease; display: inline-block; margin: 0 5px 10px 0; font-size: 14px; }"'
    local css_style `"`css_style' .btn:hover { background-color: var(--hover-color); transform: translateY(-2px); box-shadow: 0 4px 8px rgba(0,0,0,0.1); }"'
    local css_style `"`css_style' .btn-copy { background-color: var(--secondary-color); }"'
    local css_style `"`css_style' .btn-sort { background-color: var(--accent-color); }"'
    local css_style `"`css_style' h1 { color: var(--primary-color); margin-bottom: 20px; padding-bottom: 10px; border-bottom: 2px solid var(--primary-color); font-weight: 600; }"'
    local css_style `"`css_style' .var-name { font-weight: 600; color: var(--primary-color); }"'
    local css_style `"`css_style' .quant { color: var(--quant-color); font-weight: 500; }"'
    local css_style `"`css_style' .binary { color: var(--binary-color); font-weight: 500; }"'
    local css_style `"`css_style' .nominal { color: var(--nominal-color); font-weight: 500; }"'
    local css_style `"`css_style' .ordinal { color: var(--ordinal-color); font-weight: 500; }"'
    local css_style `"`css_style' .string { color: var(--string-color); font-weight: 500; }"'
    local css_style `"`css_style' .info-box { background-color: var(--light-bg); padding: 15px; border-radius: 6px; margin: 20px 0; border-left: 4px solid var(--primary-color); }"'
    local css_style `"`css_style' .info-title { margin-top: 0; color: var(--primary-color); font-size: 16px; font-weight: 600; }"'
    local css_style `"`css_style' .legend { display: flex; flex-wrap: wrap; gap: 10px; margin-bottom: 20px; }"'
    local css_style `"`css_style' .legend-item { display: flex; align-items: center; margin-right: 15px; }"'
    local css_style `"`css_style' .legend-color { width: 15px; height: 15px; border-radius: 3px; margin-right: 5px; }"'
    local css_style `"`css_style' .quant-color { background-color: var(--quant-color); }"'
    local css_style `"`css_style' .binary-color { background-color: var(--binary-color); }"'
    local css_style `"`css_style' .nominal-color { background-color: var(--nominal-color); }"'
    local css_style `"`css_style' .ordinal-color { background-color: var(--ordinal-color); }"'
    local css_style `"`css_style' .string-color { background-color: var(--string-color); }"'
    local css_style `"`css_style' .btn-group { margin-bottom: 15px; }"'
    local css_style `"`css_style' .footer { margin-top: 30px; text-align: center; font-size: 14px; color: #666; }"'
    local css_style `"`css_style' .data-summary { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; margin-bottom: 20px; }"'
    local css_style `"`css_style' .summary-card { background: white; padding: 15px; border-radius: 6px; box-shadow: var(--card-shadow); text-align: center; }"'
    local css_style `"`css_style' .summary-number { font-size: 24px; font-weight: bold; color: var(--primary-color); margin: 10px 0; }"'
    local css_style `"`css_style' .summary-label { font-size: 14px; color: #666; }"'
    local css_style `"`css_style' @media print { .btn-group, button { display: none; } }"'
    local css_style `"`css_style' </style>"'
    
    // JavaScript cho nút sao chép và sắp xếp
   
    // Hàm sao chép bảng
    local js_code "<script>"
    local js_code `"`js_code' function copyTable() {"'
    local js_code `"`js_code'     const table = document.querySelector('table');"'
    local js_code `"`js_code'     const range = document.createRange();"'
    local js_code `"`js_code'     range.selectNode(table);"'
    local js_code `"`js_code'     window.getSelection().removeAllRanges();"'
    local js_code `"`js_code'     window.getSelection().addRange(range);"'
    local js_code `"`js_code'     document.execCommand('copy');"'
    local js_code `"`js_code'     window.getSelection().removeAllRanges();"'
    local js_code `"`js_code'     alert('Bảng đã được sao chép vào clipboard!');"'
    local js_code `"`js_code' }"'
    local js_code `"`js_code' </script>"'
    
    // Hàm sắp xếp bảng theo loại biến
   
    
    // Xử lý danh sách biến định lượng được chỉ định bởi người dùng
    if "`cont'" != "" {
        tokenize "`cont'"
        local cont_vars
        while "`1'" != "" {
            local cont_vars `cont_vars' `1'
            macro shift
        }
    }
    
    // Bắt đầu tạo file HTML
    tempname file_handle
    file open `file_handle' using "`save'", write replace
    
    // Viết phần đầu HTML
    file write `file_handle' "<!DOCTYPE html>" _n
    file write `file_handle' "<html lang='vi'>" _n
    file write `file_handle' "<head>" _n
    file write `file_handle' "<meta charset='UTF-8'>" _n
    file write `file_handle' "<meta name='viewport' content='width=device-width, initial-scale=1.0'>" _n
    file write `file_handle' "<title>`title'</title>" _n
    file write `file_handle' `"`css_style'"' _n
    file write `file_handle' `"`js_code'"' _n
    file write `file_handle' "</head>" _n
    file write `file_handle' "<body>" _n
    file write `file_handle' "<div class='container'>" _n
    file write `file_handle' "<h1>`title'</h1>" _n
    
    // Thêm phần tóm tắt dữ liệu ở trên cùng dạng card
    file write `file_handle' "<div class='data-summary'>" _n
    file write `file_handle' "<div class='summary-card'>" _n
    file write `file_handle' "<div class='summary-label'>Tổng số quan sát</div>" _n
    file write `file_handle' "<div class='summary-number'>`c(N)'</div>" _n
    file write `file_handle' "</div>" _n
    file write `file_handle' "<div class='summary-card'>" _n
    file write `file_handle' "<div class='summary-label'>Tổng số biến</div>" _n
    file write `file_handle' "<div class='summary-number'>`c(k)'</div>" _n
    file write `file_handle' "</div>" _n
    file write `file_handle' "<div class='summary-card'>" _n
    file write `file_handle' "<div class='summary-label'>Ngày tạo</div>" _n
    file write `file_handle' "<div class='summary-number'>`c(current_date)'</div>" _n
    file write `file_handle' "</div>" _n
    file write `file_handle' "</div>" _n
    
    // Thêm chú giải màu sắc
    file write `file_handle' "<div class='legend'>" _n
    file write `file_handle' "<div class='legend-item'><div class='legend-color quant-color'></div>Định lượng</div>" _n
    file write `file_handle' "<div class='legend-item'><div class='legend-color binary-color'></div>Nhị giá</div>" _n
    file write `file_handle' "<div class='legend-item'><div class='legend-color ordinal-color'></div>Thứ bậc</div>" _n
    file write `file_handle' "<div class='legend-item'><div class='legend-color nominal-color'></div>Danh định</div>" _n
    file write `file_handle' "<div class='legend-item'><div class='legend-color string-color'></div>Chuỗi</div>" _n
    file write `file_handle' "</div>" _n
    
    // Các nút chức năng
    file write `file_handle' "<div class='btn-group'>" _n
    file write `file_handle' "<button class='btn btn-copy' onclick='copyTable()'>Sao chép bảng</button>" _n
    file write `file_handle' "<button class='btn btn-sort' onclick='sortTableByType()'>Sắp xếp theo loại biến</button>" _n
    file write `file_handle' "</div>" _n
    
    // Bảng dữ liệu
    file write `file_handle' "<table>" _n
    file write `file_handle' "<thead>" _n
    file write `file_handle' "<tr>" _n
    file write `file_handle' "<th>Tên biến</th>" _n
    file write `file_handle' "<th>Loại</th>" _n
    file write `file_handle' "<th>Giá trị</th>" _n
    file write `file_handle' "<th>Nhãn biến</th>" _n
    file write `file_handle' "</tr>" _n
    file write `file_handle' "</thead>" _n
    file write `file_handle' "<tbody>" _n
    
    // Lấy danh sách tất cả các biến
    if "`varlist'" == "" {
        quietly ds
        local varlist = r(varlist)
    }
    
    // Lặp qua từng biến trong danh sách
    foreach var of local varlist {
        // Kiểm tra xem biến có nằm trong danh sách biến định lượng được chỉ định không
        local is_forced_cont = 0
        if "`cont'" != "" {
            foreach cont_var of local cont_vars {
                if "`var'" == "`cont_var'" {
                    local is_forced_cont = 1
                    continue, break
                }
            }
        }
        
        // Kiểm tra loại biến (số hoặc chuỗi)
        capture confirm numeric variable `var', exact
        if !_rc {
            // Biến số
            
            // Lấy thông tin nhãn biến
            local varlabel: variable label `var'
            if "`varlabel'" == "" {
                local varlabel "`var'"
            }
            
            // Lấy thông tin giá trị
            local valuelabel: value label `var'
            
            // Đếm số giá trị khác nhau của biến
            capture which distinct
            if _rc {
                // Nếu lệnh distinct không có sẵn, dùng tabulate
                quietly tabulate `var'
                local distinct_values = r(r)
            }
            else {
                // Nếu lệnh distinct có sẵn
                quietly distinct `var'
                local distinct_values = r(ndistinct)
            }
            
            // Phân loại biến
            if `is_forced_cont' == 1 {
                // Biến được chỉ định là định lượng
                
                // Kiểm tra phân phối chuẩn bằng kiểm định Shapiro-Wilk hoặc Skewness-Kurtosis
                capture quietly swilk `var'
                if _rc {
                    // Nếu Shapiro-Wilk không khả dụng, dùng Skewness-Kurtosis
                    quietly sktest `var'
                    local pvalue = r(p_skew)
                }
                else {
                    local pvalue = r(p)
                }
                
                // Xác định phân phối chuẩn hay không (p > 0.05)
                if `pvalue' > 0.05 {
                    local vartype "<span class='quant'>Định lượng (phân phối chuẩn)</span>"
                }
                else {
                    local vartype "<span class='quant'>Định lượng (không phân phối chuẩn)</span>"
                }
                
                // Tính toán các thống kê (làm tròn 2 chữ số thập phân)
                quietly summarize `var', detail
                local mean = round(r(mean), 0.01)
                local sd = round(r(sd), 0.01)
                local median = round(r(p50), 0.01)
                local q1 = round(r(p25), 0.01)
                local q3 = round(r(p75), 0.01)
                local min = round(r(min), 0.01)
                local max = round(r(max), 0.01)
                
                file write `file_handle' "<tr>" _n
                file write `file_handle' "<td><span class='var-name'>`var'</span></td>" _n
                file write `file_handle' "<td>`vartype'</td>" _n
                file write `file_handle' "<td>TB: `mean'; ĐLC: `sd'<br>TV: `median'; KTPV: (`q1'-`q3')<br>Min: `min'; Max: `max'</td>" _n
                file write `file_handle' "<td>`varlabel'</td>" _n
                file write `file_handle' "</tr>" _n
            }
            else if `distinct_values' <= 2 {
                // Biến nhị giá (có 2 giá trị)
                local vartype "<span class='binary'>Định tính - Nhị giá</span>"
                
                file write `file_handle' "<tr>" _n
                file write `file_handle' "<td><span class='var-name'>`var'</span></td>" _n
                file write `file_handle' "<td>`vartype'</td>" _n
                file write `file_handle' "<td>"
                
                if "`valuelabel'" != "" {
                    // Liệt kê giá trị và nhãn
                    quietly levelsof `var', local(levels)
                    foreach level of local levels {
                        local vallab: label `valuelabel' `level'
                        file write `file_handle' "`level' = `vallab'<br>"
                    }
                }
                else {
                    // Không có nhãn, chỉ liệt kê giá trị
                    quietly levelsof `var', local(levels)
                    foreach level of local levels {
                        file write `file_handle' "`level'<br>"
                    }
                }
                
                file write `file_handle' "</td>" _n
                file write `file_handle' "<td>`varlabel'</td>" _n
                file write `file_handle' "</tr>" _n
            }
            else if `distinct_values' <= 10 {
                // Kiểm tra xem biến có phải là thứ bậc (ordinal) không
                local is_ordinal = 1
                
                // Kiểm tra xem các giá trị có phải là số nguyên liên tiếp không
                quietly levelsof `var', local(levels)
                local prev_level = .
                
                foreach level of local levels {
                    if `prev_level' != . {
                        if `level' != `prev_level' + 1 {
                            local is_ordinal = 0
                            continue, break
                        }
                    }
                    local prev_level = `level'
                }
                
                if `is_ordinal' == 1 {
                    // Biến thứ bậc (ordinal)
                    local vartype "<span class='ordinal'>Định tính - Thứ bậc</span>"
                }
                else {
                    // Biến danh định (nominal)
                    local vartype "<span class='nominal'>Định tính - Danh định</span>"
                }
                
                file write `file_handle' "<tr>" _n
                file write `file_handle' "<td><span class='var-name'>`var'</span></td>" _n
                file write `file_handle' "<td>`vartype'</td>" _n
                file write `file_handle' "<td>"
                
                if "`valuelabel'" != "" {
                    // Liệt kê giá trị và nhãn
                    quietly levelsof `var', local(levels)
                    foreach level of local levels {
                        local vallab: label `valuelabel' `level'
                        file write `file_handle' "`level' = `vallab'<br>"
                    }
                }
                else {
                    // Không có nhãn, chỉ liệt kê giá trị
                    quietly levelsof `var', local(levels)
                    foreach level of local levels {
                        file write `file_handle' "`level'<br>"
                    }
                }
                
                file write `file_handle' "</td>" _n
                file write `file_handle' "<td>`varlabel'</td>" _n
                file write `file_handle' "</tr>" _n
            }
            else {
                // Biến định lượng (số lượng giá trị khác nhau lớn hơn 10)
                
                // Kiểm tra phân phối chuẩn bằng kiểm định Shapiro-Wilk hoặc Skewness-Kurtosis
                capture quietly swilk `var'
                if _rc {
                    // Nếu Shapiro-Wilk không khả dụng, dùng Skewness-Kurtosis
                    quietly sktest `var'
                    local pvalue = r(p_skew)
                }
                else {
                    local pvalue = r(p)
                }
                
                // Xác định phân phối chuẩn hay không (p > 0.05)
                if `pvalue' > 0.05 {
                    local vartype "<span class='quant'>Định lượng (phân phối chuẩn)</span>"
                }
                else {
                    local vartype "<span class='quant'>Định lượng (không phân phối chuẩn)</span>"
                }
                
                // Tính toán các thống kê (làm tròn 2 chữ số thập phân)
                quietly summarize `var', detail
                local mean = round(r(mean), 0.01)
                local sd = round(r(sd), 0.01)
                local median = round(r(p50), 0.01)
                local q1 = round(r(p25), 0.01)
                local q3 = round(r(p75), 0.01)
                local min = round(r(min), 0.01)
                local max = round(r(max), 0.01)
                
                file write `file_handle' "<tr>" _n
                file write `file_handle' "<td><span class='var-name'>`var'</span></td>" _n
                file write `file_handle' "<td>`vartype'</td>" _n
                file write `file_handle' "<td>TB: `mean'; ĐLC: `sd'<br>TV: `median'; KTPV: (`q1'-`q3')<br>Min: `min'; Max: `max'</td>" _n
                file write `file_handle' "<td>`varlabel'</td>" _n
                file write `file_handle' "</tr>" _n
            }
        }
        else {
            // Biến chuỗi
            capture confirm string variable `var', exact
            if !_rc {
                local vartype "<span class='string'>Chuỗi</span>"
                
                // Lấy thông tin nhãn biến
                local varlabel: variable label `var'
                if "`varlabel'" == "" {
                    local varlabel "`var'"
                }
                
                file write `file_handle' "<tr>" _n
                file write `file_handle' "<td><span class='var-name'>`var'</span></td>" _n
                file write `file_handle' "<td>`vartype'</td>" _n
                
                // Xác định số lượng giá trị khác nhau
                capture which distinct
                if _rc {
                    // Nếu lệnh distinct không có sẵn, dùng tabulate
                    quietly tabulate `var'
                    local distinct_values = r(r)
                }
                else {
                    // Nếu lệnh distinct có sẵn
                    quietly distinct `var'
                    local distinct_values = r(ndistinct)
                }
                
                // Phân loại biến chuỗi dựa trên số lượng giá trị khác nhau
                if `distinct_values' == 2 {
                    // Cập nhật loại biến thành nhị phân
                    file write `file_handle' "<td><span class='binary'>Biến nhị giá</span><br>"
                }
                else if `distinct_values' <= 10 {
                    // Cập nhật loại biến thành danh định
                    file write `file_handle' "<td><span class='nominal'>Biến danh định</span><br>"
                }
                else {
                    file write `file_handle' "<td>"
                }
                
                if `distinct_values' <= 10 {
                    // Liệt kê giá trị nếu không quá nhiều
                    quietly levelsof `var', local(levels)
                    foreach level of local levels {
                        file write `file_handle' "`level'<br>"
                    }
                }
                else {
                    // Quá nhiều giá trị khác nhau
                    file write `file_handle' "Nhiều giá trị khác nhau (`distinct_values')"
                }
                
                file write `file_handle' "</td>" _n
                file write `file_handle' "<td>`varlabel'</td>" _n
                file write `file_handle' "</tr>" _n
            }
        }
    }
    
   // Kết thúc file HTML
    file write `file_handle' "</tbody>" _n
    file write `file_handle' "</table>" _n
    
    // Thêm chú thích giải thích các thông số
    file write `file_handle' "<div class='info-box'>" _n
    file write `file_handle' "<h3 class='info-title'>Chú thích:</h3>" _n
    file write `file_handle' "<ul>" _n
    file write `file_handle' "<li><strong>Định tính - Nhị giá</strong>: Biến có 2 giá trị</li>" _n
    file write `file_handle' "<li><strong>Định tính - Danh định</strong>: Biến có nhiều hơn 2 giá trị, không có thứ tự</li>" _n
    file write `file_handle' "<li><strong>Định tính - Thứ bậc</strong>: Biến có nhiều hơn 2 giá trị, có thứ tự</li>" _n
    file write `file_handle' "<li><strong>TB</strong>: Trung bình</li>" _n
    file write `file_handle' "<li><strong>ĐLC</strong>: Độ lệch chuẩn</li>" _n
    file write `file_handle' "<li><strong>TV</strong>: Trung vị</li>" _n
    file write `file_handle' "<li><strong>KTPV</strong>: Khoảng tứ phân vị (Q1-Q3)</li>" _n
    file write `file_handle' "<li><strong>Min</strong>: Giá trị nhỏ nhất</li>" _n
    file write `file_handle' "<li><strong>Max</strong>: Giá trị lớn nhất</li>" _n
    file write `file_handle' "</ul>" _n
    
    // Hiển thị thông tin về tùy chọn cont() nếu được sử dụng
    if "`cont'" != "" {
        file write `file_handle' "<p><strong>Ghi chú:</strong> Các biến sau đây được chỉ định là biến định lượng: `cont'</p>" _n
    }
    
    file write `file_handle' "<p>Kiểm định phân phối chuẩn được thực hiện bằng kiểm định Shapiro-Wilk hoặc Skewness-Kurtosis.</p>" _n
    file write `file_handle' "</div>" _n
    
    // Footer
    file write `file_handle' "<div class='footer'>" _n
    file write `file_handle' "<p>Từ điển dữ liệu được tạo bởi Stata lecodebook | Ngày tạo: `c(current_date)' | Phiên bản Stata: `c(stata_version)'</p>" _n
    file write `file_handle' "</div>" _n
    
    file write `file_handle' "</div>" _n // đóng container
    file write `file_handle' "</body>" _n
    file write `file_handle' "</html>" _n
    
    file close `file_handle'
    local fullpath = "file:" + c(pwd) + "/" + "datadictionary.html"
    display as text _n "Copy liên kết dán vào trình duyệt hoặc tìm nguồn mở file {browse `fullpath'}"
	
    // Mở file trong trình duyệt
    display as text "File từ điển dữ liệu đã được tạo tại: `save'"
    display as text "Sử dụng nút 'Sao chép bảng' để sao chép bảng vào clipboard"
    winexec explorer.exe "`save'"
end