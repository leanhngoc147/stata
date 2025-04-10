capture program drop mvrasenganhtml
program define mvrasenganhtml, rclass
    syntax [anything(name=orig_varlist id="variable list" equalok)] [if] [in], by(varname) ///
        [ib(integer 1)] [ratio(string)] [mnames(string asis)] ///
        [output(string)] [digit(integer 1)] [autoopen] [title(string)] [pnote(string)] [lang(string)] ///
        [pdigit(integer 3)] [ratiodigit(integer 2)] [robust] [event(varname)] [eventtime(varname)] [eventvalue(string)] ///
        [continuous(string)] [characname(string)] ///
        [stepwise] [cutpoint(real 0.25)] [manual1(string)] [manual2(string)] [manual3(string)] [manual4(string)] ///
        [manual5(string)] [manual6(string)] [manual7(string)] [manual8(string)]


    // Process the variable list with checkqname
    capture checkqname `orig_varlist' `if' `in'
    if _rc {
        display as error "Error processing variable list with checkqname"
        exit _rc
    }
    
    // Get clean varlist, ib options, and continuous vars from checkqname
    local varlist = r(varlist)
    local ib_opts = r(ib_opts)
    
    // Get the continuous variables list from checkqname or from continuous() option
    local cont_vars = r(cont_vars)
    if "`continuous'" != "" {
        local cont_vars "`cont_vars' `continuous'"
    }
    
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
    
    // Robust is now a simple flag option, not a string option with true/false
    local use_robust = 0
    if "`robust'" != "" {
        local use_robust = 1
    }
    
    // Process manual lists
    local manual_lists ""
    local manual_count = 0
    
    foreach num of numlist 1/8 {
        if "`manual`num''" != "" {
            local manual_lists "`manual_lists' `num'"
            local manual_count = `manual_count' + 1
        }
    }
    
    // Parse model names
    if "`mnames'" == "" {
        if `manual_count' > 0 {
            local model_names `""Thô" "Hiệu chỉnh""'
            foreach num of local manual_lists {
                local model_names `"`model_names' "Mô hình `num'""'
            }
        }
        else {
            local model_names `""Thô" "Hiệu chỉnh""'
        }
    }
    else {
        local model_names `"`mnames'"'
        
        // Check model names count against manual models
        local mnames_count : word count `model_names'
        local expected_count = 2 + `manual_count'
        if "`stepwise'" != "" local expected_count = `expected_count' + 1
        
        if `mnames_count' != `expected_count' {
            display as error "Số lượng tên model không khớp với số lượng model (`expected_count')"
            exit 198
        }
    }
    
    // Count number of models
    local model_count : word count `model_names'
    
    if "`lang'" == "vie" {
        local ratio_header "`ratio' (KTC 95%)"
        if "`title'" == "" local title "KẾT QUẢ PHÂN TÍCH ĐA BIẾN"
        local char_header = "`characname'"
        if "`characname'" == "" local char_header "ĐẶC ĐIỂM"
        local p_header "p"
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
        local footnote_g = "Mô hình đa biến cuối cùng"
        local footnote_h = "Phương pháp stepwise (p < `cutpoint')"
        local ref_label "1"
    }
    else {
        local ratio_header "`ratio' (95% CI)"
        if "`title'" == "" local title "MULTIVARIATE ANALYSIS RESULTS"
        local char_header = "`characname'"
        if "`characname'" == "" local char_header "CHARACTERISTICS"
        local p_header "p"
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
        local footnote_g = "Final multivariate model"
        local footnote_h = "Stepwise method (p < `cutpoint')"
        local ref_label "ref"
    }
    
    if "`output'" == "" {
        local file_prefix = "mvrasengan"
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

    // Get by variable label
    local bylab: variable label `by'
    if "`bylab'" == "" local bylab `by'

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

    // Calculate total number of columns
    local total_cols = 1 + 2 * `model_count'  // 1 for var name + 2 columns per model

    // Write the first row with headers for each model (CHANGED THIS PART)
    file write `hh' "<tr>" _n 
    file write `hh' "<th style='text-align: left;'>`char_header'</th>" _n
    
    // Write each model name with its own bylab header
    foreach m of local model_names {
        file write `hh' "<th colspan='2'>`bylab' - `m'</th>" _n
    }
    
    file write `hh' "</tr>" _n
    
    // Write the second row with p and ratio headers for each model
    file write `hh' "<tr>" _n
    file write `hh' "<th></th>" _n // Empty cell for characteristic column
    
    // For each model, write p and OR/RR/etc header
    foreach m of local model_names {
        file write `hh' "<th>`p_header'</th>" _n ///
            "<th>`ratio_header'</th>" _n
    }
    
    file write `hh' "</tr>" _n

    // Create locals to track which footnotes are used
    local used_notes ""
    
    // Run stepwise model if specified
    if "`stepwise'" != "" {
        // Run appropriate model with stepwise
        if "`ratio'" == "OR" {
            qui stepwise, pr(`cutpoint'): logistic `by' `varlist'
        }
        else if "`ratio'" == "RR" | "`ratio'" == "PR" {
            qui stepwise, pr(`cutpoint'): poisson `by' `varlist', irr
        }
        else if "`ratio'" == "HR" {
            qui stset `eventtime', failure(`event' == `eventvalue')
            qui stepwise, pr(`cutpoint'): stcox `varlist'
        }
        
        // Get variables in the final model
        local stepwise_vars "`e(varlist)'"
        local used_notes "`used_notes' h"
    }
    
    // Process each variable in the varlist
    foreach var of varlist `varlist' {
        // Check if a custom reference level is specified for this variable
        local custom_ref = `ib'  // Default reference level from ib() option
        foreach item of local var_refs {
            if regexm("`item'", "^`var'=(.+)$") {
                local custom_ref = regexs(1)
                display as text "Using custom reference level `custom_ref' for variable `var'"
            }
        }
        
        local varlab: variable label `var'
        if "`varlab'" == "" local varlab "`var'"
        
        // Calculate the colspan based on number of models
        local colspan = 1 + 2 * `model_count'  // 1 for var name + 2 columns per model
        
        file write `hh' "<tr><td class='group-header' colspan='`colspan''>`varlab'</td></tr>" _n
        
        capture confirm numeric variable `var'
        if !_rc {
            local is_categorical = 0
            qui levelsof `var', local(unique_values)
            local value_count: word count `unique_values'
            
            local has_value_labels = 0
            local val_lab: value label `var'
            if "`val_lab'" != "" local has_value_labels = 1
            
            // Check if the variable is in the continuous variables list
            local is_continuous_var = 0
            if "`cont_vars'" != "" {
                foreach cont_var of local cont_vars {
                    if "`var'" == "`cont_var'" {
                        local is_continuous_var = 1
                        break
                    }
                }
            }
            
            // Check if continuous or categorical
            if `is_continuous_var' == 1 {
                // If it's in the continuous variables list, treat as continuous
                local is_categorical = 0
            }
            else if `value_count' <= 10 | `has_value_labels' == 1 {
                local is_categorical = 1
            }
            
            // If continuous variable, add a single row for it
            if `is_categorical' == 0 {
                file write `hh' "<tr>" _n ///
                    "<td class='indent'>`varlab'</td>" _n
                
                // Model 1: Univariate
                if "`ratio'" == "OR" {
                    if `use_robust' {
                        qui logistic `by' `var', vce(robust)
                    }
                    else {
                        qui logistic `by' `var'
                    }
                }
                else if "`ratio'" == "RR" || "`ratio'" == "PR" {
                    if `use_robust' {
                        qui poisson `by' `var', irr vce(robust)
                    }
                    else {
                        qui poisson `by' `var', irr
                    }
                }
                else if "`ratio'" == "HR" {
                    qui stset `eventtime', failure(`event' == `eventvalue')
                    if `use_robust' {
                        qui stcox `var', vce(robust)
                    }
                    else {
                        qui stcox `var'
                    }
                }
                
                capture local coef = _b[`var']
                capture local se = _se[`var']
                
                if !_rc & "`coef'" != "" & "`se'" != "" {
                    local p = 2 * (1 - normal(abs(`coef'/`se')))
                    
                    if "`ratio'" == "OR" | "`ratio'" == "RR" | "`ratio'" == "PR" | "`ratio'" == "HR" {
                        local ratio_val = exp(`coef')
                        local ratio_lb = exp(`coef' - 1.96*`se')
                        local ratio_ub = exp(`coef' + 1.96*`se')
                        
                        // Format p-value
                        if `p' < 0.001 {
                            local p_display = "<0.001"
                        }
                        else {
                            local p_display = string(`p', "%9.`pdigit'f")
                        }
                        
                        // Format ratio display
                        local ratio_display = string(`ratio_val', "%9.`ratiodigit'f") + " (" + ///
                            string(`ratio_lb', "%9.`ratiodigit'f") + "-" + ///
                            string(`ratio_ub', "%9.`ratiodigit'f") + ")"
                    }
                }
                else {
                    local p_display = ""
                    local ratio_display = ""
                }
                
                // Write univariate results
                file write `hh' "<td class='center'>`p_display'</td>" _n ///
                    "<td class='center'>`ratio_display'</td>" _n
                
                // Model 2: Multivariate with all variables
                if "`ratio'" == "OR" {
                    if `use_robust' {
                        qui logistic `by' `varlist', vce(robust)
                    }
                    else {
                        qui logistic `by' `varlist'
                    }
                }
                else if "`ratio'" == "RR" || "`ratio'" == "PR" {
                    if `use_robust' {
                        qui poisson `by' `varlist', irr vce(robust)
                    }
                    else {
                        qui poisson `by' `varlist', irr
                    }
                }
                else if "`ratio'" == "HR" {
                    qui stset `eventtime', failure(`event' == `eventvalue')
                    if `use_robust' {
                        qui stcox `varlist', vce(robust)
                    }
                    else {
                        qui stcox `varlist'
                    }
                }
                
                capture local coef = _b[`var']
                capture local se = _se[`var']
                
                if !_rc & "`coef'" != "" & "`se'" != "" {
                    local p = 2 * (1 - normal(abs(`coef'/`se')))
                    
                    if "`ratio'" == "OR" | "`ratio'" == "RR" | "`ratio'" == "PR" | "`ratio'" == "HR" {
                        local ratio_val = exp(`coef')
                        local ratio_lb = exp(`coef' - 1.96*`se')
                        local ratio_ub = exp(`coef' + 1.96*`se')
                        
                        // Format p-value
                        if `p' < 0.001 {
                            local p_display = "<0.001"
                        }
                        else {
                            local p_display = string(`p', "%9.`pdigit'f")
                        }
                        
                        // Format ratio display
                        local ratio_display = string(`ratio_val', "%9.`ratiodigit'f") + " (" + ///
                            string(`ratio_lb', "%9.`ratiodigit'f") + "-" + ///
                            string(`ratio_ub', "%9.`ratiodigit'f") + ")"
                    }
                }
                else {
                    local p_display = ""
                    local ratio_display = ""
                }
                
                // Write multivariate results
                file write `hh' "<td class='center'>`p_display'</td>" _n ///
                    "<td class='center'>`ratio_display'</td>" _n
                
                // Add Stepwise model if specified
                if "`stepwise'" != "" {
                    // Check if the variable is in the stepwise model
                    local in_stepwise = 0
                    foreach svar in `stepwise_vars' {
                        if "`svar'" == "`var'" {
                            local in_stepwise = 1
                            break
                        }
                    }
                    
                    if `in_stepwise' {
                        // Run stepwise model
                        if "`ratio'" == "OR" {
                            if `use_robust' {
                                qui logistic `by' `stepwise_vars', vce(robust)
                            }
                            else {
                                qui logistic `by' `stepwise_vars'
                            }
                        }
                        else if "`ratio'" == "RR" | "`ratio'" == "PR" {
                            if `use_robust' {
                                qui poisson `by' `stepwise_vars', irr vce(robust)
                            }
                            else {
                                qui poisson `by' `stepwise_vars', irr
                            }
                        }
                        else if "`ratio'" == "HR" {
                            qui stset `eventtime', failure(`event' == `eventvalue')
                            
                            if `use_robust' {
                                qui stcox `stepwise_vars', vce(robust)
                            }
                            else {
                                qui stcox `stepwise_vars'
                            }
                        }
                        
                        // Get p-value and ratio for this variable
                        local coef = _b[`var']
                        local se = _se[`var']
                        
                        local p = 2 * (1 - normal(abs(`coef'/`se')))
                        if `p' < 0.001 {
                            local p_step_str = "<0.001"
                        } 
                        else {
                            local p_step_str = string(`p', "%9.`pdigit'f")
                        }
                        
                        local est = exp(`coef')
                        local lb = exp(`coef' - 1.96*`se')
                        local ub = exp(`coef' + 1.96*`se')
                        
                        local ratio_step_val = string(`est', "%9.`ratiodigit'f") + " (" + string(`lb', "%9.`ratiodigit'f") + "-" + string(`ub', "%9.`ratiodigit'f") + ")"
                    }
                    else {
                        // Variable not in stepwise model
                        local p_step_str = "-"
                        local ratio_step_val = "-"
                    }
                    
                    // Write stepwise results
                    file write `hh' "<td class='center'>`p_step_str'</td>" _n ///
                        "<td class='center'>`ratio_step_val'</td>" _n
                }
                
                // Add manual models if specified
                foreach num of local manual_lists {
                    // Get the list of variables to exclude for this manual model
                    local exclude_vars = "`manual`num''"
                    local include_vars = ""
                    
                    // Build list of variables to include (all except excluded ones)
                    foreach v of local varlist {
                        local is_excluded = 0
                        foreach ex_var in `exclude_vars' {
                            if "`v'" == "`ex_var'" {
                                local is_excluded = 1
                                break
                            }
                        }
                        
                        if !`is_excluded' {
                            local include_vars "`include_vars' `v'"
                        }
                    }
                    
                    // Check if this variable is included
                    local is_included = 0
                    foreach inc of local include_vars {
                        if "`inc'" == "`var'" {
                            local is_included = 1
                            break
                        }
                    }
                    
                    if `is_included' {
                        // Run manual model
                        if "`ratio'" == "OR" {
                            if `use_robust' {
                                capture qui logistic `by' `include_vars', vce(robust)
                            }
                            else {
                                capture qui logistic `by' `include_vars'
                            }
                        }
                        else if "`ratio'" == "RR" | "`ratio'" == "PR" {
                            if `use_robust' {
                                capture qui poisson `by' `include_vars', irr vce(robust)
                            }
                            else {
                                capture qui poisson `by' `include_vars', irr
                            }
                        }
                        else if "`ratio'" == "HR" {
                            qui stset `eventtime', failure(`event' == `eventvalue')
                            
                            if `use_robust' {
                                capture qui stcox `include_vars', vce(robust)
                            }
                            else {
                                capture qui stcox `include_vars'
                            }
                        }
                        
                        if _rc == 0 {
                            local coef = _b[`var']
                            local se = _se[`var']
                            
                            local p = 2 * (1 - normal(abs(`coef'/`se')))
                            if `p' < 0.001 {
                                local p_man_str = "<0.001"
                            } 
                            else {
                                local p_man_str = string(`p', "%9.`pdigit'f")
                            }
                            
                            local est = exp(`coef')
                            local lb = exp(`coef' - 1.96*`se')
                            local ub = exp(`coef' + 1.96*`se')
                            
                            local ratio_man_val = string(`est', "%9.`ratiodigit'f") + " (" + string(`lb', "%9.`ratiodigit'f") + "-" + string(`ub', "%9.`ratiodigit'f") + ")"
                        }
                        else {
                            local p_man_str = "-"
                            local ratio_man_val = "-"
                        }
                    }
                    else {
                        local p_man_str = "-"
                        local ratio_man_val = "-"
                    }
                    
                    // Write manual model results
                    file write `hh' "<td class='center'>`p_man_str'</td>" _n ///
                        "<td class='center'>`ratio_man_val'</td>" _n
                }
                
                file write `hh' "</tr>" _n
            }
            else {
                // For categorical variable, add a row for each level
                qui levelsof `var', local(levels)
                
                // Use the custom reference level for this variable if specified, otherwise use the default
                local ref_level: word `custom_ref' of `levels'
                
                // Process each level of the categorical variable
                // Process each level of the categorical variable
                foreach l of local levels {
                    local vallabel: label (`var') `l'
                    if "`vallabel'" == "" local vallabel "`l'"
                    
                    file write `hh' "<tr>" _n ///
                        "<td class='indent'>`vallabel'</td>" _n
                    
                    // If this is the reference level, display "1" or "ref" in all model columns
                    if `l' == `ref_level' {
                        forvalues i = 1/`model_count' {
                            file write `hh' "<td class='center'></td>" _n ///
                                "<td class='center'>`ref_label'</td>" _n
                        }
                    }
                    else {
                        // Model 1: Univariate
                        if "`ratio'" == "OR" {
                            if `use_robust' {
                                capture qui logistic `by' i.`var', vce(robust)
                            }
                            else {
                                capture qui logistic `by' i.`var'
                            }
                        }
                        else if "`ratio'" == "RR" || "`ratio'" == "PR" {
                            if `use_robust' {
                                capture qui poisson `by' i.`var', irr vce(robust)
                            }
                            else {
                                capture qui poisson `by' i.`var', irr
                            }
                        }
                        else if "`ratio'" == "HR" {
                            qui stset `eventtime', failure(`event' == `eventvalue')
                            if `use_robust' {
                                capture qui stcox i.`var', vce(robust)
                            }
                            else {
                                capture qui stcox i.`var'
                            }
                        }
                        
                        capture local coef = _b[`l'.`var']
                        capture local se = _se[`l'.`var']
                        
                        if !_rc & "`coef'" != "" & "`se'" != "" {
                            local p = 2 * (1 - normal(abs(`coef'/`se')))
                            
                            if "`ratio'" == "OR" | "`ratio'" == "RR" | "`ratio'" == "PR" | "`ratio'" == "HR" {
                                local ratio_val = exp(`coef')
                                local ratio_lb = exp(`coef' - 1.96*`se')
                                local ratio_ub = exp(`coef' + 1.96*`se')
                                
                                // Format p-value
                                if `p' < 0.001 {
                                    local p_display = "<0.001"
                                }
                                else {
                                    local p_display = string(`p', "%9.`pdigit'f")
                                }
                                
                                // Format ratio display
                                local ratio_display = string(`ratio_val', "%9.`ratiodigit'f") + " (" + ///
                                    string(`ratio_lb', "%9.`ratiodigit'f") + "-" + ///
                                    string(`ratio_ub', "%9.`ratiodigit'f") + ")"
                            }
                        }
                        else {
                            local p_display = ""
                            local ratio_display = ""
                        }
                        
                        // Write univariate results
                        file write `hh' "<td class='center'>`p_display'</td>" _n ///
                            "<td class='center'>`ratio_display'</td>" _n
                        
                        // Model 2: Multivariate with all variables
                        if "`ratio'" == "OR" {
                            if `use_robust' {
                                capture qui logistic `by' i.`var' `=subinstr("`varlist'", "`var'", "", 1)', vce(robust)
                            }
                            else {
                                capture qui logistic `by' i.`var' `=subinstr("`varlist'", "`var'", "", 1)'
                            }
                        }
                        else if "`ratio'" == "RR" || "`ratio'" == "PR" {
                            if `use_robust' {
                                capture qui poisson `by' i.`var' `=subinstr("`varlist'", "`var'", "", 1)', irr vce(robust)
                            }
                            else {
                                capture qui poisson `by' i.`var' `=subinstr("`varlist'", "`var'", "", 1)', irr
                            }
                        }
                        else if "`ratio'" == "HR" {
                            qui stset `eventtime', failure(`event' == `eventvalue')
                            if `use_robust' {
                                capture qui stcox i.`var' `=subinstr("`varlist'", "`var'", "", 1)', vce(robust)
                            }
                            else {
                                capture qui stcox i.`var' `=subinstr("`varlist'", "`var'", "", 1)'
                            }
                        }
                        
                        capture local coef = _b[`l'.`var']
                        capture local se = _se[`l'.`var']
                        
                        if !_rc & "`coef'" != "" & "`se'" != "" {
                            local p = 2 * (1 - normal(abs(`coef'/`se')))
                            
                            if "`ratio'" == "OR" | "`ratio'" == "RR" | "`ratio'" == "PR" | "`ratio'" == "HR" {
                                local ratio_val = exp(`coef')
                                local ratio_lb = exp(`coef' - 1.96*`se')
                                local ratio_ub = exp(`coef' + 1.96*`se')
                                
                                // Format p-value
                                if `p' < 0.001 {
                                    local p_display = "<0.001"
                                }
                                else {
                                    local p_display = string(`p', "%9.`pdigit'f")
                                }
                                
                                // Format ratio display
                                local ratio_display = string(`ratio_val', "%9.`ratiodigit'f") + " (" + ///
                                    string(`ratio_lb', "%9.`ratiodigit'f") + "-" + ///
                                    string(`ratio_ub', "%9.`ratiodigit'f") + ")"
                            }
                        }
                        else {
                            local p_display = ""
                            local ratio_display = ""
                        }
                        
                        // Write multivariate results
                        file write `hh' "<td class='center'>`p_display'</td>" _n ///
                            "<td class='center'>`ratio_display'</td>" _n
                                                
                        // Add Stepwise model if specified
                        if "`stepwise'" != "" {
                            // Check if the variable is in the stepwise model
                            local in_stepwise = 0
                            foreach svar in `stepwise_vars' {
                                if "`svar'" == "`var'" {
                                    local in_stepwise = 1
                                    break
                                }
                            }
                            
                            if `in_stepwise' {
                                // Run stepwise model
                                if "`ratio'" == "OR" {
                                    if `use_robust' {
                                        qui logistic `by' i.`var' `=subinstr("`stepwise_vars'", "`var'", "", 1)', vce(robust)
                                    }
                                    else {
                                        qui logistic `by' i.`var' `=subinstr("`stepwise_vars'", "`var'", "", 1)'
                                    }
                                }
                                else if "`ratio'" == "RR" | "`ratio'" == "PR" {
                                    if `use_robust' {
                                        qui poisson `by' i.`var' `=subinstr("`stepwise_vars'", "`var'", "", 1)', irr vce(robust)
                                    }
                                    else {
                                        qui poisson `by' i.`var' `=subinstr("`stepwise_vars'", "`var'", "", 1)', irr
                                    }
                                }
                                else if "`ratio'" == "HR" {
                                    qui stset `eventtime', failure(`event' == `eventvalue')
                                    
                                    if `use_robust' {
                                        qui stcox i.`var' `=subinstr("`stepwise_vars'", "`var'", "", 1)', vce(robust)
                                    }
                                    else {
                                        qui stcox i.`var' `=subinstr("`stepwise_vars'", "`var'", "", 1)'
                                    }
                                }
                                
                                // Get p-value and ratio for this level
                                capture local coef = _b[`l'.`var']
                                capture local se = _se[`l'.`var']
                                
                                if !_rc & "`coef'" != "" & "`se'" != "" {
                                    local p = 2 * (1 - normal(abs(`coef'/`se')))
                                    if `p' < 0.001 {
                                        local p_step_str = "<0.001"
                                    } 
                                    else {
                                        local p_step_str = string(`p', "%9.`pdigit'f")
                                    }
                                    
                                    local est = exp(`coef')
                                    local lb = exp(`coef' - 1.96*`se')
                                    local ub = exp(`coef' + 1.96*`se')
                                    
                                    local ratio_step_val = string(`est', "%9.`ratiodigit'f") + " (" + string(`lb', "%9.`ratiodigit'f") + "-" + string(`ub', "%9.`ratiodigit'f") + ")"
                                }
                                else {
                                    local p_step_str = "-"
                                    local ratio_step_val = "-"
                                }
                            }
                            else {
                                // Variable not in stepwise model
                                local p_step_str = "-"
                                local ratio_step_val = "-"
                            }
                            
                            // Write stepwise results
                            file write `hh' "<td class='center'>`p_step_str'</td>" _n ///
                                "<td class='center'>`ratio_step_val'</td>" _n
                        }
                        
                        // Add manual models if specified
                        foreach num of local manual_lists {
                            // Get the list of variables to exclude for this manual model
                            local exclude_vars = "`manual`num''"
                            local include_vars = ""
                            
                            // Build list of variables to include (all except excluded ones)
                            foreach v of local varlist {
                                local is_excluded = 0
                                foreach ex_var in `exclude_vars' {
                                    if "`v'" == "`ex_var'" {
                                        local is_excluded = 1
                                        break
                                    }
                                }
                                
                                if !`is_excluded' {
                                    local include_vars "`include_vars' `v'"
                                }
                            }
                            
                            // Check if this variable is included
                            local is_included = 0
                            foreach inc of local include_vars {
                                if "`inc'" == "`var'" {
                                    local is_included = 1
                                    break
                                }
                            }
                            
                            if `is_included' {
                                // Run manual model
                                if "`ratio'" == "OR" {
                                    if `use_robust' {
                                        capture qui logistic `by' i.`var' `=subinstr("`include_vars'", "`var'", "", 1)', vce(robust)
                                    }
                                    else {
                                        capture qui logistic `by' i.`var' `=subinstr("`include_vars'", "`var'", "", 1)'
                                    }
                                }
                                else if "`ratio'" == "RR" | "`ratio'" == "PR" {
                                    if `use_robust' {
                                        capture qui poisson `by' i.`var' `=subinstr("`include_vars'", "`var'", "", 1)', irr vce(robust)
                                    }
                                    else {
                                        capture qui poisson `by' i.`var' `=subinstr("`include_vars'", "`var'", "", 1)', irr
                                    }
                                }
                                else if "`ratio'" == "HR" {
                                    qui stset `eventtime', failure(`event' == `eventvalue')
                                    
                                    if `use_robust' {
                                        capture qui stcox i.`var' `=subinstr("`include_vars'", "`var'", "", 1)', vce(robust)
                                    }
                                    else {
                                        capture qui stcox i.`var' `=subinstr("`include_vars'", "`var'", "", 1)'
                                    }
                                }
                                
                                if _rc == 0 {
                                    capture local coef = _b[`l'.`var']
                                    capture local se = _se[`l'.`var']
                                    
                                    if !_rc & "`coef'" != "" & "`se'" != "" {
                                        local p = 2 * (1 - normal(abs(`coef'/`se')))
                                        if `p' < 0.001 {
                                            local p_man_str = "<0.001"
                                        } 
                                        else {
                                            local p_man_str = string(`p', "%9.`pdigit'f")
                                        }
                                        
                                        local est = exp(`coef')
                                        local lb = exp(`coef' - 1.96*`se')
                                        local ub = exp(`coef' + 1.96*`se')
                                        
                                        local ratio_man_val = string(`est', "%9.`ratiodigit'f") + " (" + string(`lb', "%9.`ratiodigit'f") + "-" + string(`ub', "%9.`ratiodigit'f") + ")"
                                    }
                                    else {
                                        local p_man_str = "-"
                                        local ratio_man_val = "-"
                                    }
                                }
                                else {
                                    local p_man_str = "-"
                                    local ratio_man_val = "-"
                                }
                            }
                            else {
                                local p_man_str = "-"
                                local ratio_man_val = "-"
                            }
                            
                            // Write manual model results
                            file write `hh' "<td class='center'>`p_man_str'</td>" _n ///
                                "<td class='center'>`ratio_man_val'</td>" _n
                        }
                    }
                    
                    file write `hh' "</tr>" _n
                }
            }
        }
        else {
            // Handle string variables if needed
            display as text "Skipping string variable: `var'"
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
    
    // Display information about manual models if any were used
    if `manual_count' > 0 {
        file write `hh' "<p><strong>Manual models:</strong><br>" _n
        foreach num of local manual_lists {
            local exclude_vars = "`manual`num''"
            file write `hh' "Model `num': Variables excluded from analysis - "
            
            if "`exclude_vars'" == "" {
                file write `hh' "None"
            }
            else {
                local comma = 0
                foreach ex_var in `exclude_vars' {
                    if `comma' {
                        file write `hh' ", "
                    }
                    local varlab: variable label `ex_var'
                    if "`varlab'" == "" local varlab "`ex_var'"
                    file write `hh' "`varlab'"
                    local comma = 1
                }
            }
            file write `hh' "<br>" _n
        }
        file write `hh' "</p>" _n
    }
    
    // If stepwise was used, display information
    if "`stepwise'" != "" {
        file write `hh' "<p><strong>Stepwise selection:</strong><br>" _n
        file write `hh' "Variables in final model (p &lt; `cutpoint'): "
        
        if "`stepwise_vars'" == "" {
            file write `hh' "None"
        }
        else {
            local comma = 0
            foreach var in `stepwise_vars' {
                if `comma' {
                    file write `hh' ", "
                }
                local varlab: variable label `var'
                if "`varlab'" == "" local varlab "`var'"
                file write `hh' "`varlab'"
                local comma = 1
            }
        }
        file write `hh' "</p>" _n
    }
    
    if "`pnote'" == "TRUE" {
        // Footnote for regression type
        file write `hh' "<p class='footnote'>" _n
        file write `hh' "`footnote_a'"
        if `use_robust' {
            file write `hh' " with robust standard error"
        }
        
        // Add stepwise footnote if used
        if "`stepwise'" != "" {
            file write `hh' "<br>`footnote_h'" _n
        }
        
        file write `hh' "</p>" _n
    }
    
    file write `hh' "<p class='timestamp'>`timestamp_label' `timestamp'</p>" _n ///
        "</body></html>" _n
    
    // Display link to the created file
    file close `hh'
    
    local fullpath = "file:" + c(pwd) + "/" + "`output'"
    display as text _n "Copy liên kết dán vào trình duyệt hoặc tìm nguồn mở file {browse `fullpath'}"
        
    if "`autoopen'" != "" {
        shell start "`output'"
    }
    
    return local output "`output'"
    return local timestamp "`timestamp'"
end

* Helper program from the original rasenganhtml
capture program drop checkqname
program define checkqname, rclass
    version 11
    
    // Get the original variable list
    local orig_varlist `0'
    
    // Initialize 
    local clean_varlist ""
    local ib_opts ""
    local cont_vars ""
    
    // Extract each variable
    foreach word of local orig_varlist {
        // Check if it has the c. prefix (continuous variable)
        if regexm("`word'", "^[cC]\.(.+)$") {
            local var_name = regexs(1)
            
            // Add to clean list
            local clean_varlist "`clean_varlist' `var_name'"
            
            // Add to continuous variables list
            local cont_vars "`cont_vars' `var_name'"
        }
        // Check if it has the ib pattern
        else if regexm("`word'", "^ib([0-9]+)\.(.+)$") {
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
    return local cont_vars "`cont_vars'"
end