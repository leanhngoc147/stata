{smcl}
{* *! version 1.0.0 16jan2025}{...}
{title:Title}

{phang}
{bf:rasenganhtml} {hline 2} Tạo bảng phân tích dữ liệu dưới dạng HTML

{marker syntax}{...}
{title:Cú pháp}

{p 8 17 2}
{cmdab:rasenganhtml} {varlist} {ifin}{cmd:,} {opth by(varname)} [{it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Tùy chọn chính}
{synopt:{opth by(varname)}}biến phân nhóm (nhị phân 0/1){p_end}
{synopt:{opt ib(#)}}chọn nhóm tham chiếu (mặc định là 1){p_end}
{synopt:{opt ratio(string)}}chọn tỷ số (OR/RR/PR, mặc định là OR){p_end}
{synopt:{opt per(string)}}tính phần trăm theo hàng/cột (row/col, mặc định là row){p_end}

{syntab:Tùy chọn định dạng}
{synopt:{opt output(string)}}tên file đầu ra (mặc định là rasengan.html){p_end}
{synopt:{opt digit(#)}}số chữ số thập phân (mặc định là 1){p_end}
{synopt:{opt title(string)}}tiêu đề của bảng{p_end}
{synopt:{opt lang(string)}}ngôn ngữ (vie/eng, mặc định là vie){p_end}
{synopt:{opt N(string)}}hiển thị số quan sát (TRUE/FALSE){p_end}
{synopt:{opt pnote(string)}}thêm chú thích cho giá trị p (TRUE/FALSE){p_end}
{synopt:{opt autoopen}}tự động mở file sau khi tạo{p_end}

{marker description}{...}
{title:Mô tả}

{pstd}
{cmd:rasenganhtml} tạo bảng phân tích dữ liệu dưới dạng file HTML, so sánh các đặc điểm giữa hai nhóm. 
Lệnh này tính toán tần số, phần trăm cho biến phân loại và trung bình ± độ lệch chuẩn cho biến liên tục. 
Đồng thời tính toán giá trị p và các tỷ số (OR/RR/PR) với khoảng tin cậy 95%.

{marker options}{...}
{title:Tùy chọn}

{dlgtab:Tùy chọn chính}

{phang}
{opt by(varname)} chỉ định biến phân nhóm nhị phân (0/1) để so sánh. Tùy chọn này là bắt buộc.

{phang}
{opt ib(#)} chỉ định nhóm tham chiếu khi tính toán tỷ số. Mặc định là 1.

{phang}
{opt ratio(string)} chỉ định loại tỷ số cần tính:
{p_end}
{phang2}- OR: Odds ratio (mặc định){p_end}
{phang2}- RR: Risk ratio{p_end}
{phang2}- PR: Prevalence ratio{p_end}

{phang}
{opt per(string)} chỉ định cách tính phần trăm:
{p_end}
{phang2}- row: tính theo hàng (mặc định){p_end}
{phang2}- col: tính theo cột{p_end}

{dlgtab:Tùy chọn định dạng}

{phang}
{opt output(string)} chỉ định tên file đầu ra. Mặc định là "rasengan.html".

{phang}
{opt digit(#)} chỉ định số chữ số thập phân cho các kết quả số. Mặc định là 1.

{phang}
{opt title(string)} chỉ định tiêu đề cho bảng kết quả.

{phang}
{opt lang(string)} chọn ngôn ngữ hiển thị (vie/eng). Mặc định là tiếng Việt.

{phang}
{opt N(string)} hiển thị số quan sát cho mỗi biến. Đặt "TRUE" để hiển thị.

{phang}
{opt pnote(string)} thêm chú thích cho giá trị p (kiểm định chi bình phương/Fisher). Đặt "TRUE" để hiển thị.

{phang}
{opt autoopen} tự động mở file HTML sau khi tạo.

{marker examples}{...}
{title:Ví dụ}

{pstd}Tạo bảng phân tích cơ bản{p_end}
{phang2}{cmd:. rasenganhtml tuoi gioitinh dieutri, by(nhom)}{p_end}

{pstd}Tính tỷ số nguy cơ (RR) với phần trăm theo cột{p_end}
{phang2}{cmd:. rasenganhtml tuoi gioitinh dieutri, by(nhom) ratio(RR) per(col)}{p_end}

{pstd}Tùy chỉnh định dạng và ngôn ngữ{p_end}
{phang2}{cmd:. rasenganhtml tuoi gioitinh dieutri, by(nhom) digit(2) title("Phân tích đặc điểm bệnh nhân") lang(vie) N(TRUE) pnote(TRUE)}{p_end}

{marker results}{...}
{title:Kết quả trả về}

{pstd}
{cmd:rasenganhtml} trả về các giá trị sau trong {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:r(output)}}tên file HTML đã tạo{p_end}
{synopt:{cmd:r(timestamp)}}thời gian tạo file{p_end}

{marker author}{...}
{title:Tác giả}

Hãy cho tôi biết để tôi có thể hỗ trợ bạn tốt hơn: leanhngocump@gmail.com


       +---------------------------------------------------------------------------------------------------------------------+
        | Lê Anh Ngọc                                                                                                       | 
       +---------------------------------------------------------------------------------------------------------------------+
        | Cơ quan         : Đại học Y dược Thành phố Hồ Chí Minh                                                            |
        | ngày phát hành  : 04/01/2025                   								    |
        | Email           : leanhngocump@gmail.com                                                                          |
        | --> nếu bạn có nhu cầu hỗ trợ về phương pháp nghiên cứu hoặc phân tích số liệu, đừng ngại hãy gửi mail cho tôi <3 |
       +---------------------------------------------------------------------------------------------------------------------+
{marker also_see}{...}
{title:Xem thêm}