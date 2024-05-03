/*
================
	INSERT
================

Users should be able to insert any valid values into the RequestSaves, 
Ingredient, Allergy and Publishes tables. When the foreign key value 
does not exist the operation should be rejected and an appropriate 
error message returned to the user. 
*/

-- RequestSaves

-- logID and date does not recieve user input.
INSERT INTO RequestSaves (mealType, dietaryGuideline)
VALUES (:mealtype, :dietaryGuideline);

-- Ingredient
INSERT INTO Ingredient 
VALUES (:ingName, :foodGroup);

-- Allergy
INSERT INTO Allergy 
VALUES (:allergyName, :severity);

-- Publishes

-- userID and date do not recieve user input.
INSERT into Publishes (recipeName)
VALUES (:recipeName);

/*
================
	UPDATE
================

The user should be able to edit non-primary key attributes in a relation,
for relations with at least two non-primary key attribute (eg. User, ReviewMakesHas). 

The relation used for the update operation must have at least two non-primary key 
attributes. At least one non-primary key attribute must have either a UNIQUE constraint
or be a foreign key that references another table.

The GUI should present the tuples that are available so that the user can select which 
tuple they want to update.
*/

-- The user changes the status of a favorite review.
UPDATE ReviewMakesHas RMH
SET	RMH.favorite = :status
WHERE RMH.recipeName = :recipeName
	AND userID IN (
		SELECT U5.userId
		FROM User_5 U5
		WHERE userId = :userID);
		
-- The user changes their email, name, address, or phone number
UPDATE User_5 U
SET U.email = :email, U.name = :name, U.address = :address, U.phoneNum = :phoneNum
WHERE U.userId = :userID;

UPDATE RequestSaves RS
SET	RS.:field = :newValue
WHERE RMH.:field = :oldValue;

/*
================
	DELETE
================

Implement a cascade-on-delete -> on delete set null situation. The user should be able to choose what values
to delete (eg. deleting a Request).
*/

DELETE
FROM RequestSaves RS
WHERE RS.mealType = :mealType AND RS.dietaryGuideline = :dietGuide;

/*
================
	DIVISION
================

Create one (preset) division query and provide an interface (button) for the user to 
execute this query. Query should execute against the most up to date version of the 
database.
*/

/*	
	Find all students that have all allergies (sucks for them) 
	Select Student S such that there is no Allergy A which S does not have.
	
	Subquery after NOT EXISTS are the allergies that the student does not have,
	so if there are no allergies that the Student does not have, NOT EXISTS
	returns true, and we get all students that have all allergies.
*/

SELECT S.userId
FROM Student S
WHERE NOT EXISTS ((SELECT A.allergyName				-- All allergies
				   FROM Allergy A)
				   MINUS
				   (SELECT A2.allergyName			-- Allergies that user has
					FROM AllergicTo A2
					WHERE A2.userId = S.userId));

/*
	Find all recipes with two certain ingredients (ingredientName)
	Select RecipeContains C such that the two given ingredients are found within the recipe.
*/

SELECT C1.recipeName
FROM RecipeContains C1
WHERE NOT EXISTS (
    (SELECT ingredientName
     FROM RecipeIngredient
     WHERE ingredientName = :ingName1 OR ingredientName = :ingName2)
    MINUS
    (SELECT C2.ingredientName
    FROM RecipeContains C2
    WHERE C1.recipeName = C2.recipeName));


/*
	Find all recipes for which you have all ingredients.
*/

SELECT DISTINCT C1.recipeName
FROM RecipeContains C1
WHERE NOT EXISTS (
    (SELECT ingName
     FROM Has
     WHERE userId = :userId)
    MINUS
    (SELECT C2.ingredientName
    FROM RecipeContains C2
    WHERE C1.recipeName = C2.recipeName));
/*
================
	SELECTION
================

The user is able to specify the filtering conditions for a given table.
That is, the user is able to determine what shows up in the WHERE clause (equalities only).

The user should be allowed to search for tuples using any number of AND/OR clauses using a dropdown.
*/

SELECT *
FROM RequestSaves
WHERE :clause;      -- in correct SQL format (AND, OR, NOT) with equalities

SELECT *
FROM RecipeMatches_1 r1 NATURAL JOIN RecipeMatches_2 r2
WHERE :clause; -- clause in correct SQL format (AND, OR, NOT) with equalities

/*
===================
	PROJECTION
===================

The user is able to choose any number of attributes to view from any relation in the database.
Non-selected attributes must not appear in the result,
and the database should be accessed for each query (needs to be fully up to date).
All tables should appear in a dropdown for users.

One or more tables must contain at least four attributes (eg. User).

*/

SELECT :fields      -- comma separated fields
FROM RECIPEINGREDIENT;  -- more than 4 options

SELECT :fields      -- comma separated fields
FROM :table;        -- any other table should be allowed

describe :table;

-- get all tables in DB (** need to first get rid of all of the others)
SELECT TABLE_NAME
FROM USER_TABLES;

/*
===================
	JOIN
===================

Users can use a query which joins at least 2 tables
and performs a meaningful query through the GUI.

Joins the two tables together then allows for the user to add their clause

finds the recipes with some condition on their ingredient (= some ingredient, allergen etc)
*/

SELECT *
FROM RECIPECONTAINS rc, RECIPEINGREDIENT r
WHERE rc.INGREDIENTNAME = r.INGREDIENTNAME AND :clause;

/*
==================================
	AGGREGATION (GROUP BY)
==================================

Create one query with aggregation (min, max, average, or count are all fine),
and a button/dropdown (preset options) to perform the aggregation through the GUI.

User can get the recipe with the most ingredients

*/

SELECT r.recipeName, MAX(Distinct r.ingredientName)
FROM RECIPECONTAINS r
GROUP BY r.recipeName;

/*
==================================
	AGGREGATION (HAVING)
==================================

Create one query with the HAVING clause (preset)
that the user can execute through the GUI (button).

User can see how many recipes have 5 or fewer ingredients.
*/

SELECT r.RECIPENAME, COUNT(r.INGREDIENTNAME) AS numIngredients
FROM RECIPECONTAINS r
GROUP BY r.RECIPENAME
HAVING COUNT(r.INGREDIENTNAME) <= 5;

/*
==================================
	NESTED AGGREGATION
==================================

Create one query that finds some aggregated value for each group
(e.g., use a nested subquery, will be preset).
This must be different from the aggregation query and
the user should be able to make the query from the GUI.

User can find the ingredient that is in the most recipes.

*/

SELECT r.INGREDIENTNAME, COUNT(Distinct r.RECIPENAME) AS numRecipes
FROM RECIPECONTAINS r
GROUP BY r.INGREDIENTNAME
HAVING COUNT(Distinct r.RECIPENAME) >= ALL (SELECT COUNT(Distinct RECIPENAME)
                                            FROM RECIPECONTAINS
                                            GROUP BY r.INGREDIENTNAME);
