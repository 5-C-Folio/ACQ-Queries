

select 
substr(ord.Z68_REC_KEY,0,9),
ord.Z68_ORDER_Type ,
rr.z13key
,


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
concat('AC' ,ord.Z68_VENDOR_CODE) as vendorCode,
bud.Z76_NAME,
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
-- Umass and Smith will use the same export critera as Amherst. To run the Umass query, change the AMH50.Z68 and AMH50.Z103 to UMA50.Z68 and UMA.Z103.
-- you will also need to change the org code prefix to UM or SC
from AMH50.Z68 ord
LEFT join 
(
    select brief.Z13_REC_KEY as z13key , brief.Z13_TITLE,brief.Z13_author as author ,substr(lkr.Z103_REC_KEY,6,9) as ADM_N from 
    AMH50.Z103 lkr
    inner join  
    FCL01.z13 brief
    on SUBSTR(brief.Z13_REC_KEY, 0,9) = substr(lkr.Z103_REC_KEY_1,6,9)
    and lkr.Z103_LKR_TYPE='ADM'
    and substr(lkr.Z103_REC_KEY_1,1,5)='FCL01'
) rr
on substr(ord.Z68_REC_KEY ,0, 9) = rr.ADM_N
left join AMH50.Z601 pol
on substr(ord.Z68_REC_KEY ,0, 9) =  substr(pol.Z601_REC_KEY_3 ,0, 9)
left join AMH50.Z76 bud
on 
substr(pol.Z601_REC_KEY ,0, 50) = bud.Z76_BUDGET_NUMBER
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
and ord.Z68_OPEN_DATE > 20190701);
