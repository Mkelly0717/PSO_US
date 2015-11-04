WITH tpm_locs 
AS 
(select d.skuloc LOC, sum(TOTFCST) QTY
from dfutoskufcst d, item i
where d.item=i.item
and dmdgroup='TPM'
group by i.u_stock, d.skuloc
ORDER BY D.SKULOC
), col_locs 
as 
( SELECT d.skuloc , sum(d.totfcst)totfcst , fc.plant plant
FROM DFUTOSKUFCST d, udt_fixed_coll fc
WHERE d.DMDGROUP='COL'
  and d.skuloc=fc.loc
group by d.skuloc
) SELECT * 
from tmp_locs tl, col_locs cl
where tl.loc=cl.plant;


FROM DFUTOSKU D;