Select * from MHC50.Z68 ord
WHERE
ord.Z68_ORDER_STATUS = 'SV'
OR
(
ord.Z68_ORDER_TYPE in ('O', 'S')
and
ord.Z68_ORDER_STATUS in ('LC', 'VC')
and
ord.Z68_ORDER_STATUS_DATE_X >= 20180701
)
