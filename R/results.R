#' Result table
#' 
#' Tabulate the results of a peptide microarray analysis.
#' 
#' @param peptideSet A \code{peptideSet} object.
#' @param calls A \code{matrix}, as returned by the \code{makeCalls} function.
#' @param long A \code{boolean}. If set to TRUE, the result table will have one
#' row per peptide/clade. If FALSE, one row per peptide and all clades are 
#' listed together.
#' 
#' @details
#' The peptideSet should be the one used in the function call to \code{makeCalls}
#' that generated the calls used. They should have identical peptides.
#'
#' @return A \code{data.frame} with the peptides and some information from the 
#' \code{peptideSet} as well as the frequency of binding for each group of the 
#' calls.
#' 
#' @export
#'
restab <- function(peptideSet, calls, long = FALSE){
  pep <- as.data.frame(ranges(peptideSet))
  if(long){
    ssc <- strsplit(pep$clade, ",")
    nrep <- sapply(ssc, length)
    uclade <- unlist(ssc)
    pep <- pep[rep(1:nrow(pep), nrep),]
    pep$clade <- uclade
  }
  cn <- c("names", "space", "start", "end", "width", "clade")
  pep <- pep[, cn]
  calls <- data.frame(calls)
  calls$names <- rownames(calls)
  restab <- merge(pep, calls, by = "names")
  restab <- restab[order(restab$start),]
  return(restab)
}