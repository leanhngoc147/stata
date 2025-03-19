// Xóa chương trình cũ nếu tồn tại
capture program drop lecodebook

*! version 1.4.0 19Mar2025
program define lecodebook, rclass byable(recall)
    // Chương trình tạo data dictionary cho toàn bộ dữ liệu
    syntax [varlist] [, CONT(string)]
    
    // Xác định vị trí lưu file (mặc định trong thư mục làm việc hiện tại)
    local save "datadictionary.html"
    local title "Data Dictionary"
    
    // CSS Style nâng cao hơn
    local css_style "<style>"
    local css_style `"`css_style' body {font-family: Arial, sans-serif; margin: 20px; line-height: 1.6;}"'
    local css_style `"`css_style' table {border-collapse: collapse; width: 100%; margin-bottom: 20px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); border-radius: 5px; overflow: hidden;}"'
    local css_style `"`css_style' th {background-color: #4472C4; color: white; font-weight: bold; text-align: left; padding: 12px; text-transform: uppercase; font-size: 14px;}"'
    local css_style `"`css_style' td {padding: 10px; border-bottom: 1px solid #ddd; vertical-align: top;}"'
    local css_style `"`css_style' tr:nth-child(even) {background-color: #f8f8f8;}"'
    local css_style `"`css_style' tr:hover {background-color: #f1f1f1;}"'
    local css_style `"`css_style' .copy-btn {padding: 12px 20px; background-color: #4472C4; color: white; border: none; border-radius: 4px; cursor: pointer; margin-bottom: 20px; font-weight: bold; transition: background-color 0.3s;}"'
    local css_style `"`css_style' .copy-btn:hover {background-color: #3a63b8;}"'
    local css_style `"`css_style' h1 {color: #333; margin-bottom: 20px; border-bottom: 2px solid #4472C4; padding-bottom: 10px;}"'
    local css_style `"`css_style' .var-name {font-weight: bold; color: #4472C4;}"'
    local css_style `"`css_style' .quant {color: #217346; font-weight: 500;}"'
    local css_style `"`css_style' .binary {color: #BF8F00; font-weight: 500;}"'
    local css_style `"`css_style' .nominal {color: #7030A0; font-weight: 500;}"'
    local css_style `"`css_style' .ordinal {color: #843C0B; font-weight: 500;}"'
    local css_style `"`css_style' .string {color: #C55A11; font-weight: 500;}"'
    local css_style `"`css_style' </style>"'
    
    // JavaScript cho nút sao chép
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
    file write `file_handle' "<html>" _n
    file write `file_handle' "<head>" _n
    file write `file_handle' "<meta charset='UTF-8'>" _n
    file write `file_handle' "<meta name='viewport' content='width=device-width, initial-scale=1.0'>" _n
    file write `file_handle' "<title>`title'</title>" _n
    file write `file_handle' `"`css_style'"' _n
    file write `file_handle' `"`js_code'"' _n
    file write `file_handle' "</head>" _n
    file write `file_handle' "<body>" _n
    file write `file_handle' "<h1>`title'</h1>" _n
    file write `file_handle' "<button class='copy-btn' onclick='copyTable()'>Sao chép bảng</button>" _n
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
                    local vartype "<span class='quant'>Biến định lượng (phân phối chuẩn)</span>"
                }
                else {
                    local vartype "<span class='quant'>Biến định lượng (không phân phối chuẩn)</span>"
                }
                
                // Tính toán các thống kê
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
                local vartype "<span class='binary'>Biến nhị giá</span>"
                
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
                    local vartype "<span class='ordinal'>Biến thứ tự</span>"
                }
                else {
                    // Biến danh định (nominal)
                    local vartype "<span class='nominal'>Biến danh định</span>"
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
                
                // Tính toán các thống kê
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
    
    // Thêm thông tin tổng quát về dữ liệu
    file write `file_handle' "<div style='margin-top: 20px; font-size: 14px; background-color: #f5f5f5; padding: 15px; border-radius: 5px;'>" _n
    file write `file_handle' "<p><strong>Thông tin dữ liệu:</strong></p>" _n
    file write `file_handle' "<ul>" _n
    file write `file_handle' "<li><strong>Số quan sát:</strong> `c(N)'</li>" _n
    file write `file_handle' "<li><strong>Số biến:</strong> `c(k)'</li>" _n
    file write `file_handle' "<li><strong>Ngày tạo từ điển:</strong> `c(current_date)'</li>" _n
    file write `file_handle' "</ul>" _n
    file write `file_handle' "</div>" _n
    
    // Thêm chú thích giải thích các thông số
    file write `file_handle' "<div style='margin-top: 20px; font-size: 14px;'>" _n
    file write `file_handle' "<p><strong>Chú thích:</strong></p>" _n
    file write `file_handle' "<ul>" _n
    file write `file_handle' "<li><strong>Biến nhị giá</strong>: Biến có 2 giá trị</li>" _n
    file write `file_handle' "<li><strong>Biến danh định</strong>: Biến có nhiều hơn 2 giá trị, không có thứ tự</li>" _n
    file write `file_handle' "<li><strong>Biến thứ tự</strong>: Biến có nhiều hơn 2 giá trị, có thứ tự</li>" _n
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
    
    file write `file_handle' "</body>" _n
    file write `file_handle' "</html>" _n
    
    file close `file_handle'
    
    // Mở file trong trình duyệt
    display as text "File từ điển dữ liệu đã được tạo tại: `save'"
    winexec explorer.exe "`save'"
end