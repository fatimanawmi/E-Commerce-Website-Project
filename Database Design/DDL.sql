--DROP TABLE CUSTOMER;

CREATE TABLE CUSTOMER(
CUSTOMER_ID NUMBER CONSTRAINT CUSTOMER_ID_PK PRIMARY KEY,
FIRST_NAME VARCHAR2(20) NOT NULL,
LAST_NAME VARCHAR2(20) NOT NULL,
APARTMENT_NUMBER VARCHAR2(10),
BUILDING_NUMBER VARCHAR2(10),
ROAD VARCHAR2(30),
AREA VARCHAR2(30) NOT NULL,
CITY VARCHAR2(30) NOT NULL,
PHONE_NUMBER VARCHAR2(14) NOT NULL,
DOB DATE NOT NULL,
EMAIL_ID VARCHAR2(40) NOT NULL UNIQUE,
PICTURE BLOB,
LOCATION VARCHAR2(50) NOT NULL,
PASSWORD VARCHAR2(50) NOT NULL
);


--DROP TABLE EMPLOYEE;

CREATE TABLE EMPLOYEE(
EMPLOYEE_ID NUMBER CONSTRAINT EMPLOYEE_PK PRIMARY KEY,
FIRST_NAME VARCHAR2(20) NOT NULL,
LAST_NAME VARCHAR2(20) NOT NULL,
SALARY NUMBER CONSTRAINT EMPLOYEE_SAL_MIN CHECK (SALARY >= 0) NOT NULL,
PHONE_NUMBER VARCHAR2(14) NOT NULL UNIQUE,
PASSWORD VARCHAR2(50) NOT NULL,
APARTMENT_NUMBER VARCHAR(10),
BUILDING_NUMBER VARCHAR2(10),
ROAD VARCHAR2(30),
AREA VARCHAR2(30) NOT NULL,
CITY VARCHAR2(30) NOT NULL,
PICTURE BLOB NOT NULL,
EMAIL_ID VARCHAR2(40) NOT NULL UNIQUE,
DOB DATE NOT NULL
);


--DROP TABLE DELIVERY_GUY;

CREATE TABLE DELIVERY_GUY(
EMPLOYEE_ID NUMBER CONSTRAINT DELIVERY_GUY_PK PRIMARY KEY,
CURRENT_LOCATION VARCHAR2(100),
CONSTRAINT DELIVERY_GUY_FK FOREIGN KEY(EMPLOYEE_ID) REFERENCES EMPLOYEE(EMPLOYEE_ID)
);


--DROP TABLE CUSTOMER_CARE_EMPLOYEE;

CREATE TABLE CUSTOMER_CARE_EMPLOYEE(
EMPLOYEE_ID NUMBER CONSTRAINT CUSTOMER_CARE_EMPLOYEE_PK PRIMARY KEY,
CONSTRAINT CUSTOMER_CARE_EMPLOYEE_FK FOREIGN KEY(EMPLOYEE_ID) REFERENCES EMPLOYEE(EMPLOYEE_ID)
);

--DROP TABLE ADMIN;

CREATE TABLE ADMIN(
EMPLOYEE_ID NUMBER CONSTRAINT ADMIN_PK PRIMARY KEY,
CONSTRAINT ADMIN_FK FOREIGN KEY(EMPLOYEE_ID) REFERENCES EMPLOYEE(EMPLOYEE_ID)
);

--DROP TABLE SELLER

CREATE TABLE SELLER(
SELLER_ID NUMBER CONSTRAINT SELLER_PK PRIMARY KEY,
NAME VARCHAR2(30) NOT NULL UNIQUE,
BUILDING_NUMBER VARCHAR2(10),
ROAD VARCHAR2(30),
AREA VARCHAR2(30) NOT NULL,
CITY VARCHAR2(30) NOT NULL,
EMAIL_ID VARCHAR2(40) NOT NULL UNIQUE,
LOGO BLOB,
WEBSITE VARCHAR2(50),
LOCATION VARCHAR2(50) NOT NULL,
PASSWORD VARCHAR2(50) NOT NULL
);


--DROP TABLE SELLER_PHONE_NUMBER;

CREATE TABLE SELLER_PHONE_NUMBER(
SELLER_ID NUMBER,
PHONE_NUMBER VARCHAR(14),
CONSTRAINT SELLER_PHONE_NUMBER_PK PRIMARY KEY(SELLER_ID , PHONE_NUMBER),
CONSTRAINT SELLER_PHONE_NUMBER_FK FOREIGN KEY(SELLER_ID) REFERENCES SELLER(SELLER_ID)
);


--DROP TABLE CUSTOMER_ORDER;

CREATE TABLE CUSTOMER_ORDER(
ORDER_ID NUMBER CONSTRAINT ORDER_PK PRIMARY KEY,
CUSTOMER_ID NUMBER NOT NULL,
ORDER_DATE DATE NOT NULL,
PAYMENT_METHOD VARCHAR2(20) NOT NULL,
CONSTRAINT ORDER_FK FOREIGN KEY(CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID)
);


--DROP TABLE SELLER_REVENUE;

CREATE TABLE SELLER_REVENUE(
ORDER_ID NUMBER,
SELLER_ID NUMBER,
AMOUNT NUMBER NOT NULL,
CONSTRAINT SELLER_REVENUE_PK PRIMARY KEY(ORDER_ID, SELLER_ID),
CONSTRAINT SELLER_REVENUE_FK1 FOREIGN KEY(ORDER_ID) REFERENCES CUSTOMER_ORDER(ORDER_ID),
CONSTRAINT SELLER_REVENUE_FK2 FOREIGN KEY(SELLER_ID) REFERENCES SELLER(SELLER_ID)
);


--DROP TABLE PURCHASE_ORDER;

CREATE TABLE PURCHASE_ORDER(
ORDER_ID NUMBER CONSTRAINT PURCHASE_ORDER_PK PRIMARY KEY,
DELIVERY_EMPLOYEE_ID NUMBER NOT NULL,
DELIVERED_DATE DATE,
DELIVERY_STATUS VARCHAR2(20) NOT NULL,
CONSTRAINT PURCHASE_ORDER_FK1 FOREIGN KEY(ORDER_ID) REFERENCES CUSTOMER_ORDER(ORDER_ID),
CONSTRAINT PURCHASE_ORDER_FK2 FOREIGN KEY(DELIVERY_EMPLOYEE_ID) REFERENCES DELIVERY_GUY(EMPLOYEE_ID)
);


--DROP TABLE RETURN_ORDER;

CREATE TABLE RETURN_ORDER(
ORDER_ID NUMBER CONSTRAINT RETURN_ORDER_PK PRIMARY KEY,
COMPLAINT_DES VARCHAR2(4000) NOT NULL,
CUSTOMER_CARE_EMPLOYEE_ID NUMBER NOT NULL,
RETURN_DATE DATE,
APPROVAL_STATUS VARCHAR2(20) NOT NULL,
CONSTRAINT RETURN_ORDER_FK1 FOREIGN KEY(CUSTOMER_CARE_EMPLOYEE_ID) REFERENCES CUSTOMER_CARE_EMPLOYEE(EMPLOYEE_ID),
CONSTRAINT RETURN_ORDER_FK2 FOREIGN KEY(ORDER_ID) REFERENCES CUSTOMER_ORDER(ORDER_ID)
);


--DROP TABLE CATEGORY

CREATE TABLE CATEGORY(
CATEGORY_ID NUMBER CONSTRAINT CATEGORY_PK PRIMARY KEY,
CATEGORY_NAME VARCHAR2(50) NOT NULL
);


--DROP TABLE PRODUCT;

CREATE TABLE PRODUCT(
PRODUCT_ID NUMBER,
SELLER_ID NUMBER,
NAME VARCHAR2(150) NOT NULL,
CATEGORY_ID NUMBER NOT NULL,
DESCRIPTION VARCHAR2(4000) NOT NULL,
EXPECTED_TIME_TO_DELIVER VARCHAR2(10) NOT NULL,
CONSTRAINT PRODUCT_PK PRIMARY KEY(PRODUCT_ID , SELLER_ID),
CONSTRAINT PRODUCT_FK1 FOREIGN KEY(SELLER_ID) REFERENCES SELLER(SELLER_ID),
CONSTRAINT PRODUCT_FK2 FOREIGN KEY(CATEGORY_ID) REFERENCES CATEGORY(CATEGORY_ID)
);


--DROP TABLE PRODUCT_PICTURE

CREATE TABLE PRODUCT_PICTURE(
PRODUCT_ID NUMBER,
SELLER_ID NUMBER,
PICTURE_NUMBER NUMBER,
PICTURE BLOB NOT NULL,
CONSTRAINT PRODUCT_PICTURE_PK PRIMARY KEY(PRODUCT_ID , SELLER_ID, PICTURE_NUMBER),
CONSTRAINT PRODUCT_PICTURE_FK1 FOREIGN KEY(PRODUCT_ID, SELLER_ID) REFERENCES PRODUCT(PRODUCT_ID, SELLER_ID),
CONSTRAINT PRODUCT_PICTURE_FK2 FOREIGN KEY(SELLER_ID) REFERENCES SELLER(SELLER_ID)
);


--DROP TABLE PRODUCT_UNIT

CREATE TABLE PRODUCT_UNIT(
PRODUCT_ID NUMBER,
SELLER_ID NUMBER,
ITEM_NUMBER NUMBER,
STATUS VARCHAR(50) NOT NULL,
CONSTRAINT PRODUCT_UNIT_PK PRIMARY KEY(PRODUCT_ID , SELLER_ID, ITEM_NUMBER),
CONSTRAINT PRODUCT_UNIT_FK1 FOREIGN KEY(PRODUCT_ID, SELLER_ID) REFERENCES PRODUCT(PRODUCT_ID, SELLER_ID),
CONSTRAINT PRODUCT_UNIT_FK2 FOREIGN KEY(SELLER_ID) REFERENCES SELLER(SELLER_ID)
);


--DROP TABLE PRODUCT_FEATURE

CREATE TABLE PRODUCT_FEATURE(
PRODUCT_ID NUMBER,
SELLER_ID NUMBER,
FEATURE_NUMBER NUMBER,
FEATURE_DESCRIPTION VARCHAR(4000) NOT NULL,
CONSTRAINT PRODUCT_FEATURE_PK PRIMARY KEY(PRODUCT_ID , SELLER_ID, FEATURE_NUMBER),
CONSTRAINT PRODUCT_FEATURE_FK1 FOREIGN KEY(PRODUCT_ID, SELLER_ID) REFERENCES PRODUCT(PRODUCT_ID, SELLER_ID),
CONSTRAINT PRODUCT_FEATURE_FK2 FOREIGN KEY(SELLER_ID) REFERENCES SELLER(SELLER_ID)
);


--DROP TABLE OFFER

CREATE TABLE OFFER(
PRODUCT_ID NUMBER,
SELLER_ID NUMBER,
OFFER_NUMBER NUMBER,
START_DATE DATE NOT NULL,
END_DATE DATE,
PERCENTAGE_DISCOUNT NUMBER NOT NULL,
MINIMUM_QUANTITY_PURCHASED NUMBER,
CONSTRAINT OFFER_PK PRIMARY KEY(PRODUCT_ID , SELLER_ID, OFFER_NUMBER),
CONSTRAINT OFFER_FK1 FOREIGN KEY(PRODUCT_ID, SELLER_ID) REFERENCES PRODUCT(PRODUCT_ID, SELLER_ID),
CONSTRAINT OFFER_FK2 FOREIGN KEY(SELLER_ID) REFERENCES SELLER(SELLER_ID)
);


--DROP TABLE ADVERTISEMENT

CREATE TABLE ADVERTISEMENT(
PRODUCT_ID NUMBER,
SELLER_ID NUMBER,
ADVERTISEMENT_NUMBER NUMBER,
START_DATE DATE NOT NULL,
END_DATE DATE NOT NULL,
COST_FOR_SELLER NUMBER NOT NULL,
PICTURE BLOB NOT NULL,
DISPLAY_PREFERENCE NUMBER NOT NULL,
CONSTRAINT ADVERTISEMENT_PK PRIMARY KEY(PRODUCT_ID , SELLER_ID, ADVERTISEMENT_NUMBER),
CONSTRAINT ADVERTISEMENT_FK1 FOREIGN KEY(PRODUCT_ID, SELLER_ID) REFERENCES PRODUCT(PRODUCT_ID, SELLER_ID),
CONSTRAINT ADVERTISEMENT_FK2 FOREIGN KEY(SELLER_ID) REFERENCES SELLER(SELLER_ID)
);


--DROP TABLE REVIEW

CREATE TABLE REVIEW(
PRODUCT_ID NUMBER,
SELLER_ID NUMBER,
CUSTOMER_ID NUMBER,
REVIEW_DATE DATE NOT NULL,
RATING NUMBER NOT NULL,
DESCRIPTION VARCHAR2(1200),
CONSTRAINT REVIEW_PK PRIMARY KEY(PRODUCT_ID , SELLER_ID, CUSTOMER_ID),
CONSTRAINT REVIEW_FK1 FOREIGN KEY(PRODUCT_ID, SELLER_ID) REFERENCES PRODUCT(PRODUCT_ID, SELLER_ID),
CONSTRAINT REVIEW_FK2 FOREIGN KEY(SELLER_ID) REFERENCES SELLER(SELLER_ID),
CONSTRAINT REVIEW_FK3 FOREIGN KEY(CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID)
);


--DROP TABLE CART_ITEM

CREATE TABLE CART_ITEM(
PRODUCT_ID NUMBER,
SELLER_ID NUMBER,
CUSTOMER_ID NUMBER,
QUANTITY NUMBER CONSTRAINT QUANTITY_MIN CHECK(QUANTITY>0),
CONSTRAINT CART_ITEM_PK PRIMARY KEY(PRODUCT_ID , SELLER_ID, CUSTOMER_ID),
CONSTRAINT CART_ITEM_FK1 FOREIGN KEY(PRODUCT_ID, SELLER_ID) REFERENCES PRODUCT(PRODUCT_ID, SELLER_ID),
CONSTRAINT CART_ITEM_FK2 FOREIGN KEY(SELLER_ID) REFERENCES SELLER(SELLER_ID),
CONSTRAINT CART_ITEM_FK3 FOREIGN KEY(CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID)
);


--DROP TABLE ORDERED_ITEMS;

CREATE TABLE ORDERED_ITEMS(
PRODUCT_ID NUMBER,
SELLER_ID NUMBER,
ORDER_ID NUMBER,
ITEM_NUMBER NUMBER,
CONSTRAINT ORDERED_ITEMS_PK PRIMARY KEY(PRODUCT_ID , SELLER_ID, ORDER_ID, ITEM_NUMBER),
CONSTRAINT ORDERED_ITEMS_FK1 FOREIGN KEY(PRODUCT_ID, SELLER_ID,ITEM_NUMBER) REFERENCES PRODUCT_UNIT(PRODUCT_ID, SELLER_ID,ITEM_NUMBER),
CONSTRAINT ORDERED_ITEMS_FK2 FOREIGN KEY(ORDER_ID) REFERENCES CUSTOMER_ORDER(ORDER_ID)
);

--DROP TABLE TRANSACTIONS

CREATE TABLE TRANSACTIONS(
TRANSACTION_ID NUMBER CONSTRAINT TRANSACTIONS_PK PRIMARY KEY,
TRANSACTIONS_DATE DATE NOT NULL,
AMOUNT NUMBER NOT NULL,
SERVICE_CHARGE_PERCENTAGE NUMBER NOT NULL
);


--DROP TABLE CUSTOMER_CASH_TRANSACTION

CREATE TABLE CUSTOMER_CASH_TRANSACTION(
TRANSACTION_ID NUMBER CONSTRAINT CUSTOMER_CASH_TRANSATION_PK PRIMARY KEY,
ORDER_ID NUMBER NOT NULL,
CONSTRAINT CUSTOMER_CASH_TRANSATION_FK1 FOREIGN KEY(TRANSACTION_ID) REFERENCES TRANSACTIONS(TRANSACTION_ID),
CONSTRAINT CUSTOMER_CASH_TRANSATION_FK2 FOREIGN KEY(ORDER_ID) REFERENCES CUSTOMER_ORDER(ORDER_ID)
);


--DROP TABLE CUSTOMER_WALLET_RECHARGE

CREATE TABLE CUSTOMER_WALLET_RECHARGE(
TRANSACTION_ID NUMBER CONSTRAINT CUSTOMER_WALLET_RECHARGE_PK PRIMARY KEY,
CUSTOMER_ID NUMBER NOT NULL,
CONSTRAINT CUSTOMER_WALLET_RECHARGE_FK1 FOREIGN KEY(TRANSACTION_ID) REFERENCES TRANSACTIONS(TRANSACTION_ID),
CONSTRAINT CUSTOMER_WALLET_RECHARGE_FK2 FOREIGN KEY(CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID)
);


--DROP TABLE SELLER_TRANSACTION

CREATE TABLE SELLER_TRANSACTION(
TRANSACTION_ID NUMBER CONSTRAINT SELLER_TRANSACTION_PK PRIMARY KEY,
SELLER_ID NUMBER NOT NULL,
CONSTRAINT SELLER_TRANSACTION_FK1 FOREIGN KEY(TRANSACTION_ID) REFERENCES TRANSACTIONS(TRANSACTION_ID),
CONSTRAINT SELLER_TRANSACTION_FK2 FOREIGN KEY(SELLER_ID) REFERENCES SELLER(SELLER_ID)
);
