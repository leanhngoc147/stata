help sharinganhtml

Tiêu đề: Biểu đồ Sharingan dạng HTML

Cú pháp

    sharinganhtml [danh_sách_biến] [, DIGIT(số_nguyên 1) OUTPUT(chuỗi) AUTOOPEN ///
                     TITLE(chuỗi) THEME(chuỗi) NOSORT INDENT(chuỗi)]


Mô tả

    sharinganhtml tạo ra một biểu đồ Sharingan ở định dạng HTML. Biểu đồ hiển thị mối quan hệ giữa các biến trong tập dữ liệu.

Tùy chọn

    danh_sách_biến chỉ định các biến được đưa vào biểu đồ.

    DIGIT(số_nguyên 1) chỉ định số chữ số thập phân hiển thị cho các biến số. Mặc định là 1.

    OUTPUT(chuỗi) chỉ định tên file cho file HTML đầu ra. Nếu không được chỉ định, biểu đồ sẽ được hiển thị trong trình duyệt web mặc định.

    AUTOOPEN chỉ định rằng file HTML đầu ra sẽ tự động mở trong trình duyệt web mặc định.

    TITLE(chuỗi) chỉ định tiêu đề của biểu đồ.

    THEME(chuỗi) chỉ định chủ đề cho biểu đồ. Các chủ đề hợp lệ là "light" và "dark". Mặc định là "light".

    NOSORT chỉ định rằng các biến không nên được sắp xếp theo thứ tự bảng chữ cái trong biểu đồ.

    INDENT(chuỗi) chỉ định chuỗi thụt đầu dòng được sử dụng cho mã HTML. Mặc định là bốn khoảng trắng.

Ví dụ

    sharinganhtml mpg weight price

    sharinganhtml mpg weight price, digit(2) output("bieu_do_cua_toi.html") autoopen title("Biểu đồ Sharingan của tôi") theme("dark") nosort

Tác giả

    leanhngoc147

Email

    email_cua_ban@example.com

Ngày

    1 Tháng 1 2025