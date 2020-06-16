
check_log <- readLines(list.files(".", pattern = "check\\.log", recursive = TRUE)[1])
if (grepl("WARNING", check_log[length(check_log)]) || 
    grepl("ERROR", check_log[length(check_log)]) ||
    grepl("NOTE", check_log[length(check_log)]) ) {
  stop(check_log[length(check_log)])
}


