select 
ord.Z68_REC_KEY,
CASE
when ord.Z68_ORDER_Type = 'M' then 'One time'
when ord.Z68_Order_type = 'S' then 'Ongoing'
else ord.Z68_ORDER_TYPE
end Order_Type,
 ord.Z68_Order_NUMBER,
 ord.Z68_ORDER_NUMBER_1,
 ord.Z68_ORDER_NUMBER_2,
ord.Z68_ORDER_GROUP,
ord.Z68_LIBRARY_NOTE,
ord.Z68_OPEN_DATE, -- we should probably pick open or order
ord.z68_ORDER_DATE,
case
when ord.Z68_ORDER_STATUS  in ('SV', 'O') then 'open'
when ord.Z68_ORDER_STATUS in ('LC', 'VC') then 'closed'
else ord.Z68_ORDER_STATUS 
end as workflow_status,
case 
when ord.Z68_ORDER_STATUS = 'LC' then 'Cancelled'
when ord.Z68_ORDER_STATUS = 'VC' then 'Library Cancelled'
end  as reason_for_closed,
ord.Z68_ORDER_STATUS_DATE_X,
ord.z68_method_of_aquisition,
concat('AC',ord.Z68_VENDOR_CODE),
ord.z68_vendor_note,
ord.Z68_NO_UNITS,
ord.Z68_UNIT_PRICE,
ord.Z68_TOTAL_PRICE,
ord.Z68_TARGeT_TEXT,
ord.z68_subscription_date_from,
ord.z68_subscription_date_to,
ord.Z68_SUBSCRIPTION_RENEW_DATE,
rr.Z13_TITLE
from AMH50.Z68 ord
inner join 
(
    select brief.Z13_TITLE, substr(lkr.Z103_REC_KEY,6,9) as ADM_N from 
    AMH50.Z103 lkr
    inner join  
    FCL01.z13 brief
    on SUBSTR(brief.Z13_REC_KEY, 0,9) = substr(lkr.Z103_REC_KEY_1,6,9)
    and lkr.Z103_LKR_TYPE='ADM'
    and substr(lkr.Z103_REC_KEY_1,1,5)='FCL01'
) rr
on substr(ord.Z68_REC_KEY ,0, 9) = rr.ADM_N
