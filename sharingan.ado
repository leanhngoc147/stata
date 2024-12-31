capture program drop sharingan
program define sharingan, rclass
    version 15.0

    syntax [varlist] [, DIGIT(integer 1)]

    // Thêm hình ảnh Sharingan ASCII
	display as text "		███████╗██╗  ██╗ █████╗ ██████╗ ██╗███╗   ██╗ ██████╗  █████╗ ███╗   ██╗   "
	display as text "		██╔════╝██║  ██║██╔══██╗██╔══██╗██║████╗  ██║██╔════╝ ██╔══██╗████╗  ██║   "
	display as text "		███████╗███████║███████║██████╔╝██║██╔██╗ ██║██║  ███╗███████║██╔██╗ ██║   "
	display as text "		╚════██║██╔══██║██╔══██║██╔══██╗██║██║╚██╗██║██║   ██║██╔══██║██║╚██╗██║   "
	display as text "		███████║██║  ██║██║  ██║██║  ██║██║██║ ╚████║╚██████╔╝██║  ██║██║ ╚████║"
	display as text "		╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝"
    display as text "                                            .::--::.                             "               
    display as text "                                    *@@@@@@@@@@@@@@@@@@@@@@+                      "              
    display as text "                               +@@@@@@#=.    .@@@@@*   :+%@@@@@%=                  "             
    display as text "                           .@@@@@*          .@@@@@@@@@%      .#@@@@%                "            
    display as text "                        .%@@@#              @@@@@@@@@@@@@*       .%@@@#              "           
    display as text "                      =@@@#                #@@@@@@@@@@@@@@@@.       .%@@@:            "          
    display as text "                    *@@@:                 =@@@@@@@@@@@@@@@@@@@.        +@@@-           "         
    display as text "                  =@@@:                 =#@@@@@@@@@@@@@@@@@@@@@@.        =@@@.          "        
    display as text "                 @@@-              .@@@@*%@@@@@@@@@@@@@@@@@@@@@@@%         *@@%          "       
    display as text "               =@@%             +@@@:    @@@@@@@@@@@@@@@@@@@@@@@@@@-         @@@:         "      
    display as text "              #@@-           .@@@=      #@@@@@@@@@@@@@@=+%@@@@@@@@@@%         +@@+         "     
    display as text "             @@@           =@@@.        @@@@@@@@@@@@@@@@     *@@@@@@@@         :@@#         "    
    display as text "            %@@          :@@@=         +@@@@@@@@@@@@@@@@        *@@@@@@         :@@#         "   
    display as text "           %@@          @@@@           @@@@@@@@@@@@@@@@@*         +@@@@@         .@@*         "  
    display as text "          *@@.        =@@@%           .@@@@@@@@@@@@@@@@@@           #@@@@         -@@:         " 
    display as text "         .@@=        #@@@@            %@@@@@@@@@@@@@@@@@@.           .@@@@         %@@          "
    display as text "         %@@        @@@@@             @@@@@@@@@@@@@@@@@@@#             @@@-         @@*         "
    display as text "        :@@-       @@@@@=            :@@@@@@@@@@@@@@@@@@@@              @@@         #@@         "
    display as text "        #@@       #@@@@@             %@@@@@@@-    =@@@@@@@.             -@@:         @@:        "
    display as text "        @@*      -@@@@@@            *@@@@@-          *@@@@@-             %@*         @@%        "
    display as text "        @@-      @@@@@@#          @@@@@@@              @@@@@@+           :@@         %@@        "
    display as text "       .@@:     #@@@@@@%       .@@@@@@@@:              *@@@@@@@#          @@         +@@        "
    display as text "       :@@:    .@@@@@@@@     :@@@@@@@@@@               :@@@@@@@@@%        %@         =@@        "
    display as text "       .@@:    *@@@@@@@@   -@@@@@@@@@@@@-              #@@@@@@@@@@@%      %@         +@@        "
    display as text "        @@=    @@@@@@@@@*:@@@@@@@@@@@@@@@             :@@@@@@@@@@@@@@@    @%         %@@        "
    display as text "        @@#   :@@@@@@@@@@@@@@@@@@@@@@@@@@@+          @@@@@@@@@@@@@@@@@@@ :@=         @@@        "
    display as text "        #@@   +@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*=..=*@@@@@@@@@@@@@@@@@@@@@@@@          @@-        "
    display as text "        .@@=  #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:        #@@         "
    display as text "         #@@  %@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%       @@*         "
    display as text "          @@+ %@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*:  -#@@@@@@@@@@@@@@@@@@@@@@@@@@@=    @@@          "
    display as text "          +@@:%@@@@@@@@@@@@@@@@@@@@@@@@@*              %@@@@@@@@@@@@@@@@@@@@@@@#  =@@.          "
    display as text "           #@@%@@@@@@@@@@@@@@@@@@@*-                       .=%@@@@@@@@@@@@@@@@@@#:@@+           "
    display as text "            %@@@@@@@@@@@@@@@@                                 =@@@@@@@@@@@@@@@@@@@@*            "
    display as text "             %@@=..         %@%                             =@@@@@@@@@@@@@@@@@@@@@*             "
    display as text "              *@@+            #@@=                       .%@@@@@@@@@@@@@@@@@# *@@+              "
    display as text "               -@@@              @@@%=               .#@@@@@@@@@@@@@@@@@@=   @@@.               "
    display as text "                 %@@*               *@@@@@@@%%%@@@@@@@@@@@@@@@@@@@@@%+     #@@#                 "
    display as text "                  .@@@=                 -@@@@@@@@@@@@@@@@@@@@@@%:        *@@@                   "
    display as text "                    -@@@+                       .::---:.               #@@@.                    "
    display as text "                      -@@@@.                                        :@@@@                       "
    display as text "                         #@@@%-                                  -@@@@*                         "
    display as text "                           .#@@@@#:                          -%@@@@*                            "
    display as text "                               :@@@@@@@%=              =%@@@@@@%.                               "
    display as text "                                    =#@@@@@@@@@@@@@@@@@@@@*-                                    "
    // Nếu không chọn biến, mặc định lấy tất cả các biến
    if "`varlist'" == "" {
        local varlist : varlist _all
    }

    // Thiết lập số chữ số sau dấu thập phân, mặc định là 1
    if missing(`digit') {
        local digit 1
    }

    di as text "{hline 70}"
    di as text _col(3) "Đặc điểm" _col(35) "Tần số" _col(55) "Tỉ lệ %"
    di as text "{hline 70}"

    foreach var of local varlist {
        local vlab : variable label `var'
        local has_label = "`vlab'" != ""

        // Kiểm tra nếu biến là kiểu string (biến định tính)
        ds `var', has(type string)
        if _rc == 0 {
            continue
        }

        // Kiểm tra nếu biến có giá trị nhãn (biến định tính)
        ds `var', has(vallabel)
        if _rc == 0 {
            quietly count if !missing(`var')
            local N = r(N)
            if `N' == 0 {
                if `has_label' {
                    di as text "`vlab'"
                    di as text _col(3) "(Tất cả missing)"
                }
                else {
                    di as text _col(3) "(`var': Tất cả missing)"
                }
                continue
            }

            if `has_label' di as text "`vlab'"

            quietly levelsof `var', local(all_values)
            foreach val of local all_values {
                quietly count if `var' == `val'
                local f = r(N)
                local vl : label (`var') `val'
                local p = string(100 * `f'/`N', "%9.`digit'f")
                di as text _col(3) "`vl'" _col(35) %6.0f `f' _col(55) "`p'"
            }

        }
        else {
            // Kiểm tra nếu biến là kiểu double (biến định lượng)
            ds `var', has(type double)
            if _rc == 0 {
                quietly summarize `var'
                local mn = string(r(mean), "%9.`digit'f")
                local sd = string(r(sd), "%9.`digit'f")

                if `has_label' {
                    di as text "`vlab'✇"
                    di as text _col(40) "`mn' ± `sd'"
                }
                else {
                    di as text "`var': " _col(40) "`mn' ± `sd'"
                }
                continue
            }

            // Nếu không phải kiểu double, kiểm tra số lượng giá trị khác nhau
            quietly levelsof `var' if !missing(`var'), local(distvals)
            local n_distinct : word count `distvals'

            if `n_distinct' <= 15 {
                quietly count if !missing(`var')
                local N = r(N)
                if `N' == 0 {
                    if `has_label' {
                        di as text "`vlab'"
                        di as text _col(3) "(Tất cả missing)"
                    }
                    else {
                        di as text _col(3) "(`var': Tất cả missing)"
                    }
                    continue
                }

                if `has_label' di as text "`vlab'"

                foreach val of local distvals {
                    quietly count if `var' == `val'
                    local f = r(N)
                    local vl : label (`var') `val'
                    if "`vl'" == "" {
                        local vl "`val'"
                    }
                    local p = string(100 * `f'/`N', "%9.`digit'f")
                    di as text _col(3) "`vl'" _col(35) %6.0f `f' _col(55) "`p'"
                }
            }
            else {
                quietly summarize `var'
                local mn = string(r(mean), "%9.`digit'f")
                local sd = string(r(sd), "%9.`digit'f")

                if `has_label' {
                    di as text "`vlab'✇"
                    di as text _col(40) "`mn' ± `sd'"
                }
                else {
                    di as text "`var': " _col(40) "`mn' ± `sd'"
                }
            }
        }
    }
    di as text "{hline 70}"
    di as text "Ghi chú:'✇' là biến định lượng với giá trị trung bình ± độ lệch chuẩn."
end

