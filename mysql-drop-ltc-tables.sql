#
#  READ ME:  The following script will DROP FORIEGN KEY CONSTRAINTS then DROP the TABLES
# be sure to set the below @SourceDBName to the correct Database Name
#


# Turn Warning Messages = OFF
SET sql_notes = 0;


# Define the database you want to create the tables in
SET @SourceDBName='dev';

#
#   REMOVE FOREIGN KEY ( catalog_type_id ) REFERENCES catalog_type ( catalog_type_id )  
#

# Remove Foriegn Key Constraint(s) for part_catalog_map.catalog_type_id to catalog_part.catalog_type_id
SET @alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.part_catalog_map DROP FOREIGN KEY fk_catalog_type_catalog_type_id;');
SELECT @alterstatement;
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Remove Foriegn Key Constraint(s) for part_catalog_map_r_supplier.part_catalog_map_id to part_catalog_map.part_catalog_map_id
SET @alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.part_catalog_map_r_supplier DROP FOREIGN KEY fk_part_catalog_map_part_catalog_map_id_1;');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Remove Foriegn Key Constraint(s) for customs_part.part_catalog_map_id to part_catalog_map.part_catalog_map_id
SET @alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.customs_part DROP FOREIGN KEY fk_part_catalog_map_part_catalog_map_id_2;');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Remove Foriegn Key Constraint(s) for material_detail.supplier_id to supplier.supplier_id
SET @alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.material_detail DROP FOREIGN KEY fk_supplier_supplier_id_1;');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Remove Foriegn Key Constraint(s) for material_detail_default.supplier_id to supplier.supplier_id
SET @alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.material_detail_default DROP FOREIGN KEY fk_supplier_supplier_id_2;');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Remove Foriegn Key Constraint(s) for agreed_relation.production_agreement_id to product_agreement.product_agreement_id
SET @alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.agreed_relation DROP FOREIGN KEY fk_production_agreement_production_agreement_id_1;');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Remove Foriegn Key Constraint(s) for importer_of_record.agreed_relation_id to agreed_relation.agreed_relation_id
SET @alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.importer_of_record DROP FOREIGN KEY fk_agreed_relation_agreed_relation_id;');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Remove Foriegn Key Constraint(s) for material_detail_default.part_catalog_map_id to part_catalog_map.part_catalog_map_id
SET @alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.material_detail_default DROP FOREIGN KEY fk_part_catalog_map_part_catalog_map_id;');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Remove Foriegn Key Constraint(s) for customs_part.production_agreement_id to production_agreement.production_agreement_id
SET @alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.customs_part DROP FOREIGN KEY fk_production_agreement_production_agreement_id_2;');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Remove Foriegn Key Constraint(s) for customs_item.customs_part_key to customs_part.customs_part_key
SET @alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.customs_item DROP FOREIGN KEY fk_customs_part_customs_part_key;');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Remove Foriegn Key Constraint(s) for customs_shipment_item.customs_item_id to customs_item.customs_item_id
SET @alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.customs_shipment_item DROP FOREIGN KEY fk_customs_item_customs_item_id;');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# Remove Foriegn Key Constraint(s) for customs_shipment.customs_shipment_item_id to customs_shipment_item.customs_shipmnet_item_id
SET @alterstatement=CONCAT('ALTER TABLE ',@SourceDBName,'.customs_shipment DROP FOREIGN KEY fk_customs_shipment_item_customs_shipment_item_id;');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

#
#   DROP TABLES
#

# DROP TABLE agreed_relation;
SET @alterstatement=CONCAT('DROP TABLE ',@SourceDBName,'.agreed_relation');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# DROP TABLE catalog_type;
SET @alterstatement=CONCAT('DROP TABLE ',@SourceDBName,'.catalog_type');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# DROP TABLE customs_item;
SET @alterstatement=CONCAT('DROP TABLE ',@SourceDBName,'.customs_item');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# DROP TABLE customs_part;
SET @alterstatement=CONCAT('DROP TABLE ',@SourceDBName,'.customs_part');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# DROP TABLE customs_shipment;
SET @alterstatement=CONCAT('DROP TABLE ',@SourceDBName,'.customs_shipment');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# DROP TABLE customs_shipment_item;
SET @alterstatement=CONCAT('DROP TABLE ',@SourceDBName,'.customs_shipment_item');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# DROP TABLE importer_of_record;
SET @alterstatement=CONCAT('DROP TABLE ',@SourceDBName,'.importer_of_record');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# DROP TABLE material_detail;
SET @alterstatement=CONCAT('DROP TABLE ',@SourceDBName,'.material_detail');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# DROP TABLE material_detail_default;
SET @alterstatement=CONCAT('DROP TABLE ',@SourceDBName,'.material_detail_default');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# DROP TABLE part_catalog_map;
SET @alterstatement=CONCAT('DROP TABLE ',@SourceDBName,'.part_catalog_map');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# DROP TABLE part_catalog_map_r_supplier;
SET @alterstatement=CONCAT('DROP TABLE ',@SourceDBName,'.part_catalog_map_r_supplier');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# DROP TABLE production_agreement;
SET @alterstatement=CONCAT('DROP TABLE ',@SourceDBName,'.production_agreement');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;

# DROP TABLE supplier;
SET @alterstatement=CONCAT('DROP TABLE ',@SourceDBName,'.supplier');
PREPARE executionstatement FROM @alterstatement;
EXECUTE executionstatement;


# Turn Warning Messages = ON
SET sql_notes = 1;