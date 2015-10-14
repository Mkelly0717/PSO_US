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
         print $1, $2, $6, $7, $12, $13, $14 "\r"
         getline 
     } 
     item = $1; priority=$12; transleadtime=$13, equipment_type=$14
     gsub ("^0*", "", item); gsub ("-", "", item); gsub (" ", "", item)
     if ( item =="4001AI" ) {
          source=$7; source_zip=$13
          dest=$2  ; dest_zip=$6
     }
     else {
           source=$2; source_zip=$6
           dest=$7  ; dest_zip=$11
     }
     print item, source,source_zip,dest,dest_zip,priority,transleadtime,
           equipment_type "\r"
 }
