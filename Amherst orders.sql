select 
ord.Z68_ORDER_NUMBER,
brief.z13_title,
brief.z13_isbn_issn,
brief.z13_author,
brief.Z13_year,
ord.z68_open_date,
ord.z68_ORDER_STATUS,
ord.z68_order_type,
rr.z00r_text as bibFMT,
ord.z68_material_type,
replace(concat('AC',ord.z68_vendor_code), ' ', ''),
ord.z68_unit_type,
ord.z68_no_units,
ord.z68_unit_price,
ord.z68_total_price,
ord.z68_library_note,
ord.z68_vendor_note



from 
AMH50.Z68 ord
    inner join (
    select Z00R_DOC_NUMBER, Z00R_TEXT, substr(Z103_REC_KEY,6,9) as ADM_N from AMH50.Z103, FCL01.Z00R
    where Z00R_DOC_NUMBER=substr(Z103_REC_KEY_1,6,9)
    and Z103_LKR_TYPE='ADM'
    and substr(Z103_REC_KEY_1,1,5)='FCL01'
    and substr(Z00R_FIELD_CODE,0,3) ='FMT'
) rr
on substr(ord.Z68_REC_KEY ,0, 9) = rr.ADM_N
inner join FCL01.Z13 brief
on rr.adm_n = brief.z13_rec_key
WHERE 
ord.Z68_ORDER_STATUS != 'CLS'
and(
ord.Z68_REC_KEY not in (
-- restriction 1
SELECT ord1.Z68_REC_KEY FROM
    AMH50.Z68 ord1
    inner join (
    select Z00R_DOC_NUMBER, Z00R_TEXT, substr(Z103_REC_KEY,6,9) as ADM_N from AMH50.Z103, FCL01.Z00R
where Z00R_DOC_NUMBER=substr(Z103_REC_KEY_1,6,9)
and Z103_LKR_TYPE='ADM'
and substr(Z103_REC_KEY_1,1,5)='FCL01'
and substr(Z00R_FIELD_CODE,0,3) ='FMT'
) rr
    on substr(ord1.Z68_REC_KEY ,0, 9) = rr.ADM_N
    WHERE
    rr.z00r_text like 'BK%'
    and substr(ord1.z68_material_type,0,1 )= 'M'
    and ord1.z68_order_type= 'M'
    and  ord1.Z68_OPEN_DATE < 20200630
    and ord1.Z68_ORDER_STATUS IN ('LC', 'VC'))
OR
--restrition 2 
ord.Z68_REC_KEY not in (
    SELECT ord1.Z68_REC_KEY FROM
    AMH50.Z68 ord1
    inner join (
    select Z00R_DOC_NUMBER, Z00R_TEXT, substr(Z103_REC_KEY,6,9) as ADM_N from AMH50.Z103, FCL01.Z00R
where Z00R_DOC_NUMBER=substr(Z103_REC_KEY_1,6,9)
and Z103_LKR_TYPE='ADM'
and substr(Z103_REC_KEY_1,1,5)='FCL01'
and substr(Z00R_FIELD_CODE,0,3) ='FMT'
) rr
    on substr(ord1.Z68_REC_KEY ,0, 9) = rr.ADM_N
    WHERE
    rr.z00r_text like 'VM%'
    and substr(ord1.z68_material_type,0,1 )= 'V'
    and ord1.z68_order_type= 'M'
    and  ord1.Z68_OPEN_DATE < 20200630
    and ord1.Z68_ORDER_STATUS  = 'VC')
    OR
--restriction 3 
    ord.Z68_REC_KEY not in (
    SELECT ord1.Z68_REC_KEY FROM
    AMH50.Z68 ord1
    inner join (
    select Z00R_DOC_NUMBER, Z00R_TEXT, substr(Z103_REC_KEY,6,9) as ADM_N from AMH50.Z103, FCL01.Z00R
where Z00R_DOC_NUMBER=substr(Z103_REC_KEY_1,6,9)
and Z103_LKR_TYPE='ADM'
and substr(Z103_REC_KEY_1,1,5)='FCL01'
and substr(Z00R_FIELD_CODE,0,3) ='FMT'
) rr
    on substr(ord1.Z68_REC_KEY ,0, 9) = rr.ADM_N
    WHERE
    rr.z00r_text like 'BK%'
    and substr(ord1.z68_material_type,0,1 )= 'M'
    and ord1.z68_order_type= 'M'
    and  ord1.Z68_OPEN_DATE < 20200101
    and ord1.Z68_ORDER_STATUS  = 'SV')
    OR
--restriction 4
 ord.Z68_REC_KEY not in (
    SELECT ord1.Z68_REC_KEY FROM
    AMH50.Z68 ord1
    inner join (
    select Z00R_DOC_NUMBER, Z00R_TEXT, substr(Z103_REC_KEY,6,9) as ADM_N from AMH50.Z103, FCL01.Z00R
where Z00R_DOC_NUMBER=substr(Z103_REC_KEY_1,6,9)
and Z103_LKR_TYPE='ADM'
and substr(Z103_REC_KEY_1,1,5)='FCL01'
and substr(Z00R_FIELD_CODE,0,3) ='FMT'
) rr
    on substr(ord1.Z68_REC_KEY ,0, 9) = rr.ADM_N
    WHERE
    rr.z00r_text like 'BK%'
    and substr(ord1.z68_material_type,0,1 )= 'V'
    and ord1.z68_order_type= 'M'
    and  ord1.Z68_OPEN_DATE < 20200101
    and ord1.Z68_ORDER_STATUS  = 'SV')
 --restriction 5
 OR
 ord.Z68_REC_KEY not in (
    SELECT ord1.Z68_REC_KEY FROM
    AMH50.Z68 ord1
    inner join (
    select Z00R_DOC_NUMBER, Z00R_TEXT, substr(Z103_REC_KEY,6,9) as ADM_N from AMH50.Z103, FCL01.Z00R
where Z00R_DOC_NUMBER=substr(Z103_REC_KEY_1,6,9)
and Z103_LKR_TYPE='ADM'
and substr(Z103_REC_KEY_1,1,5)='FCL01'
and substr(Z00R_FIELD_CODE,0,3) ='FMT'
) rr
    on substr(ord1.Z68_REC_KEY ,0, 9) = rr.ADM_N
    WHERE
    rr.z00r_text like 'MU%'
    and substr(ord1.z68_material_type,0,1 )= 'A'
    and ord1.z68_order_type= 'M'
    and  ord1.Z68_OPEN_DATE < 20200630
    and ord1.Z68_ORDER_STATUS  = 'LC')
    or
--restriction 6
ord.Z68_REC_KEY not in (
    SELECT ord1.Z68_REC_KEY FROM
    AMH50.Z68 ord1
    inner join (
    select Z00R_DOC_NUMBER, Z00R_TEXT, substr(Z103_REC_KEY,6,9) as ADM_N from AMH50.Z103, FCL01.Z00R
where Z00R_DOC_NUMBER=substr(Z103_REC_KEY_1,6,9)
and Z103_LKR_TYPE='ADM'
and substr(Z103_REC_KEY_1,1,5)='FCL01'
and substr(Z00R_FIELD_CODE,0,3) ='FMT'
) rr
    on substr(ord1.Z68_REC_KEY ,0, 9) = rr.ADM_N
    WHERE
    rr.z00r_text like 'MU%'
    and substr(ord1.z68_material_type,0,1 )= 'A'
    and ord1.z68_order_type= 'M'
    and  ord1.Z68_OPEN_DATE < 20200101
    and ord1.Z68_ORDER_STATUS  = 'SV')
    )
    
INTERSECT

select 
ord.Z68_ORDER_NUMBER,
brief.z13_title,
brief.z13_isbn_issn,
brief.z13_author,
brief.Z13_year,
ord.z68_open_date,
ord.z68_ORDER_STATUS,
ord.z68_order_type,
rr.z00r_text as bibFMT,
ord.z68_material_type,
replace(concat('AC',ord.z68_vendor_code), ' ', ''),
ord.z68_unit_type,
ord.z68_no_units,
ord.z68_unit_price,
ord.z68_total_price,
ord.z68_library_note,
ord.z68_vendor_note



from 
AMH50.Z68 ord
    inner join (
    select Z00R_DOC_NUMBER, Z00R_TEXT, substr(Z103_REC_KEY,6,9) as ADM_N from AMH50.Z103, FCL01.Z00R
    where Z00R_DOC_NUMBER=substr(Z103_REC_KEY_1,6,9)
    and Z103_LKR_TYPE='ADM'
    and substr(Z103_REC_KEY_1,1,5)='FCL01'
    and substr(Z00R_FIELD_CODE,0,3) ='FMT'
) rr
on substr(ord.Z68_REC_KEY ,0, 9) = rr.ADM_N
inner join FCL01.Z13 brief
on rr.adm_n = brief.z13_rec_key
WHERE
(ord.Z68_ORDER_TYPE = 'S'
and ord.Z68_ORDER_STATUS = 'SV'
)
OR
(ord.Z68_ORDER_TYPE = 'O'
and ord.Z68_ORDER_STATUS = 'SV')
OR
(ord.Z68_ORDER_TYPE = 'M'
and ord.Z68_ORDER_STATUS = 'SV'
and ord.Z68_OPEN_DATE > 20190701)
    
