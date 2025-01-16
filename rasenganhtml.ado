capture program drop rasenganhtml
program define rasenganhtml, rclass
    syntax varlist [if] [in], by(varname) [ib(integer 1)] [ratio(string)] [per(string)] [p(string)] ///
        [output(string)] [digit(integer 1)] [autoopen] [title(string)] [pnote(string)] [lang(string)] [N(string)]
		display as text "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⡀⠑⠒⠀⠠⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
		display as text "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⣘⠖⠀⠀⠀⠀⠀⠀⠀"
		display as text "⠀⠀⠀⠀⠀⠀⠀⠴⡖⠒⠒⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠊⠁⠀⠀⠀⠀⠀⠀⠀⠀"
		display as text "⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⢄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠒⢄⠀⠀⠀⠀⠀⠀⠀⠀"
		display as text "⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠔⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⣄⣀⣀⣙⣦⡀⠀⠀⠀⠀⠀"
		display as text "⠀⠀⠀⠀⠀⠀⠚⠋⠉⠀⣘⣠⡇⠀⢠⣿⠀⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠀⠀⣠⡇⠀⢸⡟⠒⢼⡄⠀⠀⠀⠀⠀⠀"
		display as text "⠀⠀⠀⢀⣀⣀⣀⣀⣀⣴⣋⣸⠀⣴⣿⣿⠀⢠⠋⠉⠉⠉⠙⠉⠉⢉⡉⢀⡉⠁⠀⡃⢀⣴⣿⡇⢀⣿⡷⠀⠀⠀⠀⠀⠀⠀⠀⠀"
		display as text "⣿⣿⣿⣿⠿⠛⠉⠙⠛⠿⢿⣧⢾⣿⣿⣿⢠⠧⠀⠀⡀⠀⠀⢠⡞⣩⣭⡋⠀⢀⢸⢠⠊⢼⣿⡇⣼⣿⡟⣲⠀⠀⠀⠀⠀⠀⠀⠀⠀"
		display as text "⠿⠛⠉⠀⠀⠀⠀⠀⠀⢀⣼⡟⢾⠙⣿⣿⣾⣇⠄⠀⠀⠀⢰⣏⣣⣿⣿⡇⠀⠀⠟⠁⢀⣼⣿⣿⣿⠁⡿⢻⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
		display as text "⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⠿⡇⢸⣆⡇⠈⠙⠻⣷⣶⣤⣤⣤⣀⣀⣀⣀⣤⣤⣤⣶⣶⣿⠟⠋⠀⢸⢰⣧⣼⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
		display as text "⠀⠀⠀⠀⠀⠀⣠⡾⠟⠁⠀⢳⢷⣿⠃⠀⢰⡖⣿⣿⢯⣿⣟⠛⡟⠛⠻⡛⢛⣽⣿⣿⣿⡗⢦⠀⠘⣾⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
		display as text "⠀⠀⠀⣀⣤⠞⠋⠀⠀⠀⠀⠈⣆⠛⡄⠀⠀⠣⡘⠿⢊⣘⠌⠙⠁⠀⠀⠹⠋⢸⡈⢻⣟⣡⠋⠀⠀⡏⡸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
		display as text "⣶⡿⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⣟⡶⢇⠀⠀⠀⠈⠉⠉⠉⠀⠚⠀⠀⠀⠀⠀⠀⠉⠉⠁⢀⠀⠀⢰⡟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
		display as text "⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡻⢁⠸⣀⣀⠶⠤⠤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠒⠒⠠⢤⡇⡇⠀⠀⠀⠀⠀⠀⢀⣀⠀⠀⠀⠀"
		display as text "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠟⢹⢀⣷⡀⢀⡀⠶⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠐⠢⠤⣀⡀⣼⣿⡃⠀⢀⣴⣶⣒⣉⣟⣿⠯⢖⡢"
		display as text "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣾⣿⣿⣿⡀⠀⣀⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⢤⡀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣮⣅"
		display as text "⠀⠀⣀⣠⣤⣴⣶⣶⣶⣶⣿⣿⣿⣿⣿⣿⣿⣷⣎⠁⠀⠀⠀⠤⠤⢴⠒⠒⠂⠄⠀⠀⢨⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿     "
		display as text "⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⡀⠀⢀⣤⣿⠙⠆⠀⠀⢀⣴⣵⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿   "
		display as text "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⡼⣱⠃⠀⣄⣠⣶⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿   "
		display as text "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣛⣿⠁⠇⠀⢀⣟⠻⠿⠿⠿⠿⠟⠛⢛⡛⠛⠛⡛⠛⠛⠛⠿⠿⠟⠛⠋⠉⠉   "
		display as text "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⡀⠀⡎⡸⠀⠀⢸⠀⠀⠀⠀⢠⣀⠖⠖⠉⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   "
		display as text "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢠⠃⠀⠀⣿⣶⣶⣶⣶⠖⠁⠀⠀⡄⠐⠃⠀⠀⠎⠀⠀⠀⠀⠀⠀⠀⠀⠀   "
		display as text "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢁⠎⠀⠀⣸⠿⠟⠛⠛⢣⠀⢀⣴⡟⠁⠀⢀⣀⡠⢤⣀⣀⠀⠀⠀⠀⠀⠀⠀   "
		display as text "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣏⠎⠀⡀⣠⡿⠒⠢⡀⣠⠎⠀⢸⡏⠀⢀⠴⣯⣅⢀⢀⡉⣀⠀⣀⣨⣿⣿⣿⣿   "
    if "`lang'" == "" local lang "vie"
    local lang = lower("`lang'")
    if !inlist("`lang'", "vie", "eng") {
        display as error "lang() phải là vie hoặc eng"
        exit 198
    }
    
    if "`ratio'" == "" local ratio "OR"
    local ratio = upper("`ratio'")
    if !inlist("`ratio'", "OR", "RR", "PR") {
        display as error "ratio() phải là OR, RR, hoặc PR"
        exit 198
    }
    
    if "`per'" == "" local per "row"
    local per = lower("`per'")
    if !inlist("`per'", "row", "col") {
        display as error "per() phải là row hoặc col"
        exit 198
    }
    
    if "`lang'" == "vie" {
        local ratio_header "`ratio' (KTC 95%)"
        if "`title'" == "" local title "KẾT QUẢ PHÂN TÍCH"
        local char_header "ĐẶC ĐIỂM"
        local mean_label "Trung bình ± ĐLC"
        local timestamp_label "Được tạo lúc:"
        local footnote_a "Kiểm định chi bình phương"
        local footnote_b "Kiểm định Fisher"
        local ref_label "1"
    }
    else {
        local ratio_header "`ratio' (95% CI)"
        if "`title'" == "" local title "ANALYSIS RESULTS"
        local char_header "CHARACTERISTICS"
        local mean_label "Mean ± SD"
        local timestamp_label "Generated at:"
        local footnote_a "Chi-square test"
        local footnote_b "Fisher test"
        local ref_label "ref"
    }
    
    if "`output'" == "" {
        local file_prefix = "rasengan"
        local counter = 1
        local output = "`file_prefix'.html"
        while (fileexists("`output'")) {
            local output = "`file_prefix'_`counter'.html"
            local counter = `counter' + 1
            if `counter' > 999 {
                display as error "Quá nhiều file"
                exit 603
            }
        }
    }
    else {
        if !ustrregexm("`output'", "\.html$") {
            local output = "`output'.html"
        }
    }

    local bylab: variable label `by'
    if "`bylab'" == "" local bylab `by'
    
    local by_lab1: label (`by') 1
    local by_lab0: label (`by') 0
    if "`by_lab1'" == "" local by_lab1 "1"
    if "`by_lab0'" == "" local by_lab0 "0"
    
    tempname hh
    file open `hh' using "`output'", write replace text
    
    file write `hh' ///
        "<!DOCTYPE html>" _n ///
        "<html><head>" _n ///
        "<meta charset='UTF-8'>" _n ///
        "<meta name='viewport' content='width=device-width, initial-scale=1.0'>" _n ///
        "<title>`title'</title>" _n ///
        "<style>" _n ///
        "body {font-family: Arial, sans-serif; margin: 20px; line-height: 1.6;}" _n ///
        "table {width: 100%; border-collapse: collapse; margin: 20px 0;}" _n ///
        "th, td {border: 1px solid black; padding: 8px;}" _n ///
        "th {background-color: white; font-weight: bold; text-align: center;}" _n ///
        ".center {text-align: center;}" _n ///
        ".right {text-align: right;}" _n ///
        ".group-header {font-weight: bold; background-color: #f8f9fa;}" _n ///
        ".indent {padding-left: 20px;}" _n ///
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
        "</script>" _n ///
        "</head><body>" _n ///
        "<button class='copy-btn' onclick='copyTableToClipboard()'>Copy Table</button>" _n ///
        "<table>" _n

    file write `hh' "<tr>" _n ///
        "<th rowspan='2' style='text-align: left;'>`char_header'</th>" _n ///
        "<th colspan='2'>`bylab'</th>" _n ///
        "<th rowspan='2'>p</th>" _n ///
        "<th rowspan='2'>`ratio_header'</th>" _n ///
        "</tr>" _n ///
        "<tr>" _n ///
        "<th>`by_lab1' (n %)</th>" _n ///
        "<th>`by_lab0' (n %)</th>" _n ///
        "</tr>" _n

    foreach var of varlist `varlist' {
        local varlab: variable label `var'
        if "`varlab'" == "" local varlab "`var'"
        
        if "`N'" == "TRUE" {
            qui count if !missing(`var')
            local n_total = r(N)
            local varlab = "`varlab' (N=`n_total')"
        }
        
        file write `hh' "<tr><td class='group-header' colspan='5'>`varlab'</td></tr>" _n
        
        capture confirm numeric variable `var'
        if !_rc {
            local is_categorical = 0
            qui levelsof `var', local(unique_values)
            local value_count: word count `unique_values'
            
            local has_value_labels = 0
            local val_lab: value label `var'
            if "`val_lab'" != "" local has_value_labels = 1
            
            if `value_count' <= 10 | `has_value_labels' == 1 local is_categorical = 1
            
            if `is_categorical' == 0 {
                foreach l of numlist 0/1 {
                    qui sum `var' if `by' == `l'
                    local mean`l' = string(r(mean), "%9.`digit'f")
                    local sd`l' = string(r(sd), "%9.`digit'f")
                }
                
                qui ttest `var', by(`by')
                local p = string(r(p), "%9.3f")
                if "`pnote'" == "TRUE" {
                    local p_display "`p'<sup>b</sup>"
                }
                else {
                    local p_display "`p'"
                }
                
                file write `hh' "<tr>" _n ///
                    "<td class='indent'>`mean_label'</td>" _n ///
                    "<td class='center'>`mean1' ± `sd1'</td>" _n ///
                    "<td class='center'>`mean0' ± `sd0'</td>" _n ///
                    "<td class='center'>`p_display'</td>" _n ///
                    "<td class='center'>-</td>" _n ///
                    "</tr>" _n
                continue
            }
        }
        
        qui levelsof `var', local(levels)
        local ref_level: word `ib' of `levels'
        
        foreach l of local levels {
            local vallabel: label (`var') `l'
            if "`vallabel'" == "" local vallabel "`l'"
            
            qui count if `var' == `l' & `by' == 1
            local n1 = r(N)
            qui count if `by' == 1
            local total1 = r(N)
            
            qui count if `var' == `l' & `by' == 0
            local n0 = r(N)
            qui count if `by' == 0
            local total0 = r(N)
            
            if "`per'" == "row" {
                local total_row = `n1' + `n0'
                local pct1 = string(100 * `n1'/`total_row', "%9.`digit'f")
                local pct0 = string(100 * `n0'/`total_row', "%9.`digit'f")
            }
            else {
                local pct1 = string(100 * `n1'/`total1', "%9.`digit'f")
                local pct0 = string(100 * `n0'/`total0', "%9.`digit'f")
            }
            
            if `l' == `ref_level' {
                local ratio_display "`ref_label'"
                local p_display ""
            }
            else {
                tempvar temp_var
                gen `temp_var' = `var'
                recode `temp_var' (`l'=1) (`ref_level'=0) (else=.)
                
                capture {
                    if "`ratio'" == "OR" {
                        qui logistic `by' `temp_var'
                    }
                    else if "`ratio'" == "RR" {
                        qui poisson `by' `temp_var', irr
                    }
                    else {
                        qui glm `by' `temp_var', family(poisson) link(log) eform
                    }
                    
                    if _rc == 0 {
                        local est = exp(_b[`temp_var'])
                        local lb = exp(_b[`temp_var'] - 1.96*_se[`temp_var'])
                        local ub = exp(_b[`temp_var'] + 1.96*_se[`temp_var'])
                        
                        if `est' == 1 {
                            local ratio_display "(emty)"
                        }
                        else {
                            local ratio_display = string(`est', "%9.2f") + " (" + string(`lb', "%9.2f") + "-" + string(`ub', "%9.2f") + ")"
                        }
                        
                        local p = string(2 * (1 - normal(abs(_b[`temp_var']/_se[`temp_var']))), "%9.3f")
                        if "`pnote'" == "TRUE" {
                            local p_display "`p'<sup>a</sup>"
                        }
                        else {
                            local p_display "`p'"
                        }
                    }
                    else {
                        local ratio_display ""
                        local p_display ""
                    }
                }
                drop `temp_var'
            }
            
            file write `hh' "<tr>" _n ///
                "<td class='indent'>`vallabel'</td>" _n ///
                "<td class='center'>`n1' (`pct1'%)</td>" _n ///
                "<td class='center'>`n0' (`pct0'%)</td>" _n ///
                "<td class='center'>`p_display'</td>" _n ///
                "<td class='center'>`ratio_display'</td>" _n ///
                "</tr>" _n
        }
    }
    
    local timestamp = c(current_date) + " " + c(current_time)
    file write `hh' "</table>" _n
    
    if "`pnote'" == "TRUE" {
        file write `hh' "<p class='footnote'>" _n ///
            "a: `footnote_a'<br>" _n ///
            "b: `footnote_b'</p>" _n
    }
    
    file write `hh' "<p class='timestamp'>`timestamp_label' `timestamp'</p>" _n ///
        "</body></html>" _n
    
    file close `hh'
    
    local fullpath = "file:" + c(pwd) + "/" + "`output'"
    display as text _n "Copy liên kết dán vào trình duyệt hoặc tìm nguồn mở file {browse `fullpath'}"
    

    shell start "" "`fullpath'"
    
    if "`autoopen'" != "" {
        shell start "`output'"
    }
    
    return local output "`output'"
    return local timestamp "`timestamp'"
end