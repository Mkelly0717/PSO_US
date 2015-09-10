############################################################
 ## In order to run this program run it from the direcoty  #
 ## with the csv files in it and pipe the putput to a file.#
 ## nawk ./priority_compare.awk  *.csv                     #
 ###########################################################
 BEGIN{ OFS="|"
        FS="|" 
        ORS="\n"
 }
 ###########################################################
 ## Begin Reading the files.                              ##
 ###########################################################
 {

     if (NR == 1) { 
         print $1, $2, $7, $8, $13, $14, $15 "\r"
         getline 
     } 
     item = $1; priority=$14; transleadtime=$15
     gsub ("^0*", "", item); gsub ("-", "", item); gsub (" ", "", item)
     if ( item =="4001AI" ) {
          source=$8; source_zip=$13
          dest=$2  ; dest_zip=$7
     }
     else {
           source=$2; source_zip=$7
           dest=$8  ; dest_zip=$13
     }
     print item, source,source_zip,dest,dest_zip,priority,transleadtime "\r"
 }
