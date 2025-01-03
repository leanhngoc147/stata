capture program drop whattest

program whattest
    args option

    if "`option'" == "html" {
        local pwd : pwd
        local filepath "`pwd'\kiemdinh_result.html"
		quietly {
            tempname myfile
            tempfile htmlfile
            file open `myfile' using `htmlfile', write replace text
            
            file write `myfile' "<!DOCTYPE html>" _n
            file write `myfile' "<html>" _n
            file write `myfile' "<head>" _n
            file write `myfile' "<style>" _n
            file write `myfile' "body {font-family: Arial, sans-serif; margin: 20px; background: #f0f8ff;}" _n
            file write `myfile' "h2 {color: #1a5f7a; margin-top: 30px;}" _n
            file write `myfile' "table {border-collapse: collapse; width: 100%; margin-bottom: 30px; background: white; box-shadow: 0 2px 4px rgba(0,0,0,0.1);}" _n
            file write `myfile' "th {background: #2c88d9; color: white; padding: 12px; text-align: left;}" _n
            file write `myfile' "td {padding: 10px; border: 1px solid #e0e0e0;}" _n
            file write `myfile' "tr:nth-child(even) {background: #f5f9ff;}" _n
            file write `myfile' "tr:hover {background: #e6f3ff;}" _n
            file write `myfile' ".container {max-width: 1200px; margin: 0 auto; padding: 20px;}" _n
            file write `myfile' "</style>" _n
            file write `myfile' "</head>" _n
            file write `myfile' "<body><div class='container'>" _n
            
            file write `myfile' "<h2>Bảng Kiểm Định Phù Hợp (Quan Sát Độc Lập)</h2>" _n
            file write `myfile' "<table>" _n
            file write `myfile' "<tr><th>Biến phụ thuộc</th><th>Nhị giá</th><th>Danh định</th><th>Thứ tự</th><th>Định lượng (PP bình thường)</th></tr>" _n
            file write `myfile' "<tr><td>Nhị giá</td><td>Chi2/Fisher</td><td>Chi2/Fisher</td><td>Chi2/Fisher</td><td>Logistic regression</td></tr>" _n
            file write `myfile' "<tr><td>Danh định</td><td>Chi2/Fisher</td><td>Chi2/Fisher</td><td>Chi2/Fisher</td><td>Logistic regression</td></tr>" _n
            file write `myfile' "<tr><td>Thứ tự</td><td>Chi2/Fisher</td><td>Chi2/Fisher</td><td>Chi2/Fisher</td><td>Logistic regression</td></tr>" _n
            file write `myfile' "<tr><td>Định lượng (PP bình thường)</td><td>T-test</td><td>ANOVA</td><td>ANOVA</td><td>Pearson correlation</td></tr>" _n
            file write `myfile' "<tr><td>Định lượng (không PP)</td><td>Wilcoxon rank</td><td>Kruskal Wallis</td><td>Kruskal Wallis</td><td>Spearman correlation</td></tr>" _n
            file write `myfile' "</table>" _n

            file write `myfile' "<h2>Bảng Kiểm Định Phù Hợp (Quan Sát Không Độc Lập)</h2>" _n
            file write `myfile' "<table>" _n
            file write `myfile' "<tr><th>Biến phụ thuộc</th><th>Nhị giá</th><th>Danh định</th><th>Thứ tự</th><th>Định lượng (PP bình thường)</th></tr>" _n
            file write `myfile' "<tr><td>Nhị giá</td><td>McNemar's test</td><td>McNemar's test</td><td>McNemar's test</td><td>GEE</td></tr>" _n
            file write `myfile' "<tr><td>Danh định</td><td>McNemar's test</td><td>Cochrane Q</td><td>Cochrane Q</td><td>GEE</td></tr>" _n
            file write `myfile' "<tr><td>Thứ tự</td><td>McNemar's test</td><td>Cochrane Q</td><td>Cochrane Q</td><td>GEE</td></tr>" _n
            file write `myfile' "<tr><td>Định lượng (PP bình thường)</td><td>Paired T-test</td><td>Repeated ANOVA</td><td>Repeated ANOVA</td><td>GEE/Mixed Model</td></tr>" _n
            file write `myfile' "<tr><td>Định lượng (không PP)</td><td>Wilcoxon signed rank</td><td>Friedman test</td><td>Friedman test</td><td>GEE/GLMM</td></tr>" _n
            file write `myfile' "</table>" _n

            file write `myfile' "<h2>Bảng Chỉ Số Tỉ Số Kết Hợp</h2>" _n
            file write `myfile' "<table>" _n
            file write `myfile' "<tr><th>Thiết kế nghiên cứu</th><th>Số đo kết hợp</th><th>Tiếng Anh</th><th>Ký hiệu</th></tr>" _n
            file write `myfile' "<tr><td>Cắt ngang</td><td>Tỉ số hiện mắc<br>Tỉ số chênh</td><td>Prevalence Ratio<br>Odds Ratio</td><td>PR<br>OR</td></tr>" _n
            file write `myfile' "<tr><td>Bệnh chứng</td><td>Tỉ số chênh</td><td>Odds Ratio</td><td>OR</td></tr>" _n
            file write `myfile' "<tr><td>Đoàn hệ</td><td>Tỉ số chênh<br>Tỉ số mới mắc<br>Tỉ số nguy hại</td><td>Odds Ratio<br>Risk Ratio<br>Hazard Ratio</td><td>OR<br>RR<br>HR</td></tr>" _n
            file write `myfile' "<tr><td>Thực nghiệm lâm sàng</td><td>Tỉ số chênh<br>Tỉ số mới mắc<br>Tỉ số nguy hại</td><td>Odds Ratio<br>Risk Ratio<br>Hazard Ratio</td><td>OR<br>RR<br>HR</td></tr>" _n
            file write `myfile' "</table>" _n

            file write `myfile' "</div></body></html>" _n
            file close `myfile'
            
            copy `htmlfile' "`filepath'", replace
        }
        di _n
        di in green "-----------------------------------------------------"
        di in green "File HTML đã được tạo tại thư mục:"
        di in yellow "`pwd'\kiemdinh_result.html"
        di in green "-----------------------------------------------------"
        exit
    }

    // Console display
    di in green "-----------------------------------------------------------------"
    di in green "          BẢNG KIỂM ĐỊNH PHÙ HỢP (QUAN SÁT ĐỘC LẬP)              "
    di in green "-----------------------------------------------------------------"
    di "+-----------------------------+---------------+----------------+---------------+----------------------------+"
    di "| Biến phụ thuộc              | Nhị giá       | Danh định      | Thứ tự        | Định lượng (PP bình thường)|"
    di "+-----------------------------+---------------+----------------+---------------+----------------------------+"
    di "| Nhị giá                     | Chi2/Fisher   | Chi2/Fisher    | Chi2/Fisher   | Logistic regression        |"
    di "| Danh định                   | Chi2/Fisher   | Chi2/Fisher    | Chi2/Fisher   | Logistic regression        |"
    di "| Thứ tự                      | Chi2/Fisher   | Chi2/Fisher    | Chi2/Fisher   | Logistic regression        |"
    di "| Định lượng (PP bình thường) | T-test        | ANOVA          | ANOVA         | Pearson correlation        |"
    di "| Định lượng (không PP)       | Wilcoxon rank | Kruskal Wallis | Kruskal Wallis| Spearman correlation       |"
    di "+-----------------------------+---------------+----------------+---------------+----------------------------+"

    di in green "-----------------------------------------------------------------"
    di in green "        BẢNG KIỂM ĐỊNH PHÙ HỢP (QUAN SÁT KHÔNG ĐỘC LẬP)"
    di in green "-----------------------------------------------------------------"
    di "+-----------------------------+----------------------+----------------+----------------+----------------------------+"
    di "| Biến phụ thuộc              | Nhị giá              | Danh định      | Thứ tự         | Định lượng (PP bình thường)|"
    di "+-----------------------------+----------------------+----------------+----------------+----------------------------+"
    di "| Nhị giá                     | McNemar's test       | McNemar's test | McNemar's test | GEE                        |"
    di "| Danh định                   | McNemar's test       | Cochrane Q     | Cochrane Q     | GEE                        |"
    di "| Thứ tự                      | McNemar's test       | Cochrane Q     | Cochrane Q     | GEE                        |"
    di "| Định lượng (PP bình thường) | Paired T-test        | Repeated ANOVA | Repeated ANOVA | GEE/Mixed Model            |"
    di "| Định lượng (không PP)       | Wilcoxon signed rank | Friedman test  | Friedman test  | GEE/GLMM                   |"
    di "+-----------------------------+----------------------+----------------+----------------+----------------------------+"

    di in green "-----------------------------------------------------------------"
    di in green "     BẢNG CHỈ SỐ TỈ SỐ KẾT HỢP TRONG CÁC THIẾT KẾ NGHIÊN CỨU"
    di in green "-----------------------------------------------------------------"
    di "+----------------------+-------------------------------+------------------------+----------------+"
    di "| THIẾT KẾ NGHIÊN CỨU  | SỐ ĐO KẾT HỢP                 | TIẾNG ANH              | KÝ HIỆU        |"
    di "+----------------------+-------------------------------+------------------------+----------------+"
    di "| Cắt ngang            | Tỉ số hiện mắc, Tỉ số chênh   | Prevalence Ratio, OR   | PR, OR         |"
    di "+----------------------+-------------------------------+------------------------+----------------+"
	di "| Bệnh chứng           | Tỉ số chênh                   | Odds Ratio             | OR             |"
    di "+----------------------+-------------------------------+------------------------+----------------+"
	di "| Đoàn hệ              | Tỉ số chênh                   | Odds Ratio             | OR             |"
    di "|                      | Tỉ số mới mắc                 | Risk Ratio             | RR             |"
	di "|                      | Tỉ số nguy hại                | Hazard Ratio           | HR             |"
    di "+----------------------+-------------------------------+------------------------+----------------+"
	di "| Thực nghiệm lâm sàng | Tỉ số chênh                   | Odds Ratio             | OR             |"
    di "|                      | Tỉ số mới mắc                 | Risk Ratio             | RR             |"
	di "|                      | Tỉ số nguy hại                | Hazard Ratio           | HR             |"
    di "+----------------------+-------------------------------+------------------------+----------------+"
end