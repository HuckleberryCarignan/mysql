#
#  READ ME:  The following script will CREATE TABLES then ALTER the TABLES by ADDing Foreign KEY CONSTRAINTS
# be sure to set the below @SourceDBName to the correct Database Name
#

SET sql_notes = 0;

# Define the database you want to create the tables in
SET @SourceDBName='dev';

#
#   CREATE TABLES 
# 
# Turn Warning Messages = OFF

# Create Table = agreed_relation
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.agreed_relation (
   agreed_relation_id  INT(10) NOT NULL AUTO_INCREMENT,
   production_agreement_id INT(10) NOT NULL,
   merchant_id INT(10),
   fulfillment_location_id INT(10),
   status VARCHAR (767),
   start DATE,
   stop DATE,
   base_uri VARCHAR (1000), # Optional & the Key can only be 767, so if we ever want a foreign
   last_updated TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
   created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY ( agreed_relation_id )
);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

# Create Table = catalogue type
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.catalog_type (
   catalog_type_id  INT(10) NOT NULL AUTO_INCREMENT,
   name VARCHAR (767),
   description VARCHAR (767), 
   base_uri VARCHAR (767), 
   last_updated TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
   created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY ( catalog_type_id )
);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

# Create Table = customs_item
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.customs_item (
   customs_item_id INT(10) NOT NULL AUTO_INCREMENT,
   customs_part_key VARCHAR(10),
   MCP_SKU VARCHAR(10),
   country_of_origin  VARCHAR(2),
   last_updated TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
   created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY ( customs_item_id )
);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

# Create Table = customs_part
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.customs_part (
   customs_part_key VARCHAR(350) NOT NULL, 
   part_catalog_map_id INT(10),
   production_agreement_id INT (10),
   customs_part_key_uri VARCHAR (500), # The Key can only be 767, so if we ever want a foreign
   last_updated TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
   created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY ( customs_part_key )
);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;


# Create Table = customs_shipment
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.customs_shipment (
   customs_shipment_id INT(10), 
   customs_shipment_item_id INT (10),
   last_updated TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
   created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY ( customs_shipment_id )
);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

# Create Table = customs_shipment_item
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.customs_shipment_item (
   customs_shipment_item_id INT(10), 
   customs_shipment_id INT (10),
   customs_item_id INT (10),
   last_updated TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
   created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY ( customs_shipment_item_id )
);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

# Create Table = importer_of_record
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.importer_of_record (
   importer_of_record_id  INT(10) NOT NULL AUTO_INCREMENT,
   agreed_relation_id INT (10),
   legal_name VARCHAR (767), # The Key can only be 767, so if we ever want a foreign
   legal_address VARCHAR (767),  # JSON & the Key can only be 767, so if we ever want a foreign
   tax_id INT (10),
   last_updated TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
   created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY ( importer_of_record_id )
);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

# Create Table = material_detail
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.material_detail (
   material_detail_id INT(10) NOT NULL AUTO_INCREMENT,
   material_detail_description VARCHAR(767),  # The Key can only be 767, so if we ever want a foreign
   mid_code VARCHAR(767),   # The Key can only be 767, so if we ever want a foreign
   country_of_origin  VARCHAR(2),
   item_weight FLOAT (10),
   supplier_id  INT(10),
   last_updated TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
   created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY ( material_detail_id )
);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

# Create Table = material_detail_default
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.material_detail_default (
   material_detail_default_id INT(10) NOT NULL AUTO_INCREMENT,
   material_detail_description VARCHAR(767),  # The Key can only be 767, so if we ever want a foreign
   mid_code VARCHAR(767),   # The Key can only be 767, so if we ever want a foreign
   country_of_origin  VARCHAR(2), # The ISO country codes are only 2 VARCHAR
   effective_date DATE,
   item_weight FLOAT (10),
   part_catalog_map_id  INT(10),
   supplier_id  INT(10),
   last_updated TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
   created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY ( material_detail_default_id )
);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

# Create Table = part_catalog_map
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.part_catalog_map (
   part_catalog_map_id  INT(10) NOT NULL AUTO_INCREMENT,
   catalog_type_id INT (10),
   foreign_product_id INT (10),
   description VARCHAR (767), # The Key can only be 767, so if we ever want a foreign
   last_updated TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
   created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY ( part_catalog_map_id )
);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

# Create Table = part_catalog_map_r_supplier
SET	@DBNAME=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.part_catalog_map_r_supplier (
   part_catalog_map_r_supplier_id INT(10) NOT NULL AUTO_INCREMENT,
   part_catalog_map_id INT (10),
   supplier_id INT (10),
   last_updated TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
    created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY ( part_catalog_map_r_supplier_id )
);');
PREPARE executionstatement FROM @DBNAME;
EXECUTE executionstatement;

# Create Table = production_agreement
SET	@DBNAME=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.production_agreement (
   production_agreement_id INT(10) NOT NULL AUTO_INCREMENT,
   description VARCHAR (767), 
   last_updated TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
   created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY ( production_agreement_id )
);');
PREPARE executionstatement FROM @DBNAME;
EXECUTE executionstatement;

# Create Table = supplier
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.supplier (
   supplier_id  INT(10) NOT NULL AUTO_INCREMENT,
   supplier_name VARCHAR (767),  # The Key can only be 767, so if we ever want a foreign
   mid_code VARCHAR (767),  # The Key can only be 767, so if we ever want a foreign
   material_detail_id INT (10),
   last_updated TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
   created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY ( supplier_id )
);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

#
#   ADD FOREIGN KEYS
# 
# CONSTRAINT naming convention = fk_referenced table name]_[referencing field name]
#

# Add Foreign Key constraints to Table = part_catalog_map.catalog_type_id is tied to catalog_part.catalog_type_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.part_catalog_map
ADD CONSTRAINT fk_catalog_type_catalog_type_id
FOREIGN KEY ( catalog_type_id ) REFERENCES ',@SourceDBName,'.catalog_type ( catalog_type_id )');
#SELECT @alterstatement;
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Add Foreign Key constraints to Table = part_catalog_map_r_supplier.part_catalog_map_id is tied to part_catalog_map.part_catalog_map_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.part_catalog_map_r_supplier
ADD CONSTRAINT fk_part_catalog_map_part_catalog_map_id_1
FOREIGN KEY ( part_catalog_map_id ) REFERENCES ',@SourceDBName,'.part_catalog_map ( part_catalog_map_id )');
#SELECT @alterstatement;
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Add Foreign Key constraints to Table = customs_part.part_catalog_map_id is tied to part_catalog_map.part_catalog_map_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.customs_part
ADD CONSTRAINT fk_part_catalog_map_part_catalog_map_id_2
FOREIGN KEY ( part_catalog_map_id ) REFERENCES ',@SourceDBName,'.part_catalog_map ( part_catalog_map_id )');
#SELECT @alterstatement;
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Add Foreign Key constraints to Table = material_detail.supplier_id is tied to supplier.supplier_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.material_detail
ADD CONSTRAINT fk_supplier_supplier_id_1
FOREIGN KEY ( supplier_id ) REFERENCES ',@SourceDBName,'.supplier ( supplier_id )');
#SELECT @alterstatement;
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Add Foreign Key constraints to Table = material_detail_default.supplier_id is tied to supplier.supplier_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.material_detail_default
ADD CONSTRAINT fk_supplier_supplier_id_2
FOREIGN KEY ( supplier_id ) REFERENCES ',@SourceDBName,'.supplier ( supplier_id )');
#SELECT @alterstatement;
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Add Foreign Key constraints to Table = agreed_relation.production_agreement_id is tied to product_agreement.product_agreement_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.agreed_relation
ADD CONSTRAINT fk_production_agreement_production_agreement_id_1
FOREIGN KEY ( production_agreement_id ) REFERENCES ',@SourceDBName,'.production_agreement ( production_agreement_id )');
#SELECT @alterstatement;
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Add Foreign Key constraints to Table = importer_of_record.agreed_relation_id is tied to agreed_relation.agreed_relation_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.importer_of_record
ADD CONSTRAINT fk_agreed_relation_agreed_relation_id
FOREIGN KEY ( agreed_relation_id ) REFERENCES ',@SourceDBName,'.agreed_relation ( agreed_relation_id )');
#SELECT @alterstatement;
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Add Foreign Key constraints to Table = material_detail_default.part_catalog_map_id is tied to part_catalog_map.part_catalog_map_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.material_detail_default
ADD CONSTRAINT fk_part_catalog_map_part_catalog_map_id
FOREIGN KEY ( part_catalog_map_id ) REFERENCES ',@SourceDBName,'.part_catalog_map ( part_catalog_map_id )');
#SELECT @alterstatement;
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Add Foreign Key constraints to Table = customs_part.production_agreement_id is tied to production_agreement.production_agreement_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.customs_part
ADD CONSTRAINT fk_production_agreement_production_agreement_id_2
FOREIGN KEY ( production_agreement_id ) REFERENCES ',@SourceDBName,'.production_agreement ( production_agreement_id )');
#SELECT @alterstatement;
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Add Foreign Key constraints to Table = customs_item.customs_part_key is tied to customs_part.customs_part_key
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.customs_item
ADD CONSTRAINT fk_customs_part_customs_part_key
FOREIGN KEY ( customs_part_key ) REFERENCES ',@SourceDBName,'.customs_part ( customs_part_key )');
#SELECT @alterstatement;
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Add Foreign Key constraints to Table = customs_shipment_item.customs_item_id is tied to customs_item.customs_item_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.customs_shipment_item
ADD CONSTRAINT fk_customs_item_customs_item_id
FOREIGN KEY ( customs_item_id ) REFERENCES ',@SourceDBName,'.customs_item ( customs_item_id )');
#SELECT @alterstatement;
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Add Foreign Key constraints to Table = customs_shipment.customs_shipment_item_id is tied to customs_shipment_item.customs_shipmnet_item_id
SET	@alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.customs_shipment
ADD CONSTRAINT fk_customs_shipment_item_customs_shipment_item_id
FOREIGN KEY ( customs_shipment_item_id ) REFERENCES ',@SourceDBName,'.customs_shipment_item ( customs_shipment_item_id )');
#SELECT @alterstatement;
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Turn Warning Messages = ON
SET sql_notes = 1;

