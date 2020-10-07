select 
substr(ord.Z68_REC_KEY,0,9),
ord.Z68_ORDER_Type ,


 ord.Z68_Order_NUMBER,
 ord.Z68_ORDER_NUMBER_1,
 ord.Z68_ORDER_NUMBER_2,
ord.Z68_ORDER_GROUP,
ord.Z68_LIBRARY_NOTE,
ord.z68_e_note,
ord.Z68_OPEN_DATE, 
ord.z68_ORDER_DATE,
ord.Z68_ORDER_STATUS,
ord.z68_invoice_status,
ord.Z68_ORDER_STATUS ,
ord.Z68_ORDER_STATUS_DATE_X,
ord.z68_method_of_aquisition,
concat('HC',ord.Z68_VENDOR_CODE),
ord.z68_vendor_note,
ord.Z68_NO_UNITS,
ord.Z68_UNIT_PRICE,

ord.Z68_TARGeT_TEXT,
ord.z68_subscription_date_from,
ord.z68_subscription_date_to,
ord.Z68_SUBSCRIPTION_RENEW_DATE,
rr.Z13_TITLE,
rr.author,
ord.z68_isbn,
ord.z68_material_type,
ord.z68_vendor_reference_no
from HAM50.Z68 ord
LEFT join 
(
    select brief.Z13_TITLE,brief.Z13_author as author ,substr(lkr.Z103_REC_KEY,6,9) as ADM_N from 
    HAM50.Z103 lkr
    inner join  
    FCL01.z13 brief
    on SUBSTR(brief.Z13_REC_KEY, 0,9) = substr(lkr.Z103_REC_KEY_1,6,9)
    and lkr.Z103_LKR_TYPE='ADM'
    and substr(lkr.Z103_REC_KEY_1,1,5)='FCL01'
) rr
on substr(ord.Z68_REC_KEY ,0, 9) = rr.ADM_N

WHERE 
 
ord.Z68_ORDER_STATUS != 'CLS'
and(
ord.Z68_REC_KEY not in (
-- restriction 1
SELECT ord1.Z68_REC_KEY FROM
    HAM50.Z68 ord1
    inner join (
    select Z00R_DOC_NUMBER, Z00R_TEXT, substr(Z103_REC_KEY,6,9) as ADM_N from HAM50.Z103, FCL01.Z00R
where Z00R_DOC_NUMBER=substr(Z103_REC_KEY_1,6,9)
and Z103_LKR_TYPE='ADM'
and substr(Z103_REC_KEY_1,1,5)='FCL01'
and substr(Z00R_FIELD_CODE,0,3) ='FMT'
) rr
    on substr(ord1.Z68_REC_KEY ,0, 9) = rr.ADM_N
 left join(
 select Z00R_DOC_NUMBER, Z00R_TEXT, substr(Z103_REC_KEY,6,9) as ADM_N from HAM50.Z103, FCL01.Z00R
where Z00R_DOC_NUMBER=substr(Z103_REC_KEY_1,6,9)
and Z103_LKR_TYPE='ADM'
and substr(Z103_REC_KEY_1,1,5)='FCL01'
and substr(Z00R_FIELD_CODE,0,3) ='STA') sta
on substr(ord1.Z68_REC_KEY ,0, 9) = sta.ADM_N
    WHERE
    rr.z00r_text like 'BK%'
    and substr(ord1.z68_material_type,0,1 )= 'M'
    and ord1.z68_order_type= 'M'
    and  ord1.Z68_OPEN_DATE < 20170630
    and sta.z00r_text is NULL
    and ord1.Z68_ORDER_STATUS IN ('CLS','LC', 'VC')
    )
  --restriction2
 OR  ord.Z68_REC_KEY not in ( 
 SELECT ord1.Z68_REC_KEY FROM
    HAM50.Z68 ord1
    inner join (
    select Z00R_DOC_NUMBER, Z00R_TEXT, substr(Z103_REC_KEY,6,9) as ADM_N from HAM50.Z103, FCL01.Z00R
where Z00R_DOC_NUMBER=substr(Z103_REC_KEY_1,6,9)
and Z103_LKR_TYPE='ADM'
and substr(Z103_REC_KEY_1,1,5)='FCL01'
and substr(Z00R_FIELD_CODE,0,3) ='FMT'
) rr
    on substr(ord1.Z68_REC_KEY ,0, 9) = rr.ADM_N
 left join(
 select Z00R_DOC_NUMBER, Z00R_TEXT, substr(Z103_REC_KEY,6,9) as ADM_N from HAM50.Z103, FCL01.Z00R
where Z00R_DOC_NUMBER=substr(Z103_REC_KEY_1,6,9)
and Z103_LKR_TYPE='ADM'
and substr(Z103_REC_KEY_1,1,5)='FCL01'
and substr(Z00R_FIELD_CODE,0,3) ='STA') sta
on substr(ord1.Z68_REC_KEY ,0, 9) = sta.ADM_N
    WHERE
    rr.z00r_text like 'MU%'
    and substr(ord1.z68_material_type,0,1 )= 'A'
    and ord1.z68_order_type= 'M'
    and  ord1.Z68_OPEN_DATE < 20170630
    and sta.z00r_text is NULL
    and ord1.Z68_ORDER_STATUS IN ('CLS','LC', 'VC')
    )
OR    
--restriction 3
ord.Z68_REC_KEY not in ( 
 SELECT ord1.Z68_REC_KEY FROM
    HAM50.Z68 ord1
    inner join (
    select Z00R_DOC_NUMBER, Z00R_TEXT, substr(Z103_REC_KEY,6,9) as ADM_N from HAM50.Z103, FCL01.Z00R
where Z00R_DOC_NUMBER=substr(Z103_REC_KEY_1,6,9)
and Z103_LKR_TYPE='ADM'
and substr(Z103_REC_KEY_1,1,5)='FCL01'
and substr(Z00R_FIELD_CODE,0,3) ='FMT'
) rr
    on substr(ord1.Z68_REC_KEY ,0, 9) = rr.ADM_N
 left join(
 select Z00R_DOC_NUMBER, Z00R_TEXT, substr(Z103_REC_KEY,6,9) as ADM_N from HAM50.Z103, FCL01.Z00R
where Z00R_DOC_NUMBER=substr(Z103_REC_KEY_1,6,9)
and Z103_LKR_TYPE='ADM'
and substr(Z103_REC_KEY_1,1,5)='FCL01'
and substr(Z00R_FIELD_CODE,0,3) ='STA') sta
on substr(ord1.Z68_REC_KEY ,0, 9) = sta.ADM_N
    WHERE
    rr.z00r_text like 'VM%'
    and substr(ord1.z68_material_type,0,1 )= 'V'
    and ord1.z68_order_type= 'M'
    and  ord1.Z68_OPEN_DATE < 20170630
    and sta.z00r_text is NULL
    and ord1.Z68_ORDER_STATUS IN ('CLS','LC', 'VC')
    ))
