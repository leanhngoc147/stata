capture program drop chidorihtml
program define chidorihtml, rclass
    syntax varlist [if] [in], [cont(string)] [uncont(string)] ///
        [output(string)] [digit(integer 3)] [autoopen] [title(string)] [pnote(string)] [lang(string)] ///
        [pdigit(integer 3)] [robust(string)] [style(string)]
    
    // At least one of cont or uncont must be specified
    if "`cont'" == "" & "`uncont'" == "" {
        display as error "Phải chỉ định ít nhất một trong hai tùy chọn: cont() hoặc uncont()"
        exit 198
    }
    
    // Language settings
    if "`lang'" == "" local lang "vie"
    local lang = lower("`lang'")
    if !inlist("`lang'", "vie", "eng") {
        display as error "lang() phải là vie hoặc eng"
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
    
    // Check style option
    local use_le_style = 0
    if "`style'" != "" {
        local style = lower("`style'")
        if "`style'" == "le" {
            local use_le_style = 1
        }
    }
    
    // Set language-specific text
    if "`lang'" == "vie" {
        if "`title'" == "" local title "KẾT QUẢ PHÂN TÍCH"
        local char_header "ĐẶC ĐIỂM"
        local mean_label "Trung bình ± ĐLC"
        local median_label "Trung vị (IQR)"
        local timestamp_label "Được tạo lúc:"
        local footnote_a "Hồi quy tuyến tính"
        local footnote_b "Kiểm định t (T-test)"
        local footnote_c "Kiểm định Mann-Whitney (Wilcoxon rank)"
        local footnote_d "Kiểm định ANOVA một chiều"
        local footnote_e "Kiểm định Kruskal-Wallis"
        local footnote_f "Hồi quy tuyến tính với hiệu chỉnh robust"
        local footnote_g "Tương quan Pearson (Pearson correlation)"
        local footnote_h "Tương quan Spearman (Spearman correlation)"
        local p_value_label "p"
        local p_value_row_label "Giá trị p"
        local coef_header "Hệ số (KTC 95%)"
        local correlation_label "Hệ số tương quan"
        local stat_label_continuous "Giá trị"
    }
    else {
        if "`title'" == "" local title "ANALYSIS RESULTS"
        local char_header "CHARACTERISTICS"
        local mean_label "Mean ± SD"
        local median_label "Median (IQR)"
        local timestamp_label "Generated at:"
        local footnote_a "Linear regression"
        local footnote_b "t-test"
        local footnote_c "Mann-Whitney test (Wilcoxon rank)"
        local footnote_d "One-way ANOVA"
        local footnote_e "Kruskal-Wallis test"
        local footnote_f "Linear regression with robust adjustment"
        local footnote_g "Pearson correlation"
        local footnote_h "Spearman correlation"
        local p_value_label "p-value"
        local p_value_row_label "p-value"
        local coef_header "Coefficient (95% CI)"
        local correlation_label "Correlation"
        local stat_label_continuous "Value"
    }
    
    // Output file settings
    if "`output'" == "" {
        local file_prefix = "chidori"
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
    
    // Parse continuous and non-continuous variables
    tokenize "`cont'", parse(",")
    local cont_vars
    while "`1'" != "" {
        if "`1'" != "," {
            local cont_vars `cont_vars' `1'
        }
        macro shift
    }
    
    tokenize "`uncont'", parse(",")
    local uncont_vars
    while "`1'" != "" {
        if "`1'" != "," {
            local uncont_vars `uncont_vars' `1'
        }
        macro shift
    }
    
    // Convert spaces to list
    local cont_vars = trim("`cont_vars'")
    local uncont_vars = trim("`uncont_vars'")
    
    // Count number of dependent variables
    local num_cont_vars: word count `cont_vars'
    local num_uncont_vars: word count `uncont_vars'
    local total_dep_vars = `num_cont_vars' + `num_uncont_vars'
    
    // Check that all variables exist
    foreach var in `cont_vars' `uncont_vars' {
        capture confirm variable `var'
        if _rc {
            display as error "Biến `var' không tồn tại"
            exit 111
        }
        
        // Make sure it's numeric
        capture confirm numeric variable `var'
        if _rc {
            display as error "Biến `var' phải là biến số"
            exit 109
        }
    }
    
    // Calculate total columns
    local total_cols = `total_dep_vars' + 1 // +1 for characteristics column
    
    // Create HTML file
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
        ".p-value-row {font-weight: bold; font-style: italic; background-color: #f0f0f0;}" _n ///
        ".p-value-row td {text-align: center !important;}" _n ///
        ".indent {padding-left: 20px;}" _n ///
        ".button-container {margin-bottom: 10px;}" _n ///
        ".significant {font-weight: bold;}" _n ///
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
        ".summary-box {" _n ///
        "    border: 1px solid #ddd;" _n ///
        "    border-radius: 5px;" _n ///
        "    padding: 10px;" _n ///
        "    margin-bottom: 20px;" _n ///
        "    background-color: #f9f9f9;" _n ///
        "}" _n ///
        ".summary-title {" _n ///
        "    font-weight: bold;" _n ///
        "    font-size: 1.1em;" _n ///
        "    margin-bottom: 10px;" _n ///
        "}" _n ///
        ".variable-header {" _n ///
        "    text-align: center;" _n ///
        "    font-weight: bold;" _n ///
        "}" _n ///
        ".stat-type {" _n ///
        "    font-size: 0.85em;" _n ///
        "    display: block;" _n ///
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
        "</head><body>" _n
    
    // Create summary box for dependent variables
    file write `hh' "<div class='summary-box'>" _n ///
        "<div class='summary-title'>`title'</div>" _n
    
    // Include info for each dependent variable
    foreach var in `cont_vars' {
        qui sum `var', detail
        local var_mean = string(r(mean), "%9.2f")
        local var_sd = string(r(sd), "%9.2f")
        local var_n = r(N)
        
        local varlab: variable label `var'
        if "`varlab'" == "" local varlab `var'
        
        file write `hh' "<p><strong>`varlab'</strong> (N = `var_n'): `mean_label': `var_mean' ± `var_sd'</p>" _n
    }
    
    foreach var in `uncont_vars' {
        qui sum `var', detail
        local var_median = string(r(p50), "%9.2f")
        local var_q1 = string(r(p25), "%9.2f")
        local var_q3 = string(r(p75), "%9.2f")
        local var_n = r(N)
        
        local varlab: variable label `var'
        if "`varlab'" == "" local varlab `var'
        
        file write `hh' "<p><strong>`varlab'</strong> (N = `var_n'): `median_label': `var_median' (`var_q1' - `var_q3')</p>" _n
    }
    
    file write `hh' "</div>" _n
    
    // Button container
    file write `hh' ///
        "<div class='button-container'>" _n ///
        "<button class='btn copy-btn' onclick='copyTableToClipboard()'>Copy Table</button>" _n ///
        "<button class='btn decimal-btn' onclick='switchDecimalSeparator()' data-current='dot'>Use Comma (,) Decimal</button>" _n ///
        "</div>" _n
    
    // Start table
    file write `hh' "<table>" _n
    
    // Create table header
    file write `hh' "<tr>" _n ///
        "<th rowspan='2' style='text-align: left;'>`char_header'</th>" _n
    
    // Add headers for each dependent variable
    foreach var in `cont_vars' {
        local varlab: variable label `var'
        if "`varlab'" == "" local varlab `var'
        
        if `use_le_style' == 1 {
            file write `hh' "<th colspan='1' class='variable-header'>`varlab'</th>" _n
        }
        else {
            file write `hh' "<th colspan='2' class='variable-header'>`varlab'</th>" _n
        }
    }
    
    foreach var in `uncont_vars' {
        local varlab: variable label `var'
        if "`varlab'" == "" local varlab `var'
        
        if `use_le_style' == 1 {
            file write `hh' "<th colspan='1' class='variable-header'>`varlab'</th>" _n
        }
        else {
            file write `hh' "<th colspan='2' class='variable-header'>`varlab'</th>" _n
        }
    }
    
    file write `hh' "</tr>" _n
    
    // Add second header row for stat type
    if `use_le_style' == 0 {
        file write `hh' "<tr>" _n
        
        // Add column headers for each dependent variable
        foreach var in `cont_vars' {
            file write `hh' "<th>`mean_label'</th>" _n ///
                "<th>`p_value_label'</th>" _n
        }
        
        foreach var in `uncont_vars' {
            file write `hh' "<th>`median_label'</th>" _n ///
                "<th>`p_value_label'</th>" _n
        }
        
        file write `hh' "</tr>" _n
    }
    else {
        file write `hh' "<tr>" _n
        
        // Add column headers for each dependent variable
        foreach var in `cont_vars' {
            file write `hh' "<th>`mean_label'</th>" _n
        }
        
        foreach var in `uncont_vars' {
            file write `hh' "<th>`median_label'</th>" _n
        }
        
        file write `hh' "</tr>" _n
    }
    
    // Create locals to track which footnotes are used
    local used_notes ""
    
    // Create a table to store p-values when using LE style
    tempname p_values
    if `use_le_style' == 1 {
        matrix `p_values' = J(`=wordcount("`varlist'")', `total_dep_vars', .)
        local p_value_notes ""
    }
    
    // Process each independent variable
    local var_index = 1
    foreach var of varlist `varlist' {
        // Create a temporary variable for tracking used test types
        local temp_used_notes ""
        
        local varlab: variable label `var'
        if "`varlab'" == "" local varlab "`var'"
        
        // Determine if the variable is categorical or continuous
        capture confirm numeric variable `var'
        if !_rc {
            // First check if the variable has value labels
            local val_lab: value label `var'
            local has_value_labels = ("`val_lab'" != "")
            
            // Get unique values
            qui levelsof `var', local(unique_values)
            local value_count: word count `unique_values'
            
            // Try to determine if the variable is truly continuous
            // It's continuous if it has many unique values and no value labels
            // We'll consider it continuous if it has more than 10 unique values and no value labels
            if `value_count' > 10 & `has_value_labels' == 0 {
                local is_categorical = 0  // Continuous variable
            } 
            else {
                local is_categorical = 1  // Categorical variable
            }
        } 
        else {
            // String variables are always categorical
            local is_categorical = 1
        }
        
        // Calculate total columns for the header row
        local header_colspan = `total_dep_vars' + 1
        if `use_le_style' == 0 {
            local header_colspan = (2 * `total_dep_vars') + 1
        }
        
        // Write variable header row
        file write `hh' "<tr><td class='group-header' colspan='`header_colspan''>`varlab'</td></tr>" _n
        
        if `is_categorical' {
            // Get the levels of the categorical variable
            capture confirm numeric variable `var'
            if !_rc {
                qui levelsof `var', local(levels)
            } 
            else {
                qui levelsof `var', local(levels) clean
            }
            
            // Get the first level as reference
            local ref_level: word 1 of `levels'
            
            // Remember test types for p-value row
            local test_types ""
            
            // Analysis for each level
            foreach l of local levels {
                capture confirm numeric variable `var'
                if !_rc {
                    local vallabel: label (`var') `l'
                    if "`vallabel'" == "" local vallabel "`l'"
                } 
                else {
                    local vallabel = "`l'"
                }
                
                // Calculate statistics and tests for this level for all dependent variables
                capture confirm numeric variable `var'
                if !_rc {
                    qui count if `var' == `l'
                } 
                else {
                    qui count if `var' == "`l'"
                }
                local level_n = r(N)
                
                // Write row with the category label
                file write `hh' "<tr>" _n ///
                    "<td class='indent'>`vallabel' (n=`level_n')</td>" _n
                
                // Process each continuous dependent variable
                local dep_var_index = 1
                foreach depvar in `cont_vars' {
                    // Calculate statistics for this level
                    capture confirm numeric variable `var'
                    if !_rc {
                        qui sum `depvar' if `var' == `l', detail
                    } 
                    else {
                        qui sum `depvar' if `var' == "`l'", detail
                    }
                    
                    local level_mean = string(r(mean), "%9.2f")
                    local level_sd = string(r(sd), "%9.2f")
                    local level_value = "`level_mean' ± `level_sd'"
                    
                    // If digit parameter is provided, use it instead of default
                    if "`digit'" != "3" {
                        local level_mean = string(r(mean), "%9.`digit'f")
                        local level_sd = string(r(sd), "%9.`digit'f")
                        local level_value = "`level_mean' ± `level_sd'"
                    }
                    
                    // Run appropriate statistical test for the entire variable
                    // Only calculate p-value for the first level
                    if "`l'" == "`ref_level'" {
                        // Check if binary or categorical
                        qui levelsof `var', local(cat_levels)
                        local num_cat_levels: word count `cat_levels'
                        
                        if `num_cat_levels' == 2 {
                            // Binary variable - use t-test for normally distributed variables
                            // First check for normality using Shapiro-Wilk test (if available)
                            capture quietly swilk `depvar'
                            local is_normal = 1
                            if _rc == 0 {
                                if r(p) < 0.05 {
                                    local is_normal = 0
                                }
                            }
                            
                            // Use appropriate test based on normality
                            if `is_normal' == 1 {
                                // Use t-test for normal distribution
                                local test_type = "b" // t-test
                                local test_types "`test_types'b"
                                local temp_used_notes "`temp_used_notes' b"
                                
                                qui ttest `depvar', by(`var')
                                local p_value = r(p)
                            }
                            else {
                                // Use Mann-Whitney/Wilcoxon rank sum for non-normal distribution
                                local test_type = "c" // Mann-Whitney
                                local test_types "`test_types'c"
                                local temp_used_notes "`temp_used_notes' c"
                                
                                qui ranksum `depvar', by(`var')
                                local p_value = r(p)
                            }
                        } 
                        else {
                            // Multi-category variable - use ANOVA
                            local test_type = "d" // ANOVA
                            local test_types "`test_types'd"
                            local temp_used_notes "`temp_used_notes' d"
                            
                            qui anova `depvar' `var'
                            local p_value = Ftail(e(df_m), e(df_r), e(F))
                        }
                        
                        // Format p-value
                        if `p_value' < 0.001 {
                            local p_display = "<0.001"
                        } 
                        else {
                            local p_display = string(`p_value', "%9.`pdigit'f")
                        }
                        
                        // Store p-value for LE style
                        if `use_le_style' == 1 {
                            matrix `p_values'[`var_index', `dep_var_index'] = `p_value'
                            local note_index = `var_index'
                            local p_value_notes = "`p_value_notes'`test_type'"
                        }
                        
                        if "`pnote'" == "TRUE" & `use_le_style' == 0 {
                            local p_display "`p_display'<sup>`test_type'</sup>"
                        }
                    } 
                    else {
                        local p_display = ""
                    }
                    
                    // Write cells for this dependent variable
                    if `use_le_style' == 0 {
                        file write `hh' "<td class='center'>`level_value'</td>" _n ///
                            "<td class='center'>`p_display'</td>" _n
                    }
                    else {
                        file write `hh' "<td class='center'>`level_value'</td>" _n
                    }
                    
                    local dep_var_index = `dep_var_index' + 1
                }
                
                // Process each non-continuous dependent variable
                foreach depvar in `uncont_vars' {
                    // Calculate statistics for this level
                    capture confirm numeric variable `var'
                    if !_rc {
                        qui sum `depvar' if `var' == `l', detail
                    } 
                    else {
                        qui sum `depvar' if `var' == "`l'", detail
                    }
                    
                    local level_median = string(r(p50), "%9.2f")
                    local level_q1 = string(r(p25), "%9.2f")
                    local level_q3 = string(r(p75), "%9.2f")
                    local level_value = "`level_median' (`level_q1' - `level_q3')"
                    
                    // If digit parameter is provided, use it instead of default
                    if "`digit'" != "3" {
                        local level_median = string(r(p50), "%9.`digit'f")
                        local level_q1 = string(r(p25), "%9.`digit'f")
                        local level_q3 = string(r(p75), "%9.`digit'f")
                        local level_value = "`level_median' (`level_q1' - `level_q3')"
                    }
                    
                    // Run appropriate statistical test for the entire variable
                    // Only calculate p-value for the first level
                    if "`l'" == "`ref_level'" {
                        // For non-continuous dependent variables, always use non-parametric tests
                        // Check if binary or categorical
                        qui levelsof `var', local(cat_levels)
                        local num_cat_levels: word count `cat_levels'
                        
                        if `num_cat_levels' == 2 {
                            // Binary variable - use Mann-Whitney/Wilcoxon rank sum test
                            local test_type = "c" // Mann-Whitney/Wilcoxon rank sum
                            local test_types "`test_types'c"
                            local temp_used_notes "`temp_used_notes' c"
                            
                            qui ranksum `depvar', by(`var')
                            local p_value = r(p)
                        } 
                        else {
                            // Multi-category variable - use Kruskal-Wallis
                            local test_type = "e" // Kruskal-Wallis
                            local test_types "`test_types'e"
                            local temp_used_notes "`temp_used_notes' e"
                            
                            qui kwallis `depvar', by(`var')
                            local p_value = chi2tail(r(df), r(chi2_adj))
                        }
                        
                        // Format p-value
                        if `p_value' < 0.001 {
                            local p_display = "<0.001"
                        } 
                        else {
                            local p_display = string(`p_value', "%9.`pdigit'f")
                        }
                        
                        // Store p-value for LE style
                        if `use_le_style' == 1 {
                            matrix `p_values'[`var_index', `dep_var_index'] = `p_value'
                        }
                        
                        if "`pnote'" == "TRUE" & `use_le_style' == 0 {
                            local p_display "`p_display'<sup>`test_type'</sup>"
                        }
                    } 
                    else {
                        local p_display = ""
                    }
                    
                    // Write cells for this dependent variable
                    if `use_le_style' == 0 {
                        file write `hh' "<td class='center'>`level_value'</td>" _n ///
                            "<td class='center'>`p_display'</td>" _n
                    }
                    else {
                        file write `hh' "<td class='center'>`level_value'</td>" _n
                    }
                    
                    local dep_var_index = `dep_var_index' + 1
                }
                
                file write `hh' "</tr>" _n
            }
            
                            // Add p-value row for LE style
            if `use_le_style' == 1 {
                file write `hh' "<tr class='p-value-row'>" _n ///
                    "<td class='indent'>`p_value_row_label'</td>" _n
                
                // Write p-values for each dependent variable
                local dep_var_index = 1
                local test_index = 1
                foreach depvar in `cont_vars' `uncont_vars' {
                    local p_val = `p_values'[`var_index', `dep_var_index']
                    local test_char = substr("`test_types'", `test_index', 1)
                    
                    // Format p-value
                    if `p_val' < 0.001 {
                        local p_display = "<0.001"
                        // Make significant p-values bold
                        local class_add = " class='significant'"
                    } 
                    else if `p_val' < 0.05 {
                        local p_display = string(`p_val', "%9.`pdigit'f")
                        // Make significant p-values bold
                        local class_add = " class='significant'"
                    }
                    else {
                        local p_display = string(`p_val', "%9.`pdigit'f")
                        local class_add = ""
                    }
                    
                    // Add footnote to the p-value itself if pnote is TRUE
                    if "`pnote'" == "TRUE" {
                        file write `hh' "<td`class_add' class='center'>`p_display'<sup>`test_char'</sup></td>" _n
                    }
                    else {
                        file write `hh' "<td`class_add' class='center'>`p_display'</td>" _n
                    }
                    
                    local dep_var_index = `dep_var_index' + 1
                    local test_index = `test_index' + 1
                }
                
                file write `hh' "</tr>" _n
            }
        } 
        else {
            // Continuous independent variable
            // Start row
            file write `hh' "<tr>" _n ///
                "<td class='indent'>Continuous</td>" _n
            
            // Process each continuous dependent variable
            local dep_var_index = 1
            foreach depvar in `cont_vars' {
                // Calculate Pearson correlation coefficient for continuous dependent variables
                qui pwcorr `depvar' `var', sig
                local r = r(rho)
                // Use 3 decimal places by default for correlation coefficients, or use the digit parameter if specified
                local r_str = string(`r', "%9.3f")
                if "`digit'" != "3" {
                    local r_str = string(`r', "%9.`digit'f")
                }
                local p_corr = r(sig)
                
                // Store p-value for LE style
                if `use_le_style' == 1 {
                    matrix `p_values'[`var_index', `dep_var_index'] = `p_corr'
                }
                
                // Use the correlation notes for Pearson correlation
                local test_type = "g"
                local temp_used_notes "`temp_used_notes' g"
                
                // For continuous independent variables, display correlation coefficient
                if `use_le_style' == 0 {
                    // Format correlation p-value
                    if `p_corr' < 0.001 {
                        local p_corr_display = "<0.001"
                    } 
                    else {
                        // Use 3 decimal places for p-values by default
                        local p_corr_display = string(`p_corr', "%9.3f")
                        // If pdigit parameter is specified, use that instead
                        if "`pdigit'" != "3" {
                            local p_corr_display = string(`p_corr', "%9.`pdigit'f")
                        }
                    }
                
                    if "`pnote'" == "TRUE" {
                        file write `hh' "<td class='center'>r=`r_str'<sup>g</sup></td>" _n ///
                            "<td class='center'>`p_corr_display'</td>" _n
                    } 
                    else {
                        file write `hh' "<td class='center'>r=`r_str'</td>" _n ///
                            "<td class='center'>`p_corr_display'</td>" _n
                    }
                }
                else {
                    file write `hh' "<td class='center'>r=`r_str'</td>" _n
                }
                
                local dep_var_index = `dep_var_index' + 1
            }
            
            // Process each non-continuous dependent variable
            foreach depvar in `uncont_vars' {
                // Calculate Spearman correlation coefficient for non-continuous dependent variables
                qui spearman `depvar' `var'
                local rho = r(rho)
                // Use 3 decimal places by default for correlation coefficients, or use the digit parameter if specified
                local rho_str = string(`rho', "%9.3f")
                if "`digit'" != "3" {
                    local rho_str = string(`rho', "%9.`digit'f")
                }
                local p_corr = r(p)
                
                // Store p-value for LE style
                if `use_le_style' == 1 {
                    matrix `p_values'[`var_index', `dep_var_index'] = `p_corr'
                }
                
                // Use the correlation notes for Spearman correlation
                local test_type = "h"
                local temp_used_notes "`temp_used_notes' h"
                
                // For continuous independent variables, display correlation coefficient
                if `use_le_style' == 0 {
                    // Format correlation p-value
                    if `p_corr' < 0.001 {
                        local p_corr_display = "<0.001"
                    } 
                    else {
                        // Use 3 decimal places for p-values by default
                        local p_corr_display = string(`p_corr', "%9.3f")
                        // If pdigit parameter is specified, use that instead
                        if "`pdigit'" != "3" {
                            local p_corr_display = string(`p_corr', "%9.`pdigit'f")
                        }
                    }
                
                    if "`pnote'" == "TRUE" {
                        file write `hh' "<td class='center'>r=`rho_str'</td>" _n ///
                            "<td class='center'>`p_corr_display'<sup>h</sup></td>" _n
                    } 
                    else {
                        file write `hh' "<td class='center'>r=`rho_str'</td>" _n ///
                            "<td class='center'>`p_corr_display'</td>" _n
                    }
                }
                else {
                    file write `hh' "<td class='center'>r=`rho_str'</td>" _n
                }
                
                local dep_var_index = `dep_var_index' + 1
            }
            
            file write `hh' "</tr>" _n
            
            // Add p-value row for LE style
            if `use_le_style' == 1 {
                file write `hh' "<tr class='p-value-row'>" _n ///
                    "<td class='indent'>`p_value_row_label'</td>" _n
                
                // Write p-values for each dependent variable
                local dep_var_index = 1
                foreach depvar in `cont_vars' `uncont_vars' {
                    local p_val = `p_values'[`var_index', `dep_var_index']
                    
                    // Format p-value
                    if `p_val' < 0.001 {
                        local p_display = "<0.001"
                        // Make significant p-values bold
                        local class_add = " class='significant'"
                    } 
                    else if `p_val' < 0.05 {
                        local p_display = string(`p_val', "%9.`pdigit'f")
                        // Make significant p-values bold
                        local class_add = " class='significant'"
                    }
                    else {
                        local p_display = string(`p_val', "%9.`pdigit'f")
                        local class_add = ""
                    }
                    
                    // Add footnote to the p-value itself if pnote is TRUE
                    if "`pnote'" == "TRUE" {
                        // For continuous variables, use g or h based on the variable type
                        if `dep_var_index' <= `num_cont_vars' {
                            file write `hh' "<td`class_add' class='center' style='text-align: center;'>`p_display'<sup>g</sup></td>" _n
                        }
                        else {
                            file write `hh' "<td`class_add' class='center' style='text-align: center;'>`p_display'<sup>h</sup></td>" _n
                        }
                    }
                    else {
                        file write `hh' "<td`class_add' class='center' style='text-align: center;'>`p_display'</td>" _n
                    }
                    
                    local dep_var_index = `dep_var_index' + 1
                }
                
                file write `hh' "</tr>" _n
            }
        }
        
        // Add the test types used for this variable to the overall list
        foreach note in `temp_used_notes' {
            if strpos("`used_notes'", "`note'") == 0 {
                local used_notes "`used_notes' `note'"
            }
        }
        
        local var_index = `var_index' + 1
    }
    
    file write `hh' "</table>" _n
    
    // Add footnotes if needed
    if "`pnote'" == "TRUE" {
        // Dynamic footnotes - only show those that were used
        file write `hh' "<p class='footnote'>" _n
        if strpos("`used_notes'", "a") > 0 {
            file write `hh' "a: `footnote_a'<br>" _n
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
        if strpos("`used_notes'", "g") > 0 {
            file write `hh' "g: `footnote_g'<br>" _n
        }
        if strpos("`used_notes'", "h") > 0 {
            file write `hh' "h: `footnote_h'<br>" _n
        }
        file write `hh' "</p>" _n
    }
    
    // Add timestamp
    local timestamp = c(current_date) + " " + c(current_time)
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