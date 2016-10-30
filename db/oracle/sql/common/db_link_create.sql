drop database link howbuy_trade;



create database link howbuy_trade
connect to LPT8_XM128_DEAL identified by howbuy_qa_qwerVBNM
using '(DESCRIPTION =
(ADDRESS_LIST =
(ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.220.172)(PORT =1521))
)
(CONNECT_DATA =
(SERVICE_NAME = howbuy)
)
)';
