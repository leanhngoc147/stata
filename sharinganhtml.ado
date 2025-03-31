capture program drop sharinganhtml
program define sharinganhtml, rclass
    version 14.0

    syntax [varlist] [, DIGIT(integer 1) OUTPUT(string) AUTOOPEN ///
        TITLE(string) THEME(string) NOSORT INDENT(string) MISSING]

	//in hình sharingan	
display as text "███████╗██╗  ██╗ █████╗ ██████╗ ██╗███╗   ██╗ ██████╗  █████╗ ███╗   ██╗  "
display as text "██╔════╝██║  ██║██╔══██╗██╔══██╗██║████╗  ██║██╔════╝ ██╔══██╗████╗  ██║  "
display as text "███████╗███████║███████║██████╔╝██║██╔██╗ ██║██║  ███╗███████║██╔██╗ ██║  "
display as text "╚════██║██╔══██║██╔══██║██╔══██╗██║██║╚██╗██║██║   ██║██╔══██║██║╚██╗██║  "
display as text "███████║██║  ██║██║  ██║██║  ██║██║██║ ╚████║╚██████╔╝██║  ██║██║ ╚████║"
display as text "╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝"
display as text "⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿"
display as text "⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿"
display as text "⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣐⣠⣥⡄⠀⠀⠀⠀⠀⠀⠀⢠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⢸"
display as text "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣀⣠⣤⣴⣶⣾⣿⠟⢹⣿⣷⠀⠀⠀⠀⠀⠀⠀⢸⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡾"
display as text "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⠟⢉⣁⣄⣉⣠⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⢨⣅⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣷"
display as text "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⠏⣰⡟⠉⣉⡉⠻⠿⠟⠛⠃⠀⡀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢺⣿⣿"
display as text "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⠿⠟⠀⠛⠀⠈⠉⠀⡀⢠⣶⣾⣿⠀⣿⠀⠀⠀⠀⣸⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⢿⣿"
display as text "⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⣤⣤⣤⠀⣠⡀⠳⠦⠶⠞⢁⣾⣿⣿⣿⠀⣿⡇⠀⠀⠀⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣟⣾⡟"
display as text "⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣇⠀⣿⣿⣿⣤⣬⣤⣤⣤⣶⣾⣿⣿⣿⣿⣿⠠⠿⠟⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣽⣿⠃"
display as text "⡇⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⠀⢿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠟⠛⠋⠉⠀⢀⣠⣤⠀⠀⠀⢚⠭⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⡟⠀"
display as text "⣇⠀⠀⠀⠀⠀⠀⠀⠀⠰⠿⠇⠘⠛⠛⠛⠉⠉⠁⢀⣀⣠⣤⣤⣶⣾⣿⡿⢛⣥⡆⠀⠀⢠⠊⢠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢼⣿⠁⠀"
display as text "⣿⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⡀⠀⣀⣀⣒⠶⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⢀⣿⣏⡴⠀⢠⡜⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠀⠀"
display as text "⣿⡇⠀⠀⠀⠀⠀⠀⠀⢸⠿⣋⡤⠽⠿⠻⠥⢭⣟⣳⣶⣝⠿⣿⣿⣿⣿⢸⡇⣿⣷⠀⢠⣤⣶⣿⡇⠀⠀⠀⠀⠀⠀⠀⢀⠁⠀⠀⠀⠀"
display as text "⣿⣇⠀⠀⠀⠀⠀⠀⠀⠐⠛⢡⣴⢠⡏⠀⠄⠢⠀⢉⣻⡍⢷⣿⣿⣿⣿⢸⣷⣝⢿⡆⢸⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠄⠀⢠⠀⠀⠀"
display as text "⣿⣿⠀⠀⠀⠀⠀⠀⠀⢸⣷⣌⠻⣧⠁⠤⠀⠀⣀⣤⣶⢇⣾⣿⣿⣿⣿⡟⣿⣿⣦⡁⢸⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠌⠀⠀⠰⠃⠀⠀"
display as text "⣿⣿⡆⠀⠀⠀⠀⠀⠀⢸⣿⣿⣥⣴⣆⣤⣶⣿⣿⣿⡏⣼⣿⣿⣿⣿⣿⣇⣿⣿⣿⣇⣬⡻⣿⣿⡇⠀⠀⠀⠀⠀⠨⢀⠀⠀⠀⠀⠀⠀"
display as text "⣿⣿⡇⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢱⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣮⠻⡇⠀⠀⠀⠀⠀⠅⡠⠀⠀⠀⠀⠀⠀"
display as text "⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⠇⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡄⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀"
display as text "⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⣿⣿⣿⡟⣼⣿⣿⣿⣿⣿⢿⣿⣿⣿⠿⣻⣿⣿⣿⣿⣿⡇⠀⠀⣀⠀⢈⠀⠀⠀⠀⠀⠀⠀⠀"
display as text "⣿⣿⣿⡇⠀⡀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⢇⣿⣿⣿⣿⣿⣿⣶⣭⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⢠⠀⢻⣧⠠⠀⠀⠀⠀⠀⠀⠀⠀"
display as text "⣿⣿⣿⣧⠀⠇⠀⠀⠀⠀⢀⠀⠘⠤⢻⣿⣿⡿⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣿⠀⠀⢻⣧⠀⠀⠀⠀⠀⠀⠀⠀"
display as text "⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⢸⠀⠈⢀⠆⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⣟⣛⣭⣭⣭⣷⣿⢣⣿⠀⠀⠀⢻⣇⠀⠀⠀⠀⠀⠀⠀"
display as text "⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⡄⠀⠈⠀⠀⠈⠻⢿⣿⣿⣿⣿⣿⣿⣯⣶⣾⠿⠿⣛⣻⣭⣼⣿⣿⣼⣿⠀⠀⠀⠈⣿⡀⠀⠀⠀⠀⠀⠀"
display as text "⣿⣿⣿⣿⣷⠀⢲⠀⠀⡄⠀⠀⣸⠁⠀⠀⠀⠀⠀⣝⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠈⠀⠀⠀⠸⣷⠀⠀"
display as text "⣿⣿⣿⣿⣿⡄⢸⠀⠀⣧⠀⠀⡏⠀⠀⠀⠀⠀⠀⢸⣿⡄⡝⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠣⠀⠀⠀⡀⠀⢹⣇"
display as text "⣿⣿⣿⣿⣿⡇⣨⣀⠀⠙⡆⢰⣏⠀⠀⠀⠀⠀⠀⠈⣿⣷⠹⢀⠤⡮⣙⠻⠿⣿⣿⣿⣿⠿⢋⠡⠀⢄⡀⠀⢀⠅⡊⣀⢻⡄"
		
		
    // format
    local bg_color "#ffffff"
    local text_color "#000000"
    local border_color "#dddddd"
    local header_bg "#f2f2f2"
    local row_alt_bg "#f9f9f9"
    local indent_style ""
    local border_style "1px solid"
    local header_border_style "1px solid"
    local row_border_style "1px solid"
    local font_family "Arial, sans-serif"
    local table_border_style "1px solid"
    local table_border_color "#dddddd"
    local header_font_weight "bold"
    local header_font_style ""
    local header_text_align "center"
    local data_text_align "left"
    local number_text_align "center"

    if "`indent'" != "" {
        local indent_style " style='padding-left: `indent'px;'"
    }

    if `digit' < 0 {
        display as error "Digit option must be non-negative"
        exit 198
    }

    if "`varlist'" == "" {
        quietly ds
        local varlist `r(varlist)'
    }

    // Create a local to store variables with missing values
    local vars_with_missing ""
    // Variables to store total missing calculations
    local total_cells 0
    local total_missing 0
    
    // Check for missing values in each variable if missing option is specified
    if "`missing'" != "" {
        qui count
        local total_obs = r(N)
        
        foreach var of local varlist {
            local total_cells = `total_cells' + `total_obs'
            qui count if missing(`var')
            local curr_missing = r(N)
            local total_missing = `total_missing' + `curr_missing'
            
            if `curr_missing' > 0 {
                local vars_with_missing "`vars_with_missing' `var'"
            }
        }
        // If missing option is specified, only use variables with missing values
        local varlist "`vars_with_missing'"
    }

    if "`title'" == "" {
        local title "Báo cáo thống kê mô tả"
    }

    // Xử lý tên file output
    local file_prefix "sharingan"
    local output "`file_prefix'.html"
    local counter 1

    while fileexists("`output'") {
        local output "`file_prefix'_`counter'.html"
        local counter = `counter' + 1
        if `counter' > 999 {
            display as error "Đã tồn tại quá nhiều tệp"
            exit 603
        }
    }

    // Define themes
    if "`theme'" == "dark" {
        local bg_color "#2d2d2d"
        local text_color "#ffffff"
        local border_color "#555555"
        local header_bg "#3d3d3d"
        local row_alt_bg "#353535"
        local table_border_color "#555555"
    }
    
    // Lancet theme
    if "`theme'" == "lancet" {
        local bg_color "#ffffff"
        local text_color "#000000"
        local border_color "#cccccc"
        local header_bg "#ffffff"
        local row_alt_bg "#f8f8f8"
        local border_style "1px solid"
        local header_border_style "2pt solid"
        local row_border_style "1pt solid"
        local font_family "Georgia, Times, serif"
        local table_border_style "2pt solid"
        local table_border_color "#000000"
        local header_font_weight "bold"
        local header_font_style "normal"
        local header_text_align "center"
        local data_text_align "left"
        local number_text_align "right"
    }
    
    // YTCC (Public Health) theme
    if "`theme'" == "ytcc" {
        local bg_color "#ffffff"
        local text_color "#000000"
        local border_color "#000000"
        local header_bg "#ffffff"
        local row_alt_bg "#ffffff"
        local border_style "0pt solid"
        local header_border_style "1pt solid"
        local row_border_style "0pt solid"
        local font_family "Arial, Helvetica, sans-serif"
        local table_border_style "2pt solid"
        local table_border_color "#000000"
        local header_font_weight "bold"
        local header_font_style "normal"
        local header_text_align "center"
        local data_text_align "left"
        local number_text_align "center"
    }
    
    // Combined frequency and percentage column for theme2
    local combined_cols = 0
    if "`theme'" == "theme2" {
        local combined_cols = 1
    }

    cap file open html_output using "`output'", write replace
    if _rc {
        display as error "Không thể tạo tệp đầu ra"
        exit _rc
    }

    file write html_output ///
        "<!DOCTYPE html>" _n ///
        "<html><head>" _n ///
        "<meta charset='UTF-8'>" _n ///
        "<meta name='viewport' content='width=device-width, initial-scale=1.0'>" _n ///
        "<title>`title'</title>" _n ///
        "<style>" _n ///
        "body {font-family: `font_family'; margin: 20px; background: `bg_color'; color: `text_color';}" _n ///
        "h1 {text-align: center;}" _n ///
        ".container {max-width: 1200px; margin: 0 auto; position: relative;}" _n ///
        ".copy-button {position: absolute; right: 0; top: -50px; padding: 8px 16px;" _n ///
        "  background-color: #4CAF50; color: white; border: none; border-radius: 4px;" _n ///
        "  cursor: pointer; font-size: 14px;}" _n ///
        ".copy-btn {" _n ///
        "    background-color: #4CAF50;" _n ///
        "    border: none;" _n ///
        "    color: white;" _n ///
        "    padding: 10px 20px;" _n ///
        "    text-align: center;" _n ///
        "    text-decoration: none;" _n ///
        "    display: inline-block;" _n ///
        "    font-size: 16px;" _n ///
        "    margin: 4px 2px;" _n ///
        "    cursor: pointer;" _n ///
        "    border-radius: 4px;" _n ///
        "}" _n ///
        ".copy-btn:hover {" _n ///
        "    background-color: #45a049;" _n ///
        "}" _n ///
        ".copy-btn:active {" _n ///
        "    background-color: #3d8b40;" _n ///
        "}" _n ///
        "table {width: 100%; border-collapse: collapse; margin: 20px 0; border-top: `table_border_style' `table_border_color'; border-bottom: `table_border_style' `table_border_color';}" _n ///
        "th, td {border: `border_style' `border_color'; padding: 12px; text-align: `data_text_align';}" _n ///
        "th {background: `header_bg'; font-weight: `header_font_weight'; font-style: `header_font_style'; text-align: `header_text_align'; border-bottom: `header_border_style' `border_color';}" _n ///
        "tr:nth-child(even) {background: `row_alt_bg';}" _n ///
        "tr td {border-bottom: `row_border_style' `border_color';}" _n ///
        ".var-header {background: `header_bg'; font-weight: bold;}" _n ///
        ".continuous-stats {font-style: italic;}" _n ///
        ".number {text-align: `number_text_align';}" _n ///
        ".center {text-align: center;}" _n ///
        ".summary-text {text-align: center; font-weight: bold; margin-top: 20px;}" _n ///
        ".notification {display: none; position: fixed; top: 20px; right: 20px;" _n ///
        "  background-color: #4CAF50; color: white; padding: 16px; border-radius: 4px;" _n ///
        "  animation: fadeOut 2s ease-in-out forwards; animation-delay: 1s;}" _n ///
        "@keyframes fadeOut {from {opacity: 1;} to {opacity: 0;}}" _n ///
        "@media print {" _n ///
        "  body {background: white; color: black;}" _n ///
        "  table {border-top: `table_border_style' black; border-bottom: `table_border_style' black;}" _n ///
        "  th {border-bottom: `header_border_style' black;}" _n ///
        "  tr td {border-bottom: `row_border_style' black;}" _n ///
        "  .copy-button, .notification {display: none;}" _n ///
        "}" _n ///
        "@media (max-width: 600px) {" _n ///
        "  table {font-size: 14px;}" _n ///
        "  th, td {padding: 8px;}" _n ///
        "}" _n ///
        "</style>" _n ///
        "<script>" _n ///
        "function copyTableToClipboard() {" _n ///
        "    const table = document.querySelector('table');" _n ///
        "    const range = document.createRange();" _n ///
        "    range.selectNode(table);" _n ///
        "    window.getSelection().removeAllRanges();" _n ///
        "    window.getSelection().addRange(range);" _n ///
        "    try {" _n ///
        "        document.execCommand('copy');" _n ///
        "        const btn = document.querySelector('.copy-btn');" _n ///
        "        const originalText = btn.textContent;" _n ///
        "        btn.textContent = 'Copied!';" _n ///
        "        setTimeout(() => {" _n ///
        "            btn.textContent = originalText;" _n ///
        "        }, 2000);" _n ///
        "    } catch (err) {" _n ///
        "        console.error('Failed to copy table:', err);" _n ///
        "    }" _n ///
        "    window.getSelection().removeAllRanges();" _n ///
        "}" _n ///
		 "function switchDecimalSeparator() {" _n ///
        "    const table = document.querySelector('table');" _n ///
        "    const btn = document.querySelector('.decimal-btn');" _n ///
        "    const cells = table.querySelectorAll('td');" _n ///
        "    let currentSeparator = '.';" _n ///
        "    let newSeparator = ',';" _n ///
        "    " _n ///
        "    // Check if we're switching back from comma to dot" _n ///
        "    if (btn.getAttribute('data-current') === 'comma') {" _n ///
        "        currentSeparator = ',';" _n ///
        "        newSeparator = '.';" _n ///
        "        btn.setAttribute('data-current', 'dot');" _n ///
        "        btn.textContent = 'Use Comma (,) Decimal';" _n ///
        "    } else {" _n ///
        "        btn.setAttribute('data-current', 'comma');" _n ///
        "        btn.textContent = 'Use Dot (.) Decimal';" _n ///
        "    }" _n ///
        "    " _n ///
        "    // Replace all decimals in table, including <0.001 format" _n ///
        "    cells.forEach(cell => {" _n ///
        "        const text = cell.innerHTML;" _n ///
        "        // First handle the <0.001 case" _n ///
        "        let newText = text.replace(new RegExp('<0\\' + currentSeparator + '001', 'g'), '<0' + newSeparator + '001');" _n ///
        "        // Then handle regular numbers with decimal points" _n ///
        "        const regex = new RegExp('(\\d+)\\' + currentSeparator + '(\\d+)', 'g');" _n ///
        "        newText = newText.replace(regex, '$1' + newSeparator + '$2');" _n ///
        "        cell.innerHTML = newText;" _n ///
        "    });" _n ///
        "}" _n ///
        "</script>" _n ///
        "</head><body>" _n ///
        "<h1>`title'</h1>" _n ///
        "<div class='container'>" _n ///
        "<button class='copy-btn' onclick='copyTableToClipboard()'>Copy Table</button>" _n ///
		"<button class='btn decimal-btn' onclick='switchDecimalSeparator()' data-current='dot'>Use Comma (,) Decimal</button>" _n ///
        "<table>" _n
    
    // Table header based on theme
    if `combined_cols' == 1 {
        file write html_output "<tr><th>Đặc điểm</th><th class='number'>Tần số (Tỷ lệ %)</th></tr>" _n
    }
    else {
        file write html_output "<tr><th>Đặc điểm</th><th class='number'>Tần số</th><th class='number'>Tỷ lệ (%)</th></tr>" _n
    }

    foreach var of local varlist {
        cap {
            local vlab : variable label `var'
            if "`vlab'" == "" local vlab "`var'"

            qui codebook `var', compact
            local type = r(type)
            local N = r(N)

            local has_vallabel : value label `var'

            local is_continuous = 0
            if "`has_vallabel'" == "" {
                if r(unique) >= 10 {
                    qui sum `var'
                    if r(min) >= 0 & r(max) <= 100 & `N' > 0 {
                        local is_continuous = (r(unique) > 20)
                    }
                    else {
                        local is_continuous = 1
                    }
                }
            }

            file write html_output "<tr><td class='var-header'`indent_style'>`vlab'</td><td colspan='2'></td></tr>" _n

            if `is_continuous' {
                qui sum `var', detail
                local mean = string(r(mean), "%9.`digit'f")
                local sd = string(r(sd), "%9.`digit'f")
                local med = string(r(p50), "%9.`digit'f")
                local min = string(r(min), "%9.`digit'f")
                local max = string(r(max), "%9.`digit'f")
                local p25 = string(r(p25), "%9.`digit'f")
                local p75 = string(r(p75), "%9.`digit'f")

                if `combined_cols' == 1 {
                    file write html_output ///
                        "<tr><td class='continuous-stats'`indent_style'>Trung bình ± SD</td>" ///
                        "<td class='center'>`mean' ± `sd'</td></tr>" _n ///
                        "<tr><td class='continuous-stats'`indent_style'>Trung vị (IQR)</td>" ///
                        "<td class='center'>`med' (`p25' - `p75')</td></tr>" _n ///
                        "<tr><td class='continuous-stats'`indent_style'>Min</td>" ///
                        "<td class='center'>`min'</td></tr>" _n ///
                        "<tr><td class='continuous-stats'`indent_style'>Max</td>" ///
                        "<td class='center'>`max'</td></tr>" _n
                }
                else {
                    file write html_output ///
                        "<tr><td class='continuous-stats'`indent_style'>Trung bình ± SD</td>" ///
                        "<td class='center' colspan='2'>`mean' ± `sd'</td></tr>" _n ///
                        "<tr><td class='continuous-stats'`indent_style'>Trung vị (IQR)</td>" ///
                        "<td class='center' colspan='2'>`med' (`p25' - `p75')</td></tr>" _n ///
                        "<tr><td class='continuous-stats'`indent_style'>Min</td>" ///
                        "<td class='center' colspan='2'>`min'</td></tr>" _n ///
                        "<tr><td class='continuous-stats'`indent_style'>Max</td>" ///
                        "<td class='center' colspan='2'>`max'</td></tr>" _n
                }

                // Add missing count for continuous variables
                qui count if missing(`var')
                local miss_count = r(N)
                if `miss_count' > 0 {
                    local miss_percent = string(100 * `miss_count'/`N', "%9.`digit'f")
                    
                    if `combined_cols' == 1 {
                        file write html_output "<tr><td class='continuous-stats'`indent_style'>Missing</td>" ///
                            "<td class='number'>`miss_count' (`miss_percent' %)</td></tr>" _n
                    }
                    else {
                        file write html_output "<tr><td class='continuous-stats'`indent_style'>Missing</td>" ///
                            "<td class='number'>`miss_count'</td><td class='number'>`miss_percent' %</td></tr>" _n
                    }
                }
            }
            else if strpos("`type'", "str") { // Biến chuỗi
                qui tab `var', missing
                local total_n = r(N)

                tempname temp_mat
                tab `var', matcell(`temp_mat') missing
                
                local n_rows = rowsof(`temp_mat')
                
                quietly levelsof `var', local(categories) missing
                local i = 1
                foreach val in `categories' {
                    local freq = `temp_mat'[`i',1]
                    local p = string(100 * `freq'/`total_n', "%9.`digit'f")
                    
                    if missing("`val'") {
                        local display_val "Missing"
                    }
                    else {
                        local display_val "`val'"
                    }
                    
                    if `combined_cols' == 1 {
                        file write html_output "<tr><td`indent_style'>`display_val'</td>" ///
                            "<td class='number'>`freq' (`p' %)</td></tr>" _n
                    }
                    else {
                        file write html_output "<tr><td`indent_style'>`display_val'</td>" ///
                            "<td class='number'>`freq'</td><td class='number'>`p' %</td></tr>" _n
                    }
                    
                    local ++i
                }
            }
            else { // Biến phân loại
                qui tab `var', missing
                local total_n = r(N)

                tempname temp_mat
                tab `var', matcell(`temp_mat') missing
                
                local n_rows = rowsof(`temp_mat')
                
                if "`has_vallabel'" != "" {
                    quietly levelsof `var', local(categories) missing
                    local i = 1
                    foreach val in `categories' {
                        local freq = `temp_mat'[`i',1]
                        local p = string(100 * `freq'/`total_n', "%9.`digit'f")
                        
                        if missing(`val') {
                            local display_val "Missing"
                        }
                        else {
                            local vl : label (`var') `val'
                            local display_val "`vl'"
                        }
                        
                        file write html_output "<tr><td`indent_style'>`display_val'</td>" ///
                            "<td class='number'>`freq'</td><td class='number'>`p' %</td></tr>" _n
                        
                        local ++i
                    }
                }
                else {
                    quietly levelsof `var', local(categories) missing
                    local i = 1
                    foreach val in `categories' {
                        local freq = `temp_mat'[`i',1]
                        local p = string(100 * `freq'/`total_n', "%9.`digit'f")
                        
                        if missing(`val') {
                            local display_val "Missing"
                        }
                        else {
                            local display_val = string(`val')
                        }
                        
                        file write html_output "<tr><td`indent_style'>`display_val'</td>" ///
                            "<td class='number'>`freq'</td><td class='number'>`p' %</td></tr>" _n
                        
                        local ++i
                    }
                }
            }
        }
        if _rc {
            display as error "Lỗi khi xử lý biến `var'"
            continue
        }
    }

    // Add overall missing percentage if missing option is specified
    if "`missing'" != "" {
        local total_missing_percent = string(100 * `total_missing'/`total_cells', "%9.`digit'f")
        file write html_output "</table>" _n ///
            "<div class='summary-text'>Tỷ lệ missing của toàn bộ dữ liệu: `total_missing_percent'%</div>" _n
    }
    else {
        file write html_output "</table>" _n
    }

    local timestamp = c(current_date) + " " + c(current_time)
    file write html_output "<p><small>Được tạo lúc: `timestamp'</small></p>" _n ///
        "</body></html>" _n

    file close html_output

    local fullpath = "file:" + c(pwd) + "/" + "`output'"
    display as text _n "Copy liên kết dán vào trình duyệt hoặc tìm nguồn mở file {browse `fullpath'}"
    

    shell start "" "`fullpath'"

    if "`autoopen'" != "" {
        shell start "`output'"
    }

    return local output "`output'"
    return local timestamp "`timestamp'"
end