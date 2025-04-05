capture program drop rasenganhtml
program define rasenganhtml, rclass
    syntax anything(name=orig_varlist id="variable list") [if] [in], by(varname) ///
        [ib(integer 1)] [ratio(string)] [per(string)] [p(string)] ///
        [output(string)] [digit(integer 1)] [autoopen] [title(string)] [pnote(string)] [lang(string)] [N(string)] [ptest(string)] ///
        [pdigit(integer 3)] [ratiodigit(integer 2)] [robust(string)] [event(varname)] [eventtime(varname)] [eventvalue(string)]
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
		
		
		
		
		
    // Process the variable list with checkqname
    capture checkqname `orig_varlist' `if' `in'
    if _rc {
        display as error "Error processing variable list with checkqname"
        exit _rc
    }
    
    // Get clean varlist and ib options from checkqname
    local varlist = r(varlist)
    local ib_opts = r(ib_opts)
    
    // Parse the ib_opts to create a dictionary of variable -> reference level
    local var_refs ""
    foreach opt of local ib_opts {
        if regexm("`opt'", "^(.+)=(.+)$") {
            local var = regexs(1)
            local ref = regexs(2)
            local var_refs "`var_refs' `var'=`ref'"
        }
    }
    
    if "`lang'" == "" local lang "vie"
    local lang = lower("`lang'")
    if !inlist("`lang'", "vie", "eng") {
        display as error "lang() phải là vie hoặc eng"
        exit 198
    }
    
    if "`ratio'" == "" local ratio "OR"
    local ratio = upper("`ratio'")
    if !inlist("`ratio'", "OR", "RR", "PR", "HR") {
        display as error "ratio() phải là OR, RR, PR, hoặc HR"
        exit 198
    }
    
    // Check HR requirements
    if "`ratio'" == "HR" {
        if "`event'" == "" | "`eventtime'" == "" | "`eventvalue'" == "" {
            display as error "Khi ratio(HR), phải khai báo event(), eventtime(), và eventvalue()"
            exit 198
        }
    }
    
    if "`per'" == "" local per "row"
    local per = lower("`per'")
    if !inlist("`per'", "row", "col") {
        display as error "per() phải là row hoặc col"
        exit 198
    }
    
    // Validate robust option
    local use_robust = 0
    if "`robust'" != "" {
        local robust = lower("`robust'")
        if "`robust'" == "true" {
            local use_robust = 1
        }
        else if "`robust'" != "false" {
            display as error "robust() phải là true hoặc false"
            exit 198
        }
    }
    
    // Validate ptest option
    local have_ptest = 0
    if "`ptest'" != "" {
        local have_ptest = 1
        local ptest = lower("`ptest'")
        if !inlist("`ptest'", "chi2", "fisher", "auto") {
            display as error "ptest() phải là chi2, fisher, hoặc auto"
            exit 198
        }
    }
    
    if "`lang'" == "vie" {
        local ratio_header "`ratio' (KTC 95%)"
        if "`title'" == "" local title "KẾT QUẢ PHÂN TÍCH"
        local char_header "ĐẶC ĐIỂM"
        local mean_label "Trung bình ± ĐLC"
        local median_label "Trung vị (IQR)"
        local timestamp_label "Được tạo lúc:"
        local footnote_a = ""
        if "`ratio'" == "OR" {
            local footnote_a "Hồi quy logistic"
        }
        else if inlist("`ratio'", "PR", "RR") {
            local footnote_a "Hồi quy Poisson"
        } 
        else if "`ratio'" == "HR" {
            local footnote_a "Hồi quy Cox"
        }
        else {
            local footnote_a "Kiểm định chi bình phương"
        }
        local footnote_b "Kiểm định t"
        local footnote_c "Kiểm định Mann-Whitney"
        local footnote_d "Kiểm định Fisher's exact"
        local footnote_e "Kiểm định chi bình phương"
        local footnote_f "Kiểm định log-rank"
        local ref_label "1"
        local ptest_header "p-kiểm định"
    }
    else {
        local ratio_header "`ratio' (95% CI)"
        if "`title'" == "" local title "ANALYSIS RESULTS"
        local char_header "CHARACTERISTICS"
        local mean_label "Mean ± SD"
        local median_label "Median (IQR)"
        local timestamp_label "Generated at:"
        local footnote_a = ""
        if "`ratio'" == "OR" {
            local footnote_a "Logistic regression"
        }
        else if inlist("`ratio'", "PR", "RR") {
            local footnote_a "Poisson regression"
        } 
        else if "`ratio'" == "HR" {
            local footnote_a "Cox regression"
        }
        else {
            local footnote_a "Chi-square test"
        }
        local footnote_b "t-test"
        local footnote_c "Mann-Whitney test"
        local footnote_d "Fisher's exact test"
        local footnote_e "Chi-square test"
        local footnote_f "Log-rank test"
        local ref_label "ref"
        local ptest_header "p-value"
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
        ".button-container {margin-bottom: 10px;}" _n ///
        ".btn {" _n ///
        "    background-color:rgb(0, 95, 204);" _n ///
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
        ".btn:hover {" _n ///
        "    background-color:rgb(6, 74, 152);" _n ///
        "}" _n ///
        ".btn:active {" _n ///
        "    background-color:rgb(185, 3, 3);" _n ///
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
        "" _n ///
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
        "<div class='button-container'>" _n ///
        "<button class='btn copy-btn' onclick='copyTableToClipboard()'>Copy Table</button>" _n ///
        "<button class='btn decimal-btn' onclick='switchDecimalSeparator()' data-current='dot'>Use Comma (,) Decimal</button>" _n ///
        "</div>" _n ///
        "<table>" _n

    file write `hh' "<tr>" _n ///
        "<th rowspan='2' style='text-align: left;'>`char_header'</th>" _n ///
        "<th colspan='2'>`bylab'</th>" _n ///
        "<th rowspan='2'>p</th>" _n 
    
    // Add ptest column if specified
    if `have_ptest' {
        file write `hh' "<th rowspan='2'>`ptest_header'</th>" _n 
    }
    
    file write `hh' "<th rowspan='2'>`ratio_header'</th>" _n ///
        "</tr>" _n ///
        "<tr>" _n ///
        "<th>`by_lab1' (n %)</th>" _n ///
        "<th>`by_lab0' (n %)</th>" _n ///
        "</tr>" _n

    // Create locals to track which footnotes are used
    local used_notes ""
    
    // Track if we've added survival data for HR
    local added_survival_data = 0
    
    // For HR, we need to add survival summary statistics first
    if "`ratio'" == "HR" & `added_survival_data' == 0 {
        // Add a header for survival data
        if "`lang'" == "vie" {
            local surv_header = "Phân tích sống còn"
        } 
        else {
            local surv_header = "Survival Analysis"
        }
        
        // Calculate the colspan based on whether ptest is present
        local colspan = 5
        if `have_ptest' local colspan = 6
        
        file write `hh' "<tr><td class='group-header' colspan='`colspan''>`surv_header'</td></tr>" _n
        
        // Get event counts for each group
        local ev_value = `eventvalue'
        qui count if `event' == `ev_value' & `by' == 1
        local events1 = r(N)
        qui count if `by' == 1
        local total1 = r(N)
        
        qui count if `event' == `ev_value' & `by' == 0
        local events0 = r(N)
        qui count if `by' == 0
        local total0 = r(N)
        
        // Calculate incidence rates for each group
        qui sum `eventtime' if `by' == 1
        local total_time1 = r(sum)
        local rate1 = `events1' / `total_time1' * 1000  // per 1000 person-time
        
        qui sum `eventtime' if `by' == 0
        local total_time0 = r(sum)
        local rate0 = `events0' / `total_time0' * 1000  // per 1000 person-time
        
        // Format the rates
        local rate1_str = string(`rate1', "%9.`digit'f")
        local rate0_str = string(`rate0', "%9.`digit'f")
        
        // Calculate median survival time
        tempname surv1 surv0
        qui stset `eventtime' if `by' == 1, failure(`event' == `ev_value')
        qui stci, p(50)
        local med_surv1 = r(p50)
        if "`med_surv1'" == "." {
            local med_surv1_str = "NA"
        } 
        else {
            local med_surv1_str = string(`med_surv1', "%9.`digit'f")
        }
        
        qui stset `eventtime' if `by' == 0, failure(`event' == `ev_value')
        qui stci, p(50)
        local med_surv0 = r(p50)
        if "`med_surv0'" == "." {
            local med_surv0_str = "NA"
        } 
        else {
            local med_surv0_str = string(`med_surv0', "%9.`digit'f")
        }
        
        // Perform log-rank test
        qui stset `eventtime', failure(`event' == `ev_value')
        qui sts test `by'
        local logrank_p = r(p)
        if `logrank_p' < 0.001 {
            local logrank_p_str = "<0.001"
        } 
        else {
            local logrank_p_str = string(`logrank_p', "%9.3f")
        }
        
        if "`pnote'" == "TRUE" {
            local logrank_p_display "`logrank_p_str'<sup>f</sup>"
            local used_notes "`used_notes' f"
        }
        else {
            local logrank_p_display "`logrank_p_str'"
        }
        
        // Add event count row
        if "`lang'" == "vie" {
            local events_label = "Số biến cố/Tổng"
        } 
        else {
            local events_label = "Events/Total"
        }
        
        file write `hh' "<tr>" _n ///
            "<td class='indent'>`events_label'</td>" _n ///
            "<td class='center'>`events1'/`total1'</td>" _n ///
            "<td class='center'>`events0'/`total0'</td>" _n ///
            "<td class='center'>`logrank_p_display'</td>" _n
        
        // Add ptest cell if specified
        if `have_ptest' {
            file write `hh' "<td class='center' rowspan='2'>`logrank_p_display'</td>" _n
        }
        
        // Calculate crude HR for this row
        qui stcox `by'
        local crude_hr = exp(_b[`by'])
        local crude_hr_lb = exp(_b[`by'] - 1.96*_se[`by'])
        local crude_hr_ub = exp(_b[`by'] + 1.96*_se[`by'])
        
        local crude_hr_display = string(`crude_hr', "%9.`ratiodigit'f") + " (" + string(`crude_hr_lb', "%9.`ratiodigit'f") + "-" + string(`crude_hr_ub', "%9.`ratiodigit'f") + ")"
        
        file write `hh' "<td class='center' rowspan='1'>`crude_hr_display'</td>" _n ///
            "</tr>" _n
        
        // Add incidence rate row
        if "`lang'" == "vie" {
            local rate_label = "Tỷ suất mới mắc (trên 1000 đơn vị thời gian)"
        } 
        else {
            local rate_label = "Incidence rate (per 1000 person-time)"
        }
        
        file write `hh' "<tr>" _n ///
            "<td class='indent'>`rate_label'</td>" _n ///
            "<td class='center'>`rate1_str'</td>" _n ///
            "<td class='center'>`rate0_str'</td>" _n ///
            "<td class='center'></td>" _n
        
        if `have_ptest' {
            // Already added in events row with rowspan=2
        }
        
        file write `hh' "<td class='center'></td>" _n ///
            "</tr>" _n
        
        // Add median survival time row
        if "`lang'" == "vie" {
            local med_surv_label = "Trung vị thời gian sống còn"
        } 
        else {
            local med_surv_label = "Median survival time"
        }
        
        file write `hh' "<tr>" _n ///
            "<td class='indent'>`med_surv_label'</td>" _n ///
            "<td class='center'>`med_surv1_str'</td>" _n ///
            "<td class='center'>`med_surv0_str'</td>" _n ///
            "<td class='center'></td>" _n
        
        if `have_ptest' {
            file write `hh' "<td class='center'></td>" _n
        }
        
        file write `hh' "<td class='center'></td>" _n ///
            "</tr>" _n
        
        local added_survival_data = 1
    }
            
    foreach var of varlist `varlist' {
        // Check if a custom reference level is specified for this variable
        local custom_ref = `ib'  // Default reference level from ib() option
        foreach item of local var_refs {
            if regexm("`item'", "^`var'=(.+)$") {
                local custom_ref = regexs(1)
                display as text "Using custom reference level `custom_ref' for variable `var'"
            }
        }
        
        // Create a temporary variable for tracking used test types
        local temp_used_notes ""
        
        capture confirm numeric variable `var'
        if !_rc {
            local is_categorical = 0
            qui levelsof `var', local(unique_values)
            local value_count: word count `unique_values'
            
            local has_value_labels = 0
            local val_lab: value label `var'
            if "`val_lab'" != "" local has_value_labels = 1
            
            // Check if continuous or categorical
            if regexm("`var'", "^(B1_|b1_)") | regexm("`varlab'", "(.*)[Ss]ố ngày(.*)") {
                local is_categorical = 0
            }
            else if `value_count' <= 10 | `has_value_labels' == 1 {
                local is_categorical = 1
            }
            
            // Add test types based on variable type
            if `is_categorical' == 0 {
                // Continuous variable - using t-test and Mann-Whitney
                local temp_used_notes "`temp_used_notes' b c"
            }
            else {
                // Categorical variable - main p column uses regression type
                local temp_used_notes "`temp_used_notes' a"
                
                // For ptest if specified
                if `have_ptest' {
                    if "`ptest'" == "fisher" {
                        local temp_used_notes "`temp_used_notes' d"
                    }
                    else if "`ptest'" == "chi2" {
                        local temp_used_notes "`temp_used_notes' e"
                    }
                    else { // auto
                        // Check if we need Fisher's exact
                        tempname crosstab expected_vals
                        qui tab `var' `by', matcell(`crosstab') matcol(`expected_vals')
                        
                        // Get expected values
                        qui tab `var' `by', expected
                        
                        // Check if any expected value <= 1
                        local min_exp = .
                        forvalues r = 1/`=r(r)' {
                            forvalues c = 1/`=r(c)' {
                                local exp_val = r(e_`r'_`c')
                                if `exp_val' < `min_exp' | `min_exp' == . {
                                    local min_exp = `exp_val'
                                }
                            }
                        }
                        
                        // Count small cells (expected <= 5)
                        local count_small_cells = 0
                        local total_cells = r(r) * r(c)
                        forvalues r = 1/`=r(r)' {
                            forvalues c = 1/`=r(c)' {
                                local exp_val = r(e_`r'_`c')
                                if `exp_val' <= 5 {
                                    local count_small_cells = `count_small_cells' + 1
                                }
                            }
                        }
                        
                        // Use Fisher if any expected <= 1 or >20% of cells have expected <= 5
                        if `min_exp' <= 1 | (`count_small_cells'/`total_cells' > 0.2) {
                            local temp_used_notes "`temp_used_notes' d"
                        }
                        else {
                            local temp_used_notes "`temp_used_notes' e"
                        }
                    }
                }
            }
        }
        
        // Add the test types used for this variable to the overall list
        foreach note in `temp_used_notes' {
            if strpos("`used_notes'", "`note'") == 0 {
                local used_notes "`used_notes' `note'"
            }
        }
        
        local varlab: variable label `var'
        if "`varlab'" == "" local varlab "`var'"
        
        if "`N'" == "TRUE" {
            qui count if !missing(`var')
            local n_total = r(N)
            local varlab = "`varlab' (N=`n_total')"
        }
        
        // Calculate the colspan based on whether ptest is present
        local colspan = 5
        if `have_ptest' local colspan = 6
        
        file write `hh' "<tr><td class='group-header' colspan='`colspan''>`varlab'</td></tr>" _n
        
        capture confirm numeric variable `var'
        if !_rc {
            local is_categorical = 0
            qui levelsof `var', local(unique_values)
            local value_count: word count `unique_values'
            
            local has_value_labels = 0
            local val_lab: value label `var'
            if "`val_lab'" != "" local has_value_labels = 1
            
            // Check if continuous or categorical variable
            if regexm("`var'", "^(B1_|b1_)") | regexm("`varlab'", "(.*)[Ss]ố ngày(.*)") {
                local is_categorical = 0
            }
            else if `value_count' <= 10 | `has_value_labels' == 1 {
                local is_categorical = 1
            }
            
            if `is_categorical' == 0 {
                // Mean and SD calculation
                foreach l of numlist 0/1 {
                    qui sum `var' if `by' == `l'
                    local mean`l' = string(r(mean), "%9.`digit'f")
                    local sd`l' = string(r(sd), "%9.`digit'f")
                }
                
                // T-test
                qui ttest `var', by(`by')
                local p_ttest = r(p)
                if `p_ttest' < 0.001 {
                    local p_ttest_str = "<0.001"
                } 
                else {
                    local p_ttest_str = string(`p_ttest', "%9.3f")
                }
                
                // Median and IQR calculation
                foreach l of numlist 0/1 {
                    qui sum `var' if `by' == `l', detail
                    local median`l' = string(r(p50), "%9.`digit'f")
                    local q1`l' = string(r(p25), "%9.`digit'f")
                    local q3`l' = string(r(p75), "%9.`digit'f")
                    local iqr`l' = "`q1`l''-`q3`l''"
                }
                
                // Mann-Whitney test
                qui ranksum `var', by(`by')
                local p_ranksum = r(p)
                if `p_ranksum' < 0.001 {
                    local p_ranksum_str = "<0.001"
                } 
                else {
                    local p_ranksum_str = string(`p_ranksum', "%9.3f")
                }
                
                // Calculate regression p-value based on ratio type
                local p_regression = .
                local p_regression_str = ""
                
                if "`ratio'" == "OR" {
                    if `use_robust' {
                        qui logistic `by' `var', vce(robust)
                    }
                    else {
                        qui logistic `by' `var'
                    }
                    local p_regression = 2 * (1 - normal(abs(_b[`var']/_se[`var'])))
                }
                else if "`ratio'" == "RR" || "`ratio'" == "PR" {
                    if `use_robust' {
                        qui poisson `by' `var', irr vce(robust)
                    }
                    else {
                        qui poisson `by' `var', irr
                    }
                    local p_regression = 2 * (1 - normal(abs(_b[`var']/_se[`var'])))
                }
                else if "`ratio'" == "HR" {
                    qui stset `eventtime', failure(`event' == `eventvalue')
                    if `use_robust' {
                        qui stcox `var', vce(robust)
                    }
                    else {
                        qui stcox `var'
                    }
                    local p_regression = 2 * (1 - normal(abs(_b[`var']/_se[`var'])))
                }
                
                if `p_regression' < 0.001 {
                    local p_regression_str = "<0.001"
                } 
                else {
                    local p_regression_str = string(`p_regression', "%9.3f")
                }
                
                // Format regression p-value for display
                if "`pnote'" == "TRUE" {
                    local p_regression_display "`p_regression_str'<sup>a</sup>"
                }
                else {
                    local p_regression_display "`p_regression_str'"
                }

// Calculate additional p-value if ptest is specified
if `have_ptest' {
    if "`ptest'" == "chi2" {
        // For continuous variables, we'll use t-test for chi2 option
        local ptest_value = `p_ttest'
        if `ptest_value' < 0.001 {
            local ptest_display_val = "<0.001"
        } 
        else {
            local ptest_display_val = string(`ptest_value', "%9.3f")
        }
        
        if "`pnote'" == "TRUE" {
            local ptest_display "`ptest_display_val'<sup>b</sup>"  // t-test
        } 
        else {
            local ptest_display "`ptest_display_val'"
        }
    } 
    else if "`ptest'" == "fisher" {
        // For continuous variables, we'll use Mann-Whitney for fisher option
        local ptest_value = `p_ranksum'
        if `ptest_value' < 0.001 {
            local ptest_display_val = "<0.001"
        } 
        else {
            local ptest_display_val = string(`ptest_value', "%9.3f")
        }
        
        if "`pnote'" == "TRUE" {
            local ptest_display "`ptest_display_val'<sup>c</sup>"  // Mann-Whitney
        } 
        else {
            local ptest_display "`ptest_display_val'"
        }
    }
    else { // auto
        // For continuous variables, use t-test if normally distributed, otherwise Mann-Whitney
        // This is a simplification - in a real scenario you might want to test for normality
        local ptest_value = `p_ttest'
        if `ptest_value' < 0.001 {
            local ptest_display_val = "<0.001"
        } 
        else {
            local ptest_display_val = string(`ptest_value', "%9.3f")
        }
        
        if "`pnote'" == "TRUE" {
            local ptest_display "`ptest_display_val'<sup>b</sup>"  // t-test as default for auto
        } 
        else {
            local ptest_display "`ptest_display_val'"
        }
    }
}

if "`pnote'" == "TRUE" {
    local p_ttest_display "`p_ttest_str'<sup>b</sup>"
    local p_ranksum_display "`p_ranksum_str'<sup>c</sup>"
}
else {
    local p_ttest_display "`p_ttest_str'"
    local p_ranksum_display "`p_ranksum_str'"
}

// Calculate ratio based on choice
local ratio_val = ""

if "`ratio'" == "OR" {
    tempvar binary_outcome high_risk
    qui sum `var', detail
    local median_all = r(p50)
    gen `binary_outcome' = `var' > `median_all' if !missing(`var')
    
    if `use_robust' {
        qui logistic `by' `var', vce(robust)
    }
    else {
        qui logistic `by' `var'
    }
    local beta = _b[`var']
    local se = _se[`var']
    
    local or = exp(`beta')
    local or_lb = exp(`beta' - 1.96*`se')
    local or_ub = exp(`beta' + 1.96*`se')
    
    local ratio_val = string(`or', "%9.`ratiodigit'f") + " (" + string(`or_lb', "%9.`ratiodigit'f") + "-" + string(`or_ub', "%9.`ratiodigit'f") + ")"
}
else if "`ratio'" == "RR" {
    tempvar binary_outcome high_risk
    qui sum `var', detail
    local median_all = r(p50)
    gen `binary_outcome' = `var' > `median_all' if !missing(`var')
    
    if `use_robust' {
        qui poisson `by' `var', irr vce(robust)
    }
    else {
        qui poisson `by' `var', irr
    }
    local beta = _b[`var']
    local se = _se[`var']
    
    local rr = exp(`beta')
    local rr_lb = exp(`beta' - 1.96*`se')
    local rr_ub = exp(`beta' + 1.96*`se')
    
    local ratio_val = string(`rr', "%9.`ratiodigit'f") + " (" + string(`rr_lb', "%9.`ratiodigit'f") + "-" + string(`rr_ub', "%9.`ratiodigit'f") + ")"
}
else if "`ratio'" == "PR" {
    tempvar binary_outcome high_risk
    qui sum `var', detail
    local median_all = r(p50)
    gen `binary_outcome' = `var' > `median_all' if !missing(`var')
    
    if `use_robust' {
        qui poisson `by' `var', irr vce(robust)
    }
    else {
        qui poisson `by' `var', irr
    }
    local beta = _b[`var']
    local se = _se[`var']
    
    local pr = exp(`beta')
    local pr_lb = exp(`beta' - 1.96*`se')
    local pr_ub = exp(`beta' + 1.96*`se')
    
    local ratio_val = string(`pr', "%9.`ratiodigit'f") + " (" + string(`pr_lb', "%9.`ratiodigit'f") + "-" + string(`pr_ub', "%9.`ratiodigit'f") + ")"
}
else if "`ratio'" == "HR" {
    // Setup survival data if not already done
    qui stset `eventtime', failure(`event' == `eventvalue')
    
    if `use_robust' {
        qui stcox `var', vce(robust)
    }
    else {
        qui stcox `var'
    }
    local beta = _b[`var']
    local se = _se[`var']
    
    local hr = exp(`beta')
    local hr_lb = exp(`beta' - 1.96*`se')
    local hr_ub = exp(`beta' + 1.96*`se')
    
    local ratio_val = string(`hr', "%9.`ratiodigit'f") + " (" + string(`hr_lb', "%9.`ratiodigit'f") + "-" + string(`hr_ub', "%9.`ratiodigit'f") + ")"
}

// Write Mean ± SD row
file write `hh' "<tr>" _n ///
    "<td class='indent'>`mean_label'</td>" _n ///
    "<td class='center'>`mean1' ± `sd1'</td>" _n ///
    "<td class='center'>`mean0' ± `sd0'</td>" _n ///
    "<td class='center'>`p_regression_display'</td>" _n

// Add ptest cell if specified
if `have_ptest' {
    file write `hh' "<td class='center' rowspan='2'>`ptest_display'</td>" _n
}

file write `hh' "<td class='center' rowspan='2'>`ratio_val'</td>" _n ///
    "</tr>" _n

// Write Median (IQR) row
file write `hh' "<tr>" _n ///
    "<td class='indent'>`median_label'</td>" _n ///
    "<td class='center'>`median1' (`iqr1')</td>" _n ///
    "<td class='center'>`median0' (`iqr0')</td>" _n ///
    "<td class='center'>`p_ranksum_display'</td>" _n ///
    "</tr>" _n

if "`ratio'" != "HR" & "`binary_outcome'" != "" {
    drop `binary_outcome'
}

continue
}
}

qui levelsof `var', local(levels)

// Use the custom reference level for this variable if specified, otherwise use the default
local ref_level: word `custom_ref' of `levels'

// Set up for Chi-square/Fisher test if ptest is specified
local ptest_display = ""
if `have_ptest' {
    // First run the appropriate test for the entire variable to get the overall p-value
    local use_fisher = 0
    local overall_pvalue = .
    
    if "`ptest'" == "fisher" {
        local use_fisher = 1
    }
    else if "`ptest'" == "chi2" {
        local use_fisher = 0
    }
    else { // auto
        // Create a contingency table to check Fisher's criteria
        tempname crosstab expected_vals
        qui tab `var' `by', matcell(`crosstab') matcol(`expected_vals')
        
        // Get expected values
        qui tab `var' `by', expected
        
        // Check if any expected value <= 1
        local min_exp = .
        forvalues r = 1/`=r(r)' {
            forvalues c = 1/`=r(c)' {
                local exp_val = r(e_`r'_`c')
                if `exp_val' < `min_exp' | `min_exp' == . {
                    local min_exp = `exp_val'
                }
            }
        }
        
        // Count small cells (expected <= 5)
        local count_small_cells = 0
        local total_cells = r(r) * r(c)
        forvalues r = 1/`=r(r)' {
            forvalues c = 1/`=r(c)' {
                local exp_val = r(e_`r'_`c')
                if `exp_val' <= 5 {
                    local count_small_cells = `count_small_cells' + 1
                }
            }
        }
        
        // Use Fisher if any expected <= 1 or >20% of cells have expected <= 5
        if `min_exp' <= 1 | (`count_small_cells'/`total_cells' > 0.2) {
            local use_fisher = 1
        }
    }
    
    // Run the selected test
    if `use_fisher' == 1 {
        qui fisher `var' `by', exact
        local overall_pvalue = r(p_exact)
        local test_type = "d"  // Fisher's exact test
    } 
    else {
        qui tab `var' `by', chi2
        local overall_pvalue = r(p)
        local test_type = "e"  // Chi-square test for ptest column
    }
    
    if `overall_pvalue' < 0.001 {
        local ptest_value = "<0.001"
    } 
    else {
        local ptest_value = string(`overall_pvalue', "%9.3f")
    }
    
    if "`pnote'" == "TRUE" {
        local ptest_display "`ptest_value'<sup>`test_type'</sup>"
    } 
    else {
        local ptest_display "`ptest_value'"
    }
}

// Count number of levels for rowspan
local num_levels: word count `levels'

// Process each level of the categorical variable
local first_level = 1
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
        
        // For reference level, we don't display p-value in the main p column
    }
    else {
        tempvar temp_var
        gen `temp_var' = `var'
        recode `temp_var' (`l'=1) (`ref_level'=0) (else=.)
        
        capture {
            if "`ratio'" == "OR" {
                if `use_robust' {
                    qui logistic `by' `temp_var', vce(robust)
                }
                else {
                    qui logistic `by' `temp_var'
                }
            }
            else if "`ratio'" == "RR" {
                if `use_robust' {
                    qui poisson `by' `temp_var', irr vce(robust)
                }
                else {
                    qui poisson `by' `temp_var', irr
                }
            }
            else if "`ratio'" == "PR" {
                if `use_robust' {
                    qui glm `by' `temp_var', family(poisson) link(log) eform vce(robust)
                }
                else {
                    qui glm `by' `temp_var', family(poisson) link(log) eform
                }
            }
            else if "`ratio'" == "HR" {
                // Setup survival data if not already done
                qui stset `eventtime', failure(`event' == `eventvalue')
                
                if `use_robust' {
                    qui stcox `temp_var', vce(robust)
                }
                else {
                    qui stcox `temp_var'
                }
            }
            
            if _rc == 0 {
                local est = exp(_b[`temp_var'])
                local lb = exp(_b[`temp_var'] - 1.96*_se[`temp_var'])
                local ub = exp(_b[`temp_var'] + 1.96*_se[`temp_var'])
                
                if `est' == 1 {
                    local ratio_display "(empty)"
                }
                else {
                    local ratio_display = string(`est', "%9.`ratiodigit'f") + " (" + string(`lb', "%9.`ratiodigit'f") + "-" + string(`ub', "%9.`ratiodigit'f") + ")"
                }
                
                local p = 2 * (1 - normal(abs(_b[`temp_var']/_se[`temp_var'])))
                if `p' < 0.001 {
                    local p_str = "<0.001"
                } 
                else {
                    local p_str = string(`p', "%9.`pdigit'f")
                }
                
                if "`pnote'" == "TRUE" {
                    local p_display "`p_str'<sup>a</sup>"
                } 
                else {
                    local p_display "`p_str'"
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
        "<td class='center'>`p_display'</td>" _n
    
    // Add ptest value only for first level
    if `have_ptest' {
        if `first_level' == 1 {
            file write `hh' "<td class='center' rowspan='`num_levels''>`ptest_display'</td>" _n
            local first_level = 0
        }
    }
    
    file write `hh' "<td class='center'>`ratio_display'</td>" _n ///
        "</tr>" _n
}
}

local timestamp = c(current_date) + " " + c(current_time)
file write `hh' "</table>" _n

// Display information about the custom reference levels if any were used
if "`var_refs'" != "" {
    file write `hh' "<p><strong>Reference levels used:</strong><br>" _n
    foreach item of local var_refs {
        if regexm("`item'", "^(.+)=(.+)$") {
            local var_name = regexs(1)
            local ref_num = regexs(2)
            local var_label: variable label `var_name'
            if "`var_label'" == "" local var_label "`var_name'"
            
            // Get the value label if it exists
            local ref_label = "`ref_num'"
            capture local ref_value_label: label (`var_name') `ref_num'
            if !_rc & "`ref_value_label'" != "" {
                local ref_label = "`ref_value_label'"
            }
            
            file write `hh' "`var_label': `ref_label' (level `ref_num')<br>" _n
        }
    }
    file write `hh' "</p>" _n
}

if "`pnote'" == "TRUE" {
    // Dynamic footnotes - only show those that were used
    file write `hh' "<p class='footnote'>" _n
    if strpos("`used_notes'", "a") > 0 {
        file write `hh' "a: `footnote_a'"
        if `use_robust' {
            file write `hh' " with robust standard error"
        }
        file write `hh' "<br>" _n
    }
    if strpos("`used_notes'", "b") > 0 {
        file write `hh' "b: `footnote_b'<br>" _n
    }
    if strpos("`used_notes'", "c") > 0 {
        file write `hh' "c: `footnote_c'<br>" _n
    }
    if strpos("`used_notes'", "d") > 0 {
        file write `hh' "d: `footnote_d'<br>" _n
    }
    if strpos("`used_notes'", "e") > 0 {
        file write `hh' "e: `footnote_e'<br>" _n
    }
    if strpos("`used_notes'", "f") > 0 {
        file write `hh' "f: `footnote_f'<br>" _n
    }
    file write `hh' "</p>" _n
}

file write `hh' "<p class='timestamp'>`timestamp_label' `timestamp'</p>" _n ///
    "</body></html>" _n



// Display link to the created file
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
	

capture program drop checkqname
program define checkqname, rclass
    version 11
    
    // Get the original variable list
    local orig_varlist `0'
    
    // Initialize 
    local clean_varlist ""
    local ib_opts ""
    
    // Extract each variable
    foreach word of local orig_varlist {
        // Check if it has the ib pattern
        if regexm("`word'", "^ib([0-9]+)\.(.+)$") {
            local ref_num = regexs(1)
            local var_name = regexs(2)
            
            // Add to clean list
            local clean_varlist "`clean_varlist' `var_name'"
            
            // Add to reference levels
            local ib_opts "`ib_opts' `var_name'=`ref_num'"
        }
        else {
            // Regular variable
            local clean_varlist "`clean_varlist' `word'"
        }
    }
    
    // Return values
    return local varlist "`clean_varlist'"
    return local ib_opts "`ib_opts'"
end