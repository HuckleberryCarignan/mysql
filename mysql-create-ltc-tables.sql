#
#  READ ME:  The following script will CREATE TABLES then ALTER the TABLES by ADDing Foreign KEY CONSTRAINTS
# be sure to set the below @SourceDBName to the correct Database Name
#

# Define the database you want to create the tables in
SET @SourceDBName='dev';

# Turn Warning Messages = OFF
SET sql_notes = 0;
USE dev;

#
#   CREATE TABLES - Fulfiller Relationship related tables
# 

# Create Table = production_agreement
SET	@DBNAME=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.production_agreement (
	production_agreement_id INT(10) NOT NULL AUTO_INCREMENT,
	description VARCHAR (767), 
	name BINARY (16) NOT NULL UNIQUE,
    external_id BINARY (16) NOT NULL UNIQUE,
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ( production_agreement_id )
	);');
PREPARE executionstatement FROM @DBNAME;
EXECUTE executionstatement;

# Create Table = agreed_relation
# merchant_id and fulfillment_location_id must be unique and NOT NULL due to uk_agreed_relation_merchant_id_merchant_id
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.agreed_relation (
	agreed_relation_id  INT(10) NOT NULL AUTO_INCREMENT,
	production_agreement_id INT(10) NOT NULL,
	merchant_id VARCHAR (383) NOT NULL,
	fulfillment_location_id VARCHAR (383) NOT NULL,
	description VARCHAR (767),
    fulfiller_id VARCHAR (767) NOT NULL,
	agreed_relation_status_id INT(10) NOT NULL,
	importer_of_record_id  INT(10),
	start DATE NOT NULL,
	stop DATE,
	base_uri VARCHAR (1000), # Optional & the Key can only be 767, so if we ever want a foreign
	external_id BINARY (16) NOT NULL UNIQUE,
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ( agreed_relation_id )
	);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

# Create Table = agreed_relation_status
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.agreed_relation_status (
	agreed_relation_status_id  INT(10) NOT NULL AUTO_INCREMENT,
    code VARCHAR (767) NOT NULL,
	description VARCHAR (767),
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ( agreed_relation_status_id )
	);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

# Create Table = importer_of_record
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.importer_of_record (
	importer_of_record_id  INT(10) NOT NULL AUTO_INCREMENT,
	agreed_relation_id INT (10) NOT NULL,
	legal_name VARCHAR (767) NOT NULL,
	legal_address_id INT (10) NOT NULL,
	tax_id VARCHAR (767) NOT NULL,
	external_id BINARY (16) NOT NULL UNIQUE,
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ( importer_of_record_id )
	);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

#
#   CREATE TABLES - TCI related tables 
# 

# Create Table = customs_part
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.customs_part (
	customs_part_key VARCHAR(350) NOT NULL, 
	production_agreement_id INT (10) NOT NULL,
	customs_part_key_uri VARCHAR (500) NOT NULL, # The Key can only be 767, so if we ever want a foreign
	external_id BINARY (16) NOT NULL UNIQUE,
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ( customs_part_key )
	);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

# Create Table = part_catalog_map
# part_catalog_map_id and foreign_product_id must be unique and NOT NULL due to uk_part_catalog_map_catalog_type_id_foreign_product_id
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.part_catalog_map (
	part_catalog_map_id  INT(10) NOT NULL AUTO_INCREMENT,
	catalog_type_id INT (10) NOT NULL,
	foreign_product_id INT (10) NOT NULL,
	customs_part_key VARCHAR(350) NOT NULL,
	description VARCHAR (767), # The Key can only be 767, so if we ever want a foreign
	external_id BINARY (16) NOT NULL UNIQUE,
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ( part_catalog_map_id )
	);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

# Create Table = catalogue type
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.catalog_type (
	catalog_type_id  INT(10) NOT NULL AUTO_INCREMENT,
	name VARCHAR (767) NOT NULL,
	description VARCHAR (767), 
	base_uri VARCHAR (767), 
	external_id BINARY (16) NOT NULL UNIQUE,
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ( catalog_type_id )
	);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

# Create Table = part_catalog_map_r_supplier
SET	@DBNAME=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.part_catalog_map_r_supplier (
	part_catalog_map_id INT (10) NOT NULL,
	supplier_id INT (10) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ( part_catalog_map_id, supplier_id )
	);');
PREPARE executionstatement FROM @DBNAME;
EXECUTE executionstatement;

#
#   CREATE TABLES - Border Manifest related tables 
# 

# Create Table = customs_shipment
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.customs_shipment (
	customs_shipment_id INT(10) NOT NULL AUTO_INCREMENT, 
	external_id BINARY (16) NOT NULL UNIQUE,
    foreign_shipment_id VARCHAR (767) NOT NULL, 
    consignee_id INT (10) NOT NULL,
    destination_address_id INT (10) NOT NULL,
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ( customs_shipment_id )
	);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

# Create Table = consignee
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.consignee (
	consignee_id INT(10) NOT NULL AUTO_INCREMENT, 
    address_id INT(10) NOT NULL,
    tax_id VARCHAR (767),
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ( consignee_id )
	);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

# Create Table = address
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.address (
	address_id INT(10) NOT NULL AUTO_INCREMENT, 
	name VARCHAR (767) NOT NULL,
	address1 VARCHAR (767) NOT NULL,
	address2 VARCHAR (767),
	locality VARCHAR (767) NOT NULL,
	region VARCHAR (767) NOT NULL,
    postal_code VARCHAR (767) NOT NULL,
	country_code VARCHAR (2) NOT NULL,
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ( address_id )
	);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

#  declared_value_currency VARCHAR (767),
# Create Table = customs_shipment_item
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.customs_shipment_item (
	customs_shipment_item_id INT(10) NOT NULL AUTO_INCREMENT, 
	customs_shipment_id INT (10) NOT NULL,
	customs_item_id INT (10) NOT NULL,
	description VARCHAR(767),
    merchant_id VARCHAR (767) NOT NULL,
	mid_code VARCHAR(767) NOT NULL, 
	country_of_origin_code  VARCHAR(2) NOT NULL,
    foreign_shipment_item_id VARCHAR (767),
	item_weight FLOAT (10) NOT NULL,
    supplier_id INT (10),
    declared_value_amount_id INT (10),
	external_id BINARY (16) NOT NULL UNIQUE,
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ( customs_shipment_item_id )
	);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

# Create Table = customs_item
#	list_price_currency VARCHAR (767),
# 	price_paid_currency VARCHAR (767),
# 	declared_value_currency VARCHAR (767),
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.customs_item (
	customs_item_id INT(10) NOT NULL AUTO_INCREMENT,
	customs_part_key VARCHAR(767),
    customs_item_status_id INT (10),
	part_catalog_map_id INT (10),
    order_id VARCHAR (767),
	order_Item_id VARCHAR (767),
	merchant_id VARCHAR (383) NOT NULL,
	list_price_amount_id INT (10),
	price_paid_amount_id INT (10),
    declared_value_amount_id INT (10),
	description VARCHAR(767),
	fulfillment_location_id VARCHAR (383) NOT NULL,
	country_of_origin_code  VARCHAR(2),
	external_id BINARY (16) NOT NULL UNIQUE,
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ( customs_item_id )
	);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

# Create Table = customs_item_status
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.customs_item_status (
	customs_item_status_id INT(10) NOT NULL AUTO_INCREMENT,
    code VARCHAR (767) NOT NULL,
	description VARCHAR (767),
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ( customs_item_status_id )
	);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

# Create Table = Amount
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.amount (
	amount_id INT(10) NOT NULL AUTO_INCREMENT,
    currency_id INT (10) NOT NULL,
    value DOUBLE (20,5) NOT NULL,
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ( amount_id )
	);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

# Create Table = Currency
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.currency (
	currency_id INT(10) NOT NULL AUTO_INCREMENT,
	name VARCHAR (767) NOT NULL,
    code VARCHAR (767) NOT NULL,
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ( currency_id )
	);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

#
#   CREATE TABLES - Supplier related tables 
# 

# Create Table = material_detail_default
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.material_detail_default (
	material_detail_default_id INT(10) NOT NULL AUTO_INCREMENT,
	description VARCHAR(767) NOT NULL,  
	mid_code VARCHAR(767) NOT NULL,   
	country_of_origin_code  VARCHAR(2) NOT NULL,
	effective_date DATE NOT NULL,
	item_weight FLOAT (10) NOT NULL,
	part_catalog_map_id  INT(10) NOT NULL,
	supplier_id  INT(10) NOT NULL,
	external_id BINARY (16) NOT NULL UNIQUE,
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ( material_detail_default_id )
	);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

# Create Table = supplier
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.supplier (
	supplier_id  INT(10) NOT NULL AUTO_INCREMENT,
	name VARCHAR (767) NOT NULL,
	mid_code VARCHAR (767),
	external_id BINARY (16) NOT NULL UNIQUE,
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ( supplier_id )
	);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

#
#   ADD FOREIGN KEYS - Within the tables related to Fulfiller Relationship
# 
# CONSTRAINT naming convention = fk_referenced table name]_[referencing field name]
#

# Add Foreign Key constraints to table - agreed_relation.production_agreement_id is tied to production_agreement.production_agreement_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.agreed_relation
	ADD CONSTRAINT fk_production_agreement_production_agreement_id_1
	FOREIGN KEY ( production_agreement_id ) REFERENCES ',@SourceDBName,'.production_agreement ( production_agreement_id )');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Add Foreign Key constraints to table - agreed_relation.importer_of_record_id is tied to importer_of_record.importer_of_record_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.agreed_relation
	ADD CONSTRAINT fk_importer_of_record_importer_of_record_id
	FOREIGN KEY ( importer_of_record_id ) REFERENCES ',@SourceDBName,'.importer_of_record ( importer_of_record_id )');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Add Foreign Key constraints to table - agreed_relation.agreed_relation_status_id is tied to agreed_relation_status.agreed_relation_status_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.agreed_relation
	ADD CONSTRAINT fk_agreed_relation_status_agreed_relation_status_id
	FOREIGN KEY ( agreed_relation_status_id ) REFERENCES ',@SourceDBName,'.agreed_relation_status ( agreed_relation_status_id )');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Add Unique Key / Constraint / Index to table agree_relation - agreed_relation.merchant_id & agreed_relation.fulfillment_location_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.agreed_relation
	ADD constraint uk_agreed_relation_merchant_id_fulfillment_location_id
	UNIQUE ( merchant_id,  fulfillment_location_id)');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

#
#   ADD FOREIGN KEYS - Withing the tables related to TCI
# 
# CONSTRAINT naming convention = fk_referenced table name]_[referencing field name]
#

# Add Foreign Key constraints to table - part_catalog_map.catalog_type_id is tied to catalog_part.catalog_type_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.part_catalog_map
	ADD CONSTRAINT fk_catalog_type_catalog_type_id
	FOREIGN KEY ( catalog_type_id ) REFERENCES ',@SourceDBName,'.catalog_type ( catalog_type_id )');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Add Foreign Key constraints to table - customs_part.production_agreement_id is tied to production_agreement.production_agreement_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.customs_part
	ADD CONSTRAINT fk_production_agreement_production_agreement_id_2
	FOREIGN KEY ( production_agreement_id ) REFERENCES ',@SourceDBName,'.production_agreement ( production_agreement_id )');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Add Foreign Key constraints to table - part_catalog_map_r_supplier.part_catalog_map_id is tied to part_catalog_map.part_catalog_map_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.part_catalog_map_r_supplier
	ADD CONSTRAINT fk_part_catalog_map_part_catalog_map_id_1
	FOREIGN KEY ( part_catalog_map_id ) REFERENCES ',@SourceDBName,'.part_catalog_map ( part_catalog_map_id )');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Add Foreign Key constraints to table - part_catalog_map.customs_part_key is tied to customs_part.customs_part_key
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.part_catalog_map
	ADD CONSTRAINT fk_customs_part_customs_part_key
	FOREIGN KEY ( customs_part_key ) REFERENCES ',@SourceDBName,'.customs_part ( customs_part_key )');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Add Unique Key / Constraint / Index to table part_catalog_map - part_catalog_map.catalog_type_id & foreign_product_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.part_catalog_map
	ADD constraint uk_part_catalog_map_catalog_type_id_foreign_product_id
	UNIQUE ( part_catalog_map_id,  foreign_product_id)');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

#
#   ADD FOREIGN KEYS - Withing the tables related to Border Manifest
# 
# CONSTRAINT naming convention = fk_referenced table name]_[referencing field name]
#

# Add Foreign Key constraints to table - customs_shipment.consignee_id (many) is tied to consignee.consignee_id (one)
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.customs_shipment
	ADD CONSTRAINT fk_consignee_consignee_id
	FOREIGN KEY ( consignee_id ) REFERENCES ',@SourceDBName,'.consignee ( consignee_id )');
#SELECT @alterstatement;
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Add Foreign Key constraints to table - consignee.address_id (many) is tied to address.address_id (one)
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.consignee
	ADD CONSTRAINT fk_address_address_id_1
	FOREIGN KEY ( address_id ) REFERENCES ',@SourceDBName,'.address ( address_id )');
#SELECT @alterstatement;
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Add Foreign Key constraints to table - customs_shipment.destination_address_id (many) is tied to address.address_id  (one)
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.customs_shipment
	ADD CONSTRAINT fk_address_address_id_2
	FOREIGN KEY ( destination_address_id ) REFERENCES ',@SourceDBName,'.address ( address_id )');
#SELECT @alterstatement;
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Add Foreign Key constraints to table - customs_shipment_item.customs_item_id (many) is tied to customs_item.customs_item_id (one)
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.customs_shipment_item
	ADD CONSTRAINT fk_customs_shipment_customs_shipment_id
	FOREIGN KEY ( customs_shipment_id ) REFERENCES ',@SourceDBName,'.customs_shipment ( customs_shipment_id )');
#SELECT @alterstatement;
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Add Foreign Key constraints to table - customs_shipment_item.customs_shipment_id is tied to customs_shipment.customs_shipment_item_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.customs_shipment_item
	ADD CONSTRAINT fk_customs_shipment_customs_shipment_id2
	FOREIGN KEY ( customs_item_id ) REFERENCES ',@SourceDBName,'.customs_item ( customs_item_id )');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Add Foreign Key constraints to table - customs_item.customs_item_status_id is tied to customs_item_status.customs_item_status_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.customs_item
	ADD CONSTRAINT fk_customs_item_status_customs_item_status_id
	FOREIGN KEY ( customs_item_status_id ) REFERENCES ',@SourceDBName,'.customs_item_status ( customs_item_status_id )');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Add Foreign Key constraints to table - customs_item.declared_amount_id is tied to amount.amount_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.customs_item
	ADD CONSTRAINT fk_amount_amount_id_1
	FOREIGN KEY ( declared_value_amount_id ) REFERENCES ',@SourceDBName,'.amount ( amount_id )');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Add Foreign Key constraints to table - customs_item.price_paid_amount_id is tied to amount.amount_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.customs_item
	ADD CONSTRAINT fk_amount_amount_id_2
	FOREIGN KEY ( price_paid_amount_id ) REFERENCES ',@SourceDBName,'.amount ( amount_id )');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

 # Add Foreign Key constraints to table - customs_item.list_price_amount is tied to amount.amount_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.customs_item
	ADD CONSTRAINT fk_amount_amount_id_3
	FOREIGN KEY ( list_price_amount_id ) REFERENCES ',@SourceDBName,'.amount ( amount_id )');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

 # Add Foreign Key constraints to table - customs_shipment_item.declared_amount_id is tied to amount.amount_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.customs_shipment_item
	ADD CONSTRAINT fk_amount_amount_id_4
	FOREIGN KEY ( declared_value_amount_id ) REFERENCES ',@SourceDBName,'.amount ( amount_id )');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

 # Add Foreign Key constraints to table - amount.currency_id is tied to currency.currency_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.amount
	ADD CONSTRAINT fk_currency_currency_id
	FOREIGN KEY ( currency_id ) REFERENCES ',@SourceDBName,'.currency ( currency_id )');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

#
#   ADD FOREIGN KEYS - Withing the tables related to Supplier
# 
# CONSTRAINT naming convention = fk_referenced table name]_[referencing field name]
#

# Add Foreign Key constraints to table - material_detail_default.supplier_id is tied to supplier.supplier_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.material_detail_default
	ADD CONSTRAINT fk_supplier_supplier_id_2
	FOREIGN KEY ( supplier_id ) REFERENCES ',@SourceDBName,'.supplier ( supplier_id )');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

#
#   ADD FOREIGN KEYS - Between the tables related to Fulfillers and TCI
# 
# CONSTRAINT naming convention = fk_referenced table name]_[referencing field name]
#

# Add Unique Key / Constraint / Index to table customs_part - customs_part_key & production_agreement_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.customs_part
	ADD constraint uk_customs_part_customs_part_key_production_agreement_id
	UNIQUE ( customs_part_key,  production_agreement_id)');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

#
#   ADD FOREIGN KEYS - Between the tables related to Border Manifest and TCI
# 
# CONSTRAINT naming convention = fk_referenced table name]_[referencing field name]
#

# Add Foreign Key constraints to table - customs_item.part_catalog_map_id is tied to part_catalog_map.part_catalog_map_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.customs_item
	ADD CONSTRAINT fk_part_catalog_map_part_catalog_map_id_3
	FOREIGN KEY ( part_catalog_map_id ) REFERENCES ',@SourceDBName,'.part_catalog_map ( part_catalog_map_id )');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

#
#   ADD FOREIGN KEYS - Between the tables related to Suppliers and TCI
# 
# CONSTRAINT naming convention = fk_referenced table name]_[referencing field name]
#

# Add Foreign Key constraints to table - part_catalog_map_r_supplier.supplier_id is tied to supplier.supplier_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.part_catalog_map_r_supplier
	ADD CONSTRAINT fk_supplier_supplier_id
	FOREIGN KEY ( supplier_id ) REFERENCES ',@SourceDBName,'.supplier ( supplier_id )');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Add Foreign Key constraints to table - material_detail_default.part_catalog_map_id is tied to part_catalog_map.part_catalog_map_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.material_detail_default
	ADD CONSTRAINT fk_part_catalog_map_part_catalog_map_id
	FOREIGN KEY ( part_catalog_map_id ) REFERENCES ',@SourceDBName,'.part_catalog_map ( part_catalog_map_id )');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

#
#   ADD FOREIGN KEYS - Between the tables related to Suppliers and TCI
# 
# CONSTRAINT naming convention = fk_referenced table name]_[referencing field name]
#

# Add Foreign Key constraints to table - customs_shipment_item.supplier_id is tied to supplier.supplier_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.customs_shipment_item
	ADD CONSTRAINT fk_supplier_supplier_id2
	FOREIGN KEY ( supplier_id ) REFERENCES ',@SourceDBName,'.supplier ( supplier_id )');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

 # Add Foreign Key constraints to table - importer_of_record.legal_address_id is tied to address.address_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.importer_of_record
	ADD CONSTRAINT fk_address_address_id_3
	FOREIGN KEY ( legal_address_id ) REFERENCES ',@SourceDBName,'.address ( address_id )');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Turn Warning Messages = ON
SET sql_notes = 1;