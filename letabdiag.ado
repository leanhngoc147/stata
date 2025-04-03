capture program drop letabdiag
program define letabdiag, rclass
    syntax varlist [if] [in], gold(varname) [cutoff(numlist)] [digit(integer 1)] ///
        [title(string)] [output(string)] [autoopen] [lang(string)] [pdigit(integer 3)] ///
        [ci95] [cidigit(integer 2)]
    
    // Set default language
    if "`lang'" == "" local lang "eng"
    local lang = lower("`lang'")
    if !inlist("`lang'", "vie", "eng") {
        display as error "lang() must be vie or eng"
        exit 198
    }
    
    // Setup language-specific text elements
    if "`lang'" == "vie" {
        if "`title'" == "" local title "BẢNG PHÂN TÍCH CHẨN ĐOÁN"
        local risk_score_header "Biến số"
        local auc_header "AUC (KTC 95%)"
        local cutoff_header "Giá trị cut-off"
        local sens_header "Độ nhạy (%)"
        local spec_header "Độ đặc hiệu (%)"
        local ppv_header "Giá trị DT (+) (%)"
        local npv_header "Giá trị DT (-) (%)"
        local accuracy_header "Độ chính xác (%)"
        local timestamp_label "Được tạo lúc:"
        local formula_title "CÔNG THỨC TÍNH CÁC CHỈ SỐ"
        local sensitivity_formula "Độ nhạy = TP / (TP + FN) * 100%"
        local specificity_formula "Độ đặc hiệu = TN / (TN + FP) * 100%"
        local ppv_formula "Giá trị dự báo dương tính = TP / (TP + FP) * 100%"
        local npv_formula "Giá trị dự báo âm tính = TN / (TN + FN) * 100%"
        local accuracy_formula "Độ chính xác = (TP + TN) / (TP + TN + FP + FN) * 100%"
        local stata_command_title "LỆNH STATA ĐỂ TÍNH RIÊNG TỪNG BIẾN SỐ"
        local where_title "Trong đó:"
        local tp_explanation "TP (True Positive): Số trường hợp dương tính thật"
        local tn_explanation "TN (True Negative): Số trường hợp âm tính thật"
        local fp_explanation "FP (False Positive): Số trường hợp dương tính giả"
        local fn_explanation "FN (False Negative): Số trường hợp âm tính giả"
    } 
    else {
        if "`title'" == "" local title "DIAGNOSTIC ANALYSIS TABLE"
        local risk_score_header "Risk score"
        local auc_header "AUC (95% CI)"
        local cutoff_header "Cut-off value"
        local sens_header "Sensitivity (%)"
        local spec_header "Specificity (%)"
        local ppv_header "PPV (%)"
        local npv_header "NPV (%)"
        local accuracy_header "Accuracy (%)"
        local timestamp_label "Generated at:"
        local formula_title "FORMULAS FOR CALCULATION"
        local sensitivity_formula "Sensitivity = TP / (TP + FN) * 100%"
        local specificity_formula "Specificity = TN / (TN + FP) * 100%"
        local ppv_formula "Positive Predictive Value = TP / (TP + FP) * 100%"
        local npv_formula "Negative Predictive Value = TN / (TN + FN) * 100%"
        local accuracy_formula "Accuracy = (TP + TN) / (TP + TN + FP + FN) * 100%"
        local stata_command_title "STATA COMMANDS FOR INDIVIDUAL VARIABLES"
        local where_title "Where:"
        local tp_explanation "TP (True Positive): Number of true positive cases"
        local tn_explanation "TN (True Negative): Number of true negative cases"
        local fp_explanation "FP (False Positive): Number of false positive cases"
        local fn_explanation "FN (False Negative): Number of false negative cases"
    }
    
    // Setup output file
    if "`output'" == "" {
        local file_prefix = "letabdiag"
        local counter = 1
        local output = "`file_prefix'.html"
        while (fileexists("`output'")) {
            local output = "`file_prefix'_`counter'.html"
            local counter = `counter' + 1
            if `counter' > 999 {
                display as error "Too many files"
                exit 603
            }
        }
    } 
    else {
        if !ustrregexm("`output'", "\.html$") {
            local output = "`output'.html"
        }
    }
    
    // Open output file
    tempname hh
    file open `hh' using "`output'", write replace text
    
    // Write HTML header and styles
    file write `hh' "<!DOCTYPE html>" _n
    file write `hh' "<html><head>" _n
    file write `hh' "<meta charset='UTF-8'>" _n
    file write `hh' "<meta name='viewport' content='width=device-width, initial-scale=1.0'>" _n
    file write `hh' "<title>`title'</title>" _n
    file write `hh' "<style>" _n
    file write `hh' "body {font-family: Arial, sans-serif; margin: 20px; line-height: 1.6;}" _n
    file write `hh' "table {width: 100%; border-collapse: collapse; margin: 20px 0;}" _n
    file write `hh' "th, td {border: 1px solid black; padding: 8px;}" _n
    file write `hh' "th {background-color: #f2f2f2; font-weight: bold; text-align: center;}" _n
    file write `hh' ".center {text-align: center;}" _n
    file write `hh' ".right {text-align: right;}" _n
    file write `hh' ".footnote {font-size: 0.9em; color: #555;}" _n
    file write `hh' ".timestamp {font-size: 0.9em; color: #777; font-style: italic;}" _n
    file write `hh' ".button-container {margin-bottom: 10px;}" _n
    file write `hh' ".btn {" _n
    file write `hh' "    background-color:rgb(0, 95, 204);" _n
    file write `hh' "    border: none;" _n
    file write `hh' "    color: white;" _n
    file write `hh' "    padding: 10px 20px;" _n
    file write `hh' "    text-align: center;" _n
    file write `hh' "    text-decoration: none;" _n
    file write `hh' "    display: inline-block;" _n
    file write `hh' "    font-size: 16px;" _n
    file write `hh' "    margin: 4px 2px;" _n
    file write `hh' "    cursor: pointer;" _n
    file write `hh' "    border-radius: 4px;" _n
    file write `hh' "}" _n
    file write `hh' ".btn:hover {" _n
    file write `hh' "    background-color:rgb(6, 74, 152);" _n
    file write `hh' "}" _n
    file write `hh' ".btn:active {" _n
    file write `hh' "    background-color:rgb(185, 3, 3);" _n
    file write `hh' "}" _n
    file write `hh' ".formula-section {margin-top: 30px; border: 1px solid #ddd; padding: 15px; background-color: #f9f9f9;}" _n
    file write `hh' ".formula-title {font-weight: bold; margin-bottom: 10px; font-size: 1.1em;}" _n
    file write `hh' ".formula-item {margin-bottom: 8px;}" _n
    file write `hh' ".stata-command {font-family: 'Courier New', monospace; background-color: #f0f0f0; padding: 3px 6px; border-radius: 3px;}" _n
    file write `hh' ".collapsible {" _n
    file write `hh' "    background-color: #f1f1f1;" _n
    file write `hh' "    color: black;" _n
    file write `hh' "    cursor: pointer;" _n
    file write `hh' "    padding: 10px;" _n
    file write `hh' "    width: 100%;" _n
    file write `hh' "    border: none;" _n
    file write `hh' "    text-align: left;" _n
    file write `hh' "    outline: none;" _n
    file write `hh' "    font-size: 16px;" _n
    file write `hh' "    margin-top: 10px;" _n
    file write `hh' "}" _n
    file write `hh' ".active, .collapsible:hover {" _n
    file write `hh' "    background-color: #e0e0e0;" _n
    file write `hh' "}" _n
    file write `hh' ".content {" _n
    file write `hh' "    padding: 0 18px;" _n
    file write `hh' "    display: none;" _n
    file write `hh' "    overflow: hidden;" _n
    file write `hh' "    background-color: #f9f9f9;" _n
    file write `hh' "    border: 1px solid #ddd;" _n
    file write `hh' "    border-top: none;" _n
    file write `hh' "}" _n
    file write `hh' "</style>" _n
    
    // Write JavaScript functions
    file write `hh' "<script>" _n
    file write `hh' "function copyTableToClipboard() {" _n
    file write `hh' "    const table = document.querySelector('table');" _n
    file write `hh' "    const range = document.createRange();" _n
    file write `hh' "    range.selectNode(table);" _n
    file write `hh' "    window.getSelection().removeAllRanges();" _n
    file write `hh' "    window.getSelection().addRange(range);" _n
    file write `hh' "    try {" _n
    file write `hh' "        document.execCommand('copy');" _n
    file write `hh' "        const btn = document.querySelector('.copy-btn');" _n
    file write `hh' "        const originalText = btn.textContent;" _n
    file write `hh' "        btn.textContent = 'Copied!';" _n
    file write `hh' "        setTimeout(() => {" _n
    file write `hh' "            btn.textContent = originalText;" _n
    file write `hh' "        }, 2000);" _n
    file write `hh' "    } catch (err) {" _n
    file write `hh' "        console.error('Failed to copy table:', err);" _n
    file write `hh' "    }" _n
    file write `hh' "    window.getSelection().removeAllRanges();" _n
    file write `hh' "}" _n
    
    file write `hh' "function switchDecimalSeparator() {" _n
    file write `hh' "    const table = document.querySelector('table');" _n
    file write `hh' "    const btn = document.querySelector('.decimal-btn');" _n
    file write `hh' "    const cells = table.querySelectorAll('td');" _n
    file write `hh' "    let currentSeparator = '.';" _n
    file write `hh' "    let newSeparator = ',';" _n
    file write `hh' "    " _n
    file write `hh' "    // Check if we're switching back from comma to dot" _n
    file write `hh' "    if (btn.getAttribute('data-current') === 'comma') {" _n
    file write `hh' "        currentSeparator = ',';" _n
    file write `hh' "        newSeparator = '.';" _n
    file write `hh' "        btn.setAttribute('data-current', 'dot');" _n
    file write `hh' "        btn.textContent = 'Use Comma (,) Decimal';" _n
    file write `hh' "    } else {" _n
    file write `hh' "        btn.setAttribute('data-current', 'comma');" _n
    file write `hh' "        btn.textContent = 'Use Dot (.) Decimal';" _n
    file write `hh' "    }" _n
    file write `hh' "    " _n
    file write `hh' "    // Replace all decimals in table, including <0.001 format" _n
    file write `hh' "    cells.forEach(cell => {" _n
    file write `hh' "        const text = cell.innerHTML;" _n
    file write `hh' "        // First handle the <0.001 case" _n
    file write `hh' "        let newText = text.replace(new RegExp('<0\\' + currentSeparator + '001', 'g'), '<0' + newSeparator + '001');" _n
    file write `hh' "        // Then handle regular numbers with decimal points" _n
    file write `hh' "        const regex = new RegExp('(\\d+)\\' + currentSeparator + '(\\d+)', 'g');" _n
    file write `hh' "        newText = newText.replace(regex, '$1' + newSeparator + '$2');" _n
    file write `hh' "        cell.innerHTML = newText;" _n
    file write `hh' "    });" _n
    file write `hh' "}" _n
    
    // Add collapsible sections JavaScript
    file write `hh' "function toggleCollapsible() {" _n
    file write `hh' "    this.classList.toggle('active');" _n
    file write `hh' "    var content = this.nextElementSibling;" _n
    file write `hh' "    if (content.style.display === 'block') {" _n
    file write `hh' "        content.style.display = 'none';" _n
    file write `hh' "    } else {" _n
    file write `hh' "        content.style.display = 'block';" _n
    file write `hh' "    }" _n
    file write `hh' "}" _n
    
    file write `hh' "document.addEventListener('DOMContentLoaded', function() {" _n
    file write `hh' "    var coll = document.getElementsByClassName('collapsible');" _n
    file write `hh' "    for (var i = 0; i < coll.length; i++) {" _n
    file write `hh' "        coll[i].addEventListener('click', toggleCollapsible);" _n
    file write `hh' "    }" _n
    file write `hh' "});" _n
    file write `hh' "</script>" _n
    file write `hh' "</head><body>" _n
    
    // Add buttons
    file write `hh' "<div class='button-container'>" _n
    file write `hh' "<button class='btn copy-btn' onclick='copyTableToClipboard()'>Copy Table</button>" _n
    file write `hh' "<button class='btn decimal-btn' onclick='switchDecimalSeparator()' data-current='dot'>Use Comma (,) Decimal</button>" _n
    file write `hh' "</div>" _n
    
    // Write table header
    file write `hh' "<table>" _n
    file write `hh' "<tr>" _n
    file write `hh' "<th>`risk_score_header'</th>" _n
    file write `hh' "<th>`auc_header'</th>" _n
    file write `hh' "<th>`cutoff_header'</th>" _n
    file write `hh' "<th>`sens_header'</th>" _n
    file write `hh' "<th>`spec_header'</th>" _n
    file write `hh' "<th>P value</th>" _n
    file write `hh' "<th>`ppv_header'</th>" _n
    file write `hh' "<th>`npv_header'</th>" _n
    file write `hh' "<th>`accuracy_header'</th>" _n
    file write `hh' "</tr>" _n
    
    // Process each variable
    local var_count: word count `varlist'
    local cut_count: word count `cutoff'
    
    // Display warning if number of cutoffs does not match number of variables
    if `cut_count' > 0 & `cut_count' != `var_count' {
        display as text "Note: Number of cutoff values (`cut_count') doesn't match number of variables (`var_count')."
        display as text "Individual cutoffs will be applied in order, and median values will be used for any remaining variables."
    }
    
    local i = 1
    foreach var of varlist `varlist' {
        // Get variable label or use variable name
        local varlab: variable label `var'
        if "`varlab'" == "" local varlab "`var'"
        
        // Calculate ROC and AUC
        qui roctab `gold' `var', table
        local auc = r(area)
        
        // Calculate confidence interval for AUC if requested
        if "`ci95'" != "" {
            local auc_se = r(se)
            local auc_lb = `auc' - 1.96 * `auc_se'
            local auc_ub = `auc' + 1.96 * `auc_se'
            
            // Ensure limits are in valid range
            if `auc_lb' < 0 local auc_lb = 0
            if `auc_ub' > 1 local auc_ub = 1
            
            local auc_display = string(`auc', "%9.`cidigit'f") + " (" + string(`auc_lb', "%9.`cidigit'f") + " to " + string(`auc_ub', "%9.`cidigit'f") + ")"
        }
        else {
            local auc_display = string(`auc', "%9.`cidigit'f")
        }
        
        // Get cutoff value - modified to handle individual cutoffs for each variable
        if `i' <= `cut_count' {
            local cut_val: word `i' of `cutoff'
        }
        else {
            // If no cutoff provided for this variable, find optimal using median
            qui sum `var', detail
            local cut_val = r(p50)
        }
        
        // Generate binary classification based on cutoff
        tempvar test_pos
        qui gen `test_pos' = `var' >= `cut_val' if !missing(`var')
        
        // Calculate sensitivity and specificity
        qui count if `test_pos' == 1 & `gold' == 1
        local true_pos = r(N)
        qui count if `test_pos' == 0 & `gold' == 1
        local false_neg = r(N)
        qui count if `test_pos' == 0 & `gold' == 0
        local true_neg = r(N)
        qui count if `test_pos' == 1 & `gold' == 0
        local false_pos = r(N)
        
        // Sensitivity = TP / (TP + FN)
        local sensitivity = 100 * `true_pos' / (`true_pos' + `false_neg')
        // Specificity = TN / (TN + FP)
        local specificity = 100 * `true_neg' / (`true_neg' + `false_pos')
        
        // PPV and NPV
        local ppv = 100 * `true_pos' / (`true_pos' + `false_pos')
        local npv = 100 * `true_neg' / (`true_neg' + `false_neg')
        
        // Accuracy
        local accuracy = 100 * (`true_pos' + `true_neg') / (`true_pos' + `true_neg' + `false_pos' + `false_neg')
        
        // P value (from Chi-square test)
        qui tab `test_pos' `gold', chi2
        local p_value = r(p)
        if `p_value' < 0.001 {
            local p_value_str = "<0.001"
        }
        else {
            local p_value_str = string(`p_value', "%9.`pdigit'f")
        }
        
        // Format values with fractions/percentages for display
        local sens_display = string(`sensitivity', "%9.`digit'f")
        local spec_display = string(`specificity', "%9.`digit'f")
        local ppv_display = string(`ppv', "%9.`digit'f") + " (" + string(`true_pos') + "/" + string(`true_pos' + `false_pos') + ")"
        local npv_display = string(`npv', "%9.`digit'f") + " (" + string(`true_neg') + "/" + string(`true_neg' + `false_neg') + ")"
        local accuracy_display = string(`accuracy', "%9.`digit'f") + " (" + string(`true_pos' + `true_neg') + "/" + string(`true_pos' + `true_neg' + `false_pos' + `false_neg') + ")"
        
        // Write table row
        file write `hh' "<tr>" _n
        file write `hh' "<td>`varlab'</td>" _n
        file write `hh' "<td class='center'>`auc_display'</td>" _n
        file write `hh' "<td class='center'>`cut_val'</td>" _n
        file write `hh' "<td class='center'>`sens_display'</td>" _n
        file write `hh' "<td class='center'>`spec_display'</td>" _n
        file write `hh' "<td class='center'>`p_value_str'</td>" _n
        file write `hh' "<td class='center'>`ppv_display'</td>" _n
        file write `hh' "<td class='center'>`npv_display'</td>" _n
        file write `hh' "<td class='center'>`accuracy_display'</td>" _n
        file write `hh' "</tr>" _n
        
        // Clean up
        drop `test_pos'
        local i = `i' + 1
    }
    
    // Write variable abbreviations explanation footer if needed
    qui describe `varlist' `gold', varlist
    local all_vars = "`r(varlist)'"
    local has_abbrevs = 0
    
    // Check if any variable has abbreviations worth explaining
    foreach var of local all_vars {
        local varlab: variable label `var'
        if "`varlab'" != "" & length("`var'") <= 10 & length("`varlab'") > 15 {
            local has_abbrevs = 1
            continue, break
        }
    }
    
    // Add abbreviation explanations if needed
    if `has_abbrevs' {
        file write `hh' "<tr><td colspan='9' style='border:none; padding-top:10px;'>"
        
        // Create a list of abbreviations
        local abbrev_list = ""
        foreach var of local all_vars {
            local varlab: variable label `var'
            if "`varlab'" != "" & length("`var'") <= 10 & length("`varlab'") > 15 {
                local abbrev_list = "`abbrev_list' `var', "
            }
        }
        
        // Write abbreviation explanations
        if "`abbrev_list'" != "" {
            file write `hh' "<p style='margin-top:5px;'>"
            
            foreach var of local all_vars {
                local varlab: variable label `var'
                if "`varlab'" != "" & length("`var'") <= 10 & length("`varlab'") > 15 {
                    file write `hh' "`var', `varlab'; "
                }
            }
            
            // Add explanation for PPV/NPV if in English
            if "`lang'" == "eng" {
                file write `hh' "NPV, negative predictive value; PPV, positive predictive value."
            }
            else {
                file write `hh' "Giá trị DT (-), giá trị dự báo âm tính; Giá trị DT (+), giá trị dự báo dương tính."
            }
            
            file write `hh' "</p>"
        }
        
        file write `hh' "</td></tr>"
    }
    
    // Close table
    file write `hh' "</table>" _n
    
    // Add formulas and explanations in collapsible sections
    file write `hh' "<button class='collapsible'>`formula_title'</button>" _n
    file write `hh' "<div class='content'>" _n
    file write `hh' "<div class='formula-section'>" _n
    file write `hh' "<div class='formula-item'>`sensitivity_formula'</div>" _n
    file write `hh' "<div class='formula-item'>`specificity_formula'</div>" _n
    file write `hh' "<div class='formula-item'>`ppv_formula'</div>" _n
    file write `hh' "<div class='formula-item'>`npv_formula'</div>" _n
    file write `hh' "<div class='formula-item'>`accuracy_formula'</div>" _n
    file write `hh' "<div class='formula-title' style='margin-top:15px;'>`where_title'</div>" _n
    file write `hh' "<div class='formula-item'>`tp_explanation'</div>" _n
    file write `hh' "<div class='formula-item'>`tn_explanation'</div>" _n
    file write `hh' "<div class='formula-item'>`fp_explanation'</div>" _n
    file write `hh' "<div class='formula-item'>`fn_explanation'</div>" _n
    file write `hh' "</div>" _n
    file write `hh' "</div>" _n
    
    // Add Stata commands section with simplified approach
    file write `hh' "<button class='collapsible'>`stata_command_title'</button>" _n
    file write `hh' "<div class='content'>" _n
    
    // Process each variable again for commands
    local i = 1
    foreach var of varlist `varlist' {
        // Get variable label
        local varlab: variable label `var'
        if "`varlab'" == "" local varlab "`var'"
        
        // Get cutoff value for this variable
        if `i' <= `cut_count' {
            local cut_val: word `i' of `cutoff'
        }
        else {
            // If no cutoff provided, use the median
            qui sum `var', detail
            local cut_val = r(p50)
        }
        
        // Write each section one by one to avoid complex string handling
        file write `hh' "<div class='formula-section'>" _n
        file write `hh' "<div class='formula-title'>Stata commands for variable `var':</div>" _n
        file write `hh' "<pre class='stata-command'>" _n
        
        // Basic ROC analysis with roctab
        file write `hh' "* ROC analysis for `var'" _n
        file write `hh' "roctab `gold' `var', table graph detail" _n _n
        
        // Custom ROC curve with better formatting
        file write `hh' "* Draw ROC curve with better formatting" _n
        file write `hh' "roctab `gold' `var', graph summary norefline title(`var') name(`var'_roc, replace)" _n _n
        
        // Compare with other variables using rocomp
        file write `hh' "* Compare ROC curves with other variables" _n
        file write `hh' "rocomp `gold' `var' [other_var1] [other_var2], graph summary" _n _n
        
        // Simple sensitivity/specificity information
        file write `hh' "* Quick sensitivity/specificity at optimal cutoff" _n
        file write `hh' "sum `var', detail" _n
        file write `hh' "local cut_val = r(p50)  // or use your preferred cutoff value" _n
        file write `hh' "gen test_pos = `var' >= `cut_val' if !missing(`var')" _n
        file write `hh' "tab test_pos `gold', row col" _n _n
        
        // Close the pre tag and div
        file write `hh' "</pre>" _n
        file write `hh' "</div>" _n
        
        local i = `i' + 1
    }
    
    // Close the content div
    file write `hh' "</div>" _n
    
    // Add timestamp
    local timestamp = c(current_date) + " " + c(current_time)
    file write `hh' "<p class='timestamp'>`timestamp_label' `timestamp'</p>" _n
    
    // Close HTML
    file write `hh' "</body></html>" _n
    file close `hh'
    
    // Display link to the created file
    local fullpath = "file:" + c(pwd) + "/" + "`output'"
    display as text _n "Copy liên kết dán vào trình duyệt hoặc tìm nguồn mở file {browse `fullpath'}"
    

    shell start "" "`fullpath'"
    if "`autoopen'" != "" {
        shell start "`output'"
    }
    
    return local output "`output'"
    return local timestamp "`timestamp'"
end