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
         print $1, $2, $7, $8, $13, $14, $15
         getline 
     } 
########     print $0  >> file_name
     if (NR <= 20 ) {
         item = $1; priority=$14; transleadtime=$15
         gsub ("^0*", "", item);
         gsub ("-", "", item);
         gsub (" ", "", item);
         if ( item ="4001AI" ) {
             source=$8; source_zip=$13
             dest=$2  ; dest_zip=$7
         }
         else {
             source=$2; source_zip=$7
             dest=$8  ; dest_zip=$13
         }
         print item,source,source_zip,dest,dest_zip,priority,transleadtime 
     }
 }



###########################################################
# Sample Input records for this file
###########################################################
#ITEM SOURCE SOURCE_ZIP DEST DEST_ZIP PRIORITY TRANSLEADTIME
#04055-RU PLUS US26 35055 5000384458 62025 1 1440
#04055-RU PLUS US26 35055 6100364288 61832 1 2880
#04055-RU PLUS US26 35055 4000124439 46158 1 1440
#04055-RU PLUS US26 35055 4000082134 37040 2 1
#04001-AI US07 72830 6100634852 72830 1 1
#04001-AI US09 72712 6100634932 72712 1 1
#04001-AI US35 38652 6100537814 38652 1 1
#04001-AI US83 75160 6100793859 75160 1 1
#04055-RU PLUS US83 75160 4000139519 75082 3 1
#04001-AI US75 92307 4000057758 92307 1 1
#04001-AI US8Z 53110 4000149889 53558 1 1
#04001-AI US8Z 53110 3000007913 53085 1 1
#04001-AI US8Z 53110 4000165853 53144 1 1
#04001-AI US8Z 53110 6100870855 53215 1 1
#04001-AI US8Z 53110 6100209429 53946 1 1
#04055-RU PLUS US8Z 53110 6100215234 53225 1 1
#04055-RU PLUS US8Z 53110 6100115093 53073 1 1
#04001-AI US8Z 53110 4000162388 53120 1 1
#04001-AI US8Z 53110 4000181837 53083 1 1
