CREATE OR REPLACE VIEW CUSTOMER_WALLET AS
SELECT CUSTOMER_ID, WALLET_BALANCE(CUSTOMER_ID, 'CUSTOMER') BALANCE
FROM CUSTOMER;

CREATE OR REPLACE VIEW SELLER_WALLET AS
SELECT SELLER_ID, WALLET_BALANCE(SELLER_ID, 'SELLER') BALANCE
FROM SELLER;