{title:Tác giả}

{pstd}Lê Anh Ngọc{p_end}
{pstd}Đại học Y dược Thành phố Hồ Chí Minh{p_end}

{smcl}
{* *! version 1.0 01Jan2025}
{title:Tiêu đề của lệnh}

{phang}
{cmd:chidorihtml} {c -} Tạo bảng phân tích thống kê và xuất sang HTML

{title:Cú pháp}

{p 8 17 2}
{cmd:chidorihtml} {varlist} {ifin}, 
[{cmd:cont(}{it:varlist}{cmd:)} 
{cmd:uncont(}{it:varlist}{cmd:)} 
{cmd:output(}{it:filename}{cmd:)} 
{cmd:digit(}{it:integer}{cmd:)} 
{cmd:pdigit(}{it:integer}{cmd:)} 
{cmd:autoopen} 
{cmd:title(}{it:string}{cmd:)} 
{cmd:pnote(}{it:string}{cmd:)} 
{cmd:lang(}{it:string}{cmd:)} 
{cmd:robust(}{it:string}{cmd:)} 
{cmd:style(}{it:string}{cmd:)}]

{title:Mô tả}

{pstd}
{cmd:chidorihtml} là một lệnh Stata để tạo bảng phân tích thống kê và xuất sang tệp HTML. Lệnh này hỗ trợ phân tích các biến liên tục và không liên tục, 
với nhiều tùy chọn linh hoạt để tùy chỉnh đầu ra.

{title:Các tham số bắt buộc}

{phang}{it:varlist}: Danh sách các biến độc lập (nhóm) để phân tích.

{title:Các tùy chọn}

{phang}{cmd:cont(}{it:varlist}{cmd:)}: Danh sách các biến phụ thuộc liên tục. Các biến này sẽ được tính trung bình và độ lệch chuẩn.

{phang}{cmd:uncont(}{it:varlist}{cmd:)}: Danh sách các biến phụ thuộc không liên tục. Các biến này sẽ được tính trung vị và khoảng IQR.

{phang}{cmd:output(}{it:filename}{cmd:)}: Tên tệp HTML đầu ra. Nếu không chỉ định, chương trình sẽ tự động tạo tên tệp.

{phang}{cmd:digit(}{it:integer}{cmd:)}: Số chữ số thập phân cho các giá trị số. Mặc định là 3.

{phang}{cmd:pdigit(}{it:integer}{cmd:)}: Số chữ số thập phân cho giá trị p. Mặc định là 3.

{phang}{cmd:autoopen}: Tự động mở tệp HTML sau khi tạo.

{phang}{cmd:title(}{it:string}{cmd:)}: Tiêu đề của bảng. Mặc định là "KẾT QUẢ PHÂN TÍCH" (tiếng Việt) hoặc "ANALYSIS RESULTS" (tiếng Anh).

{phang}{cmd:pnote(}{it:string}{cmd:)}: Hiển thị chú thích về phương pháp thống kê. Sử dụng "TRUE" để kích hoạt.

{phang}{cmd:lang(}{it:string}{cmd:)}: Ngôn ngữ của báo cáo. Chọn "vie" (tiếng Việt) hoặc "eng" (tiếng Anh). Mặc định là "vie".

{phang}{cmd:robust(}{it:string}{cmd:)}: Sử dụng phương pháp robust. Chọn "true" hoặc "false". Mặc định là "false".

{phang}{cmd:style(}{it:string}{cmd:)}: Kiểu định dạng bảng. Chọn "le" cho kiểu đặc biệt hoặc để trống cho kiểu mặc định.

{title:Các phép kiểm định thống kê}

{pstd}Lệnh tự động lựa chọn các phép kiểm định phù hợp dựa trên loại biến:

{p 4 4 2}
- Biến nhị phân: 
  {space 4}• Biến liên tục: Kiểm định t hoặc Mann-Whitney
  {space 4}• Biến không liên tục: Kiểm định Mann-Whitney

{p 4 4 2}
- Biến đa phân: 
  {space 4}• Biến liên tục: Phân tích ANOVA
  {space 4}• Biến không liên tục: Kiểm định Kruskal-Wallis

{p 4 4 2}
- Biến liên tục độc lập: 
  {space 4}• Biến liên tục phụ thuộc: Tương quan Pearson
  {space 4}• Biến không liên tục phụ thuộc: Tương quan Spearman

{title:Ví dụ}

{phang}1. Phân tích cơ bản với các biến liên tục:
{p_end}
{inp}. chidorihtml giới_tính, cont(tuổi cân_nặng) lang(vie)

{phang}2. Phân tích với cả biến liên tục và không liên tục:
{p_end}
{inp}. chidorihtml nhóm, cont(năng_lực) uncont(kết_quả) pnote(TRUE) output(ketqua.html)

{phang}3. Phân tích với các tùy chọn nâng cao:
{p_end}
{inp}. chidorihtml điều_kiện, cont(chiều_cao cân_nặng) digit(2) pdigit(4) title(Kết quả nghiên cứu) lang(eng)

{title:Ghi chú}

{pstd}
- Đảm bảo tất cả các biến đều ở dạng số
- Kiểm tra kỹ các biến trước khi phân tích
- Liên hệ tác giả nếu gặp vấn đề: leanhngocump@gmail.com


{title:Phiên bản}

{pstd}1.0 - Phát hành ngày 01/01/2025{p_end}

{title:Bản quyền}

{pstd}© 2025 Lê Anh Ngọc. Bảo lưu mọi quyền.{p_end}

       +---------------------------------------------------------------------------------------------------------------------+
        | Lê Anh Ngọc                                                                                                       | 
       +---------------------------------------------------------------------------------------------------------------------+
        | Cơ quan         : Đại học Y dược Thành phố Hồ Chí Minh                                                            |
        | ngày phát hành  : 01/01/2025                   								    |
        | Email           : leanhngocump@gmail.com                                                                          |
        | --> nếu bạn có nhu cầu hỗ trợ về phương pháp nghiên cứu hoặc phân tích số liệu, đừng ngại hãy gửi mail cho tôi <3 |
       +---------------------------------------------------------------------------------------------------------------------+