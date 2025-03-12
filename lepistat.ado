capture program drop lepistat
program define lepistat
	* Mở trình duyệt mặc định và truy cập vào trang web Lepistat
	local url "https://ngocanhle.shinyapps.io/lepistat/"
	
	* Kiểm tra hệ điều hành và sử dụng lệnh mở trình duyệt phù hợp
	if "$S_OS" == "Windows" {
		shell start `url'
	}
	else if "$S_OS" == "MacOS" {
		shell open `url'
	}
	else if "$S_OS" == "Unix" {
		shell xdg-open `url'
	}
	else {
		di as error "Không thể mở trình duyệt. Vui lòng truy cập thủ công vào: `url'"
	}
end

* Ghi chú sử dụng
* Sau khi nhập function này vào Stata, bạn có thể gõ lệnh lepistat để mở trang web