.hlp rasenganhtml
{smcl}
{* *! version 1.0 2023.12.02}{...}
{hline}
{title:rasenganhtml}
{p}
{bf:Generates an HTML table summarizing descriptive statistics and association results.}
{hline}

{title:Syntax}
{p 8 18 2}
{cmd:rasenganhtml} {varlist} [{cmd:if}] [{cmd:in}], {cmd:by(}{varname}{cmd:)}
[{cmd:ib(}{it:integer 1}{cmd:)}] [{cmd:ratio(}{it:string}{cmd:)}] [{cmd:per(}{it:string}{cmd:)}]
[{cmd:p(}{it:string}{cmd:)}] [{cmd:output(}{it:string}{cmd:)}] [{cmd:digit(}{it:integer 1}{cmd:)}]
[{cmd:autoopen}] [{cmd:title(}{it:string}{cmd:)}] [{cmd:pnote(}{it:string}{cmd:)}] [{cmd:lang(}{it:string}{cmd:)}] [{cmd:N(}{it:string}{cmd:)}]

{title:Description}
{p}
{cmd:rasenganhtml} generates an HTML table summarizing descriptive statistics and association results for a set of variables, broken down by a specified grouping variable. The HTML table includes:
{ul}
    {li} Descriptive statistics: Mean and standard deviation (for continuous variables), counts and percentages (for categorical variables) for each group.
    {li} Comparisons: p-values from statistical tests (t-test for continuous variables, chi-square or Fisher's exact test for categorical variables).
    {li} Association measure: Odds ratio (OR), risk ratio (RR), or prevalence ratio (PR) and their 95% confidence intervals.
{ul}


{title:Options}
{p 8 18 2}
{opt by(varname)} specifies the grouping variable.  The data will be analyzed separately for each group of this variable.
{p 8 18 2}
{opt ib(integer 1)} specifies the base category for categorical variables (default is {it:1}). Useful when categorical variables are not coded starting from 1.
{p 8 18 2}
{opt ratio(string)} specifies the type of ratio to be calculated:
{ul}
    {li} {cmd:OR} (Odds Ratio, default)
    {li} {cmd:RR} (Risk Ratio)
    {li} {cmd:PR} (Prevalence Ratio)
{ul}
{p 8 18 2}
{opt per(string)} specifies how percentages are calculated:
{ul}
    {li} {cmd:row} (percentages based on row totals, default)
    {li} {cmd:col} (percentages based on column totals)
{ul}
{p 8 18 2}
{opt p(string)} : Placeholder for future purpose (currently unused).
{p 8 18 2}
{opt output(string)} specifies the output HTML filename. The default is {cmd:rasengan.html} or {cmd:rasengan_#.html} if a file with that name already exists.
{p 8 18 2}
{opt digit(integer 1)} specifies the number of decimal places for numeric values (default is {it:1}).
{p 8 18 2}
{opt autoopen} automatically opens the generated HTML file in a web browser after creation.
{p 8 18 2}
{opt title(string)} specifies the title of the HTML page.
{p 8 18 2}
{opt pnote(string)} If set to "TRUE", displays a footnote explaining which test is being used
{p 8 18 2}
{opt lang(string)} specifies the language of the output: {cmd:vie} (Vietnamese, default) or {cmd:eng} (English).
{p 8 18 2}
{opt N(string)}:  If set to "TRUE", the total sample size (N) for each variable will be shown in the table's variable label.

{title:Examples}
{p 8 18 2}
{hline}
{stata}
* Load sample data
sysuse auto, clear

* Example 1: Basic analysis with default options
rasenganhtml mpg price weight, by(foreign)

* Example 2: Calculating RR, saving output file with custom filename and using 2 digits, auto open
rasenganhtml mpg price weight, by(foreign) ratio(RR) output(results_rr.html) digit(2) autoopen

* Example 3: Calculating OR, percentage by col, English language, display sample size
rasenganhtml mpg price weight, by(foreign) ratio(OR) per(col) lang(eng) N(TRUE)

* Example 4: variable has values 0, 1, 2, change default base value
gen value = 1
replace value = 0 if rep78 <= 3
replace value = 2 if rep78 == 5
rasenganhtml mpg price weight value, by(foreign) ib(0)

* Example 5: Using an if statement
rasenganhtml mpg price weight, by(foreign) if price > 5000
{hline}

{title:See Also}
{p}
{cmd:help summarize}, {cmd:help tabulate}, {cmd:help regress}, {cmd:help logistic}
{smcl}

Hãy cho tôi biết để tôi có thể hỗ trợ bạn tốt hơn: leanhngocump@gmail.com


       +---------------------------------------------------------------------------------------------------------------------+
        | Lê Anh Ngọc                                                                                                       | 
       +---------------------------------------------------------------------------------------------------------------------+
        | Cơ quan         : Đại học Y dược Thành phố Hồ Chí Minh                                                            |
        | ngày phát hành  : 04/01/2025                   								    |
        | Email           : leanhngocump@gmail.com                                                                          |
        | --> nếu bạn có nhu cầu hỗ trợ về phương pháp nghiên cứu hoặc phân tích số liệu, đừng ngại hãy gửi mail cho tôi <3 |
       +---------------------------------------------------------------------------------------------------------------------+