#
#  READ ME:  The following script will DROP FOREIGN KEY CONSTRAINTS then DROP the TABLES
# be sure to set the below @SourceDBName to the correct Database Name
#


# Turn Warning Messages = OFF
SET sql_notes = 0;


# Define the database you want to create the tables in
SET @SourceDBName='dev';

#
#   REMOVE FOREIGN KEY - Within the tables related to Fulfiller Relationship
#

# Remove Foreign Key Constraint(s) for agreed_relation.production_agreement_id to product_agreement.product_agreement_id
SET @alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.agreed_relation DROP FOREIGN KEY fk_production_agreement_production_agreement_id_1;');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Remove Foreign Key Constraint(s) for agreed_relation.importer_of_record_id to importer_of_record.importer_of_record_id
SET @alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.agreed_relation DROP FOREIGN KEY fk_importer_of_record_importer_of_record_id;');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

#
#   REMOVE FOREIGN KEY - Withing the tables related to TCI
#

# Remove Foreign Key Constraint(s) for part_catalog_map.catalog_type_id to catalog_part.catalog_type_id
SET @alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.part_catalog_map DROP FOREIGN KEY fk_catalog_type_catalog_type_id;');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Remove Foreign Key Constraint(s) for customs_part.production_agreement_id to production_agreement.production_agreement_id
SET @alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.customs_part DROP FOREIGN KEY fk_production_agreement_production_agreement_id_2;');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Remove Foreign Key Constraint(s) for part_catalog_map_r_supplier.part_catalog_map_id to part_catalog_map.part_catalog_map_id
SET @alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.part_catalog_map_r_supplier DROP FOREIGN KEY fk_part_catalog_map_part_catalog_map_id_1;');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Remove Foreign Key Constraint(s) for part_catalog_map_r_supplier.supplier_id to supplier.supplier_id
SET @alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.part_catalog_map DROP FOREIGN KEY fk_customs_part_customs_part_key;');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

#
#   REMOVE FOREIGN KEY - Withing the tables related to Border Manifest
#

# Remove Foreign Key Constraint(s) for customs_shipment.customs_shipment_item_id to customs_shipment_item.customs_shipmnet_item_id
SET @alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.customs_shipment DROP FOREIGN KEY fk_customs_shipment_item_customs_shipment_item_id;');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Remove Foreign Key Constraint(s) for customs_shipment_item.customs_item_id to customs_item.customs_item_id
SET @alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.customs_shipment_item DROP FOREIGN KEY fk_customs_item_customs_item_id;');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

#
#   REMOVE FOREIGN KEY - Withing the tables related to Border Manifest
#

# Remove Foreign Key Constraint(s) for material_detail.supplier_id to supplier.supplier_id
SET @alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.material_detail DROP FOREIGN KEY fk_supplier_supplier_id_1;');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Remove Foreign Key Constraint(s) for material_detail_default.supplier_id to supplier.supplier_id
SET @alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.material_detail_default DROP FOREIGN KEY fk_supplier_supplier_id_2;');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

#
#   REMOVE FOREIGN KEY - Between the tables related to Border Manifest and TCI
#

# Remove Foreign Key Constraint(s) for customs_item.part_catalog_map_id is tied to part_catalog_map.part_catalog_map_id
SET @alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.customs_item DROP FOREIGN KEY fk_part_catalog_map_part_catalog_map_id_3;');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

#
#   REMOVE FOREIGN KEY - Between the tables related to Suppliers and TCI
#

# Remove Foreign Key Constraint(s) for part_catalog_map_r_supplier.supplier_id to supplier.supplier_id
SET @alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.part_catalog_map_r_supplier DROP FOREIGN KEY fk_supplier_supplier_id;');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Remove Foreign Key Constraint(s) for material_detail_default.part_catalog_map_id to part_catalog_map.part_catalog_map_id
SET @alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.material_detail_default DROP FOREIGN KEY fk_part_catalog_map_part_catalog_map_id;');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

#
#   DROP TABLES - Fulfiller Relationship related tables
# 

# DROP TABLE production_agreement;
SET @alterstatement=CONCAT('DROP TABLE IF EXISTS ',@SourceDBName,'.production_agreement');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# DROP TABLE agreed_relation;
SET @alterstatement=CONCAT('DROP TABLE IF EXISTS ',@SourceDBName,'.agreed_relation');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# DROP TABLE importer_of_record;
SET @alterstatement=CONCAT('DROP TABLE IF EXISTS ',@SourceDBName,'.importer_of_record');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

#
#   DROP TABLES - TCI related tables
# 

# DROP TABLE customs_part;
SET @alterstatement=CONCAT('DROP TABLE IF EXISTS ',@SourceDBName,'.customs_part');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# DROP TABLE part_catalog_map;
SET @alterstatement=CONCAT('DROP TABLE IF EXISTS ',@SourceDBName,'.part_catalog_map');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# DROP TABLE catalog_type;
SET @alterstatement=CONCAT('DROP TABLE IF EXISTS ',@SourceDBName,'.catalog_type');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# DROP TABLE part_catalog_map_r_supplier;
SET @alterstatement=CONCAT('DROP TABLE IF EXISTS ',@SourceDBName,'.part_catalog_map_r_supplier');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

#
#   DROP TABLES - Border Manifest related tables 
# 

# DROP TABLE material_detail;
SET @alterstatement=CONCAT('DROP TABLE IF EXISTS ',@SourceDBName,'.material_detail');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# DROP TABLE material_detail_default;
SET @alterstatement=CONCAT('DROP TABLE IF EXISTS ',@SourceDBName,'.material_detail_default');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# DROP TABLE supplier;
SET @alterstatement=CONCAT('DROP TABLE IF EXISTS ',@SourceDBName,'.supplier');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

#
#   DROP TABLES - Supplier related tables 
# 

# DROP TABLE customs_item;
SET @alterstatement=CONCAT('DROP TABLE IF EXISTS ',@SourceDBName,'.customs_item');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# DROP TABLE customs_shipment;
SET @alterstatement=CONCAT('DROP TABLE IF EXISTS ',@SourceDBName,'.customs_shipment');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# DROP TABLE customs_shipment_item;
SET @alterstatement=CONCAT('DROP TABLE IF EXISTS ',@SourceDBName,'.customs_shipment_item');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Turn Warning Messages = ON
SET sql_notes = 1;