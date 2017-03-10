#
# Create tables
#

# Turn Warning Messages = OFF
SET sql_notes = 0;

# Define the database you want to create the tables in
SET @SourceDBName='dev';

# Create Table = catalogue type
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.catalog_type (
   catalog_type_id  INT(30) NOT NULL AUTO_INCREMENT,
   name VARCHAR (255) NOT NULL,
   description VARCHAR (255) NOT NULL,
   base_uri VARCHAR (255), # optional
   last_updated TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
   PRIMARY KEY ( catalog_type_id )
);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

# Create Table = part_catalog_map
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.part_catalog_map (
   part_catalog_map_id  INT(30) NOT NULL AUTO_INCREMENT,
   catalog_type_id INT (10) NOT NULL,
   foreign_product_id INT (10) NOT NULL,
   description VARCHAR (255) NOT NULL,
   last_updated TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
   PRIMARY KEY ( part_catalog_map_id )
);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

# Create Table = importer_of_record
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.importer_of_record (
   importer_of_record_id  INT(30) NOT NULL AUTO_INCREMENT,
   agreed_relationship_id INT (10) NOT NULL,
   legal_name VARCHAR (200) NOT NULL,
   legal_address VARCHAR (255) NOT NULL,  #JSON
   tax_id INT (10) NOT NULL,
   last_updated TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
   PRIMARY KEY ( importer_of_record_id )
);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

# Create Table = customs_part_key
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.customs_part_key (
   customs_part_key VARCHAR(255) NOT NULL,
   part_catalog_map_id INT(10) NOT NULL,
   production_agreement_id INT (30) NOT NULL,
   customs_part_key_uri VARCHAR (255), # optional
   last_updated TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
   PRIMARY KEY ( customs_part_key )
);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

# Create Table = material_detail_default
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.material_detail_default (
   material_detail_default_id INT NOT NULL AUTO_INCREMENT,
   material_detail_description VARCHAR(255) NOT NULL,
   mid_code VARCHAR(100) NOT NULL, 
   country_of_origin  VARCHAR(2) NOT NULL,
   effective_date DATE NOT NULL,
   item_weight FLOAT (10) NOT NULL,
   last_updated TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
   PRIMARY KEY ( material_detail_default_id )
);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

# Create Table = supplier
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.supplier (
   supplier_id  INT(30) NOT NULL AUTO_INCREMENT,
   supplier_name VARCHAR (255) NOT NULL,
   mid_code VARCHAR (255) NOT NULL,
   last_updated TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
   PRIMARY KEY ( supplier_id )
);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

# Create Table = part_catalog_map_supplier
SET	@DBNAME=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.part_catalog_map_supplier (
   part_Catalog_map_supplier_id INT(10) NOT NULL AUTO_INCREMENT,
   part_catalog_map_id INT (10) NOT NULL,
   supplier_id INT (10) NOT NULL,
   last_updated TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
   PRIMARY KEY ( part_Catalog_map_supplier_id )
);');
PREPARE executionstatement FROM @DBNAME;
EXECUTE executionstatement;

# Create Table = material_detail
SET	@createstatement=CONCAT('CREATE TABLE IF NOT EXISTS ',@SourceDBName,'.material_detail (
   material_detail_id INT NOT NULL AUTO_INCREMENT,
   material_detail_description VARCHAR(255) NOT NULL,
   mid_code VARCHAR(255) NOT NULL, 
   country_of_origin  VARCHAR(2) NOT NULL,
   item_weight FLOAT (10) NOT NULL,
   last_updated TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
   PRIMARY KEY ( material_detail_id )
);');
PREPARE executionstatement FROM @createstatement;
EXECUTE executionstatement;

# Turn Warning Messages = ON
SET sql_notes = 1;