DELIMITER $$
/* =====================================================================

	Name:           spAddUpdateDelete_Plant
    Author:         John Murray
    Written:        4/08/20
    Purpose:        Add/Update/Delete data in Plant table
	Returns:		-1 if could not be deleted, 0 if deleted, otherwise returns plantId
					

    Edit History:   4/08/20 - John Murray
                        + Initial creation.
						          
======================================================================== */
DROP PROCEDURE IF EXISTS spAddUpdateDelete_Plant; 
CREATE PROCEDURE spAddUpdateDelete_Plant(IN plantId INT, IN division VARCHAR(64), IN class VARCHAR(64), IN p_order VARCHAR(64), IN family VARCHAR(64)
										, IN genus VARCHAR(64), IN species VARCHAR(64), IN variety VARCHAR(64), IN wantDeleted BIT)
BEGIN
	IF wantDeleted = 1 THEN -- Delete
		IF EXISTS(SELECT NULL FROM Plant WHERE Plant.plantId = plantId LIMIT 1) THEN
			-- Plant found
            
            IF EXISTS(	SELECT NULL 
						FROM PlantSubmission
                        WHERE PlantSubmission.plantId = plantId
                        LIMIT 1) THEN
				-- Soft Delete
                UPDATE Plant
                SET isDeleted = 1
                WHERE Plant.plantId = plantId;
                
			ELSE
				-- Hard Delete
				DELETE FROM Plant WHERE Plant.plantId = plantId;
                
            END IF;
            
            SELECT 0 as plantId;
        ELSE
			-- Plant not found
            SELECT -1 as plantId;
        END IF;
    ELSEIF plantId = 0 THEN -- Add
		INSERT INTO Plant (Plant.division, Plant.class, Plant.order, Plant.family, Plant.genus, Plant.species, Plant.variety)
        VALUES (division, class, p_order, family, genus, species, variety);
        SELECT LAST_INSERT_ID() AS plantId;
    ELSE					-- Update
		UPDATE Plant
        SET Plant.division = division, Plant.class = class, Plant.order = p_order, Plant.family = family, Plant.genus = genus, Plant.species = species, Plant.variety = variety
        WHERE Plant.plantId = plantId;
		
		SELECT plantId as plantId;
    END IF;
END $$



DELIMITER $$
/* =====================================================================

	Name:           spAddUpdateDelete_PlantSubmission
    Author:         John Murray
    Written:        4/08/20
    Purpose:        Add/Update/Delete data in PlantSubmission table
	Returns:		-1 if could not be deleted, 0 if deleted, otherwise returns plantSubmissionId
					

    Edit History:   4/08/20 - John Murray
                        + Initial creation.
						          
======================================================================== */
DROP PROCEDURE IF EXISTS spAddUpdateDelete_PlantSubmission; 
CREATE PROCEDURE spAddUpdateDelete_PlantSubmission(IN plantSubmissionId INT, IN userId INT, IN plantId INT, IN date DATETIME, IN location POINT, IN description VARCHAR(120), IN wantDeleted BIT)
BEGIN
	IF wantDeleted = 1 THEN -- Delete
		IF EXISTS(SELECT NULL FROM PlantSubmission WHERE PlantSubmission.plantSubmissionId = plantSubmissionId LIMIT 1) THEN
			-- PlantSubmission found
            
			-- Hard Delete
			DELETE FROM PlantSubmission WHERE PlantSubmission.plantSubmissionId = plantSubmissionId;

            SELECT 0 as plantSubmissionId;
        ELSE
			-- Plant not found
            SELECT -1 as plantSubmissionId;
        END IF;
    ELSEIF plantSubmissionId = 0 THEN -- Add
		INSERT INTO PlantSubmission (PlantSubmission.userId, PlantSubmission.plantId, PlantSubmission.date, PlantSubmission.location, PlantSubmission.description)
        VALUES (userId, plantId, date, location, description);
        SELECT LAST_INSERT_ID() AS plantSubmissionId;
    ELSE					-- Update
		UPDATE PlantSubmission
        SET PlantSubmission.userId = userId, PlantSubmission.plantId = plantId, PlantSubmission.date = date, PlantSubmission.location = location, PlantSubmission.description = description
        WHERE PlantSubmission.plantSubmissionId = plantSubmissionId;
		
		SELECT plantSubmissionId as plantSubmissionId;
    END IF;
END $$



DELIMITER $$
/* =====================================================================

	Name:           spSelectPlants
    Author:         John Murray
    Written:        4/08/20
    Purpose:        Searches through Plant table given various inputs
	Returns:		Query of search based on arguments
					

    Edit History:   4/08/20 - John Murray
                        + Initial creation.
						          
======================================================================== */
DROP PROCEDURE IF EXISTS spSelectPlants; 
CREATE PROCEDURE spSelectPlants(IN division VARCHAR(64), IN class VARCHAR(64), IN p_order VARCHAR(64), IN family VARCHAR(64)
										, IN genus VARCHAR(64), IN species VARCHAR(64), IN variety VARCHAR(64), IN orderBy VARCHAR(200))
BEGIN
	SET @que = "SELECT * FROM Plant p";
	SET @w = FALSE;
    
	IF (division != '') THEN
		SET @que = CONCAT(@que, " WHERE LOWER(division) LIKE '%", LOWER(division), "%'");
        SET @w = TRUE;
	END IF;
	
	IF (class != '') AND (@w = FALSE) THEN
		SET @que = CONCAT(@que, " WHERE LOWER(class) LIKE '%", LOWER(class), "%'");
        SET @w = TRUE;
	ELSEIF (class != '') THEN
		SET @que = CONCAT(@que, " AND LOWER(class) LIKE '%", LOWER(class), "%'");
	END IF;
    
    IF (p_order != '') AND (@w = FALSE) THEN
		SET @que = CONCAT(@que, " WHERE LOWER(p.order) LIKE '%", LOWER(p_order), "%'");
        SET @w = TRUE;
	ELSEIF (p_order != '') THEN
		SET @que = CONCAT(@que, " AND LOWER(p.order) LIKE '%", LOWER(p_order), "%'");
	END IF;
	
	IF (family != '') AND (@w = FALSE) THEN
		SET @que = CONCAT(@que, " WHERE LOWER(family) LIKE '%", LOWER(family), "%'");
        SET @w = TRUE;
	ELSEIF (family != '') THEN
		SET @que = CONCAT(@que, " AND LOWER(family) LIKE '%", LOWER(family), "%'");
	END IF;
	
	IF (genus != '') AND (@w = FALSE) THEN
		SET @que = CONCAT(@que, " WHERE LOWER(genus) LIKE '%", LOWER(genus), "%'");
        SET @w = TRUE;
	ELSEIF (genus != '') THEN
		SET @que = CONCAT(@que, " AND LOWER(genus) LIKE '%", LOWER(genus), "%'");
	END IF;
	
	IF (species != '') AND (@w = FALSE) THEN
		SET @que = CONCAT(@que, " WHERE LOWER(species) LIKE '%", LOWER(species), "%'");
        SET @w = TRUE;
	ELSEIF (species != '') THEN
		SET @que = CONCAT(@que, " AND LOWER(species) LIKE '%", LOWER(species), "%'");
	END IF;
	
	IF (variety != '') AND (@w = FALSE) THEN
		SET @que = CONCAT(@que, " WHERE LOWER(variety) LIKE '%", LOWER(variety), "%'");
        SET @w = TRUE;
	ELSEIF (variety != '') THEN
		SET @que = CONCAT(@que, " AND LOWER(variety) LIKE '%", LOWER(variety), "%'");
	END IF;
	
    
	IF (orderBy = '') THEN 
		SET orderBy = 'division';
	END IF;
	
	SET @que = CONCAT(@que, " ORDER BY ", orderBy);
	PREPARE q FROM @que;
	EXECUTE q;
	DEALLOCATE PREPARE q;
END $$
