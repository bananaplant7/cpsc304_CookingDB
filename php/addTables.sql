CREATE TABLE RequestSaves (
                              mealType          	VARCHAR(50),
                              dietaryGuideline 		VARCHAR(50),
                              logId             	VARCHAR(50)     UNIQUE,
                              requestDate           VARCHAR(50),
                              PRIMARY KEY (mealType, dietaryGuideline)
);

CREATE TABLE RecipeMatches_2 (
                                 mealType			VARCHAR(50)     PRIMARY KEY,
                                 meal          		VARCHAR(50)
);

CREATE TABLE RecipeMatches_1 (
                                 recipeName         	VARCHAR(50)    PRIMARY KEY,
                                 vegetarian         	INTEGER,
                                 mealType           	VARCHAR(50),
                                 dietaryGuideline   	VARCHAR(50),
                                 CONSTRAINT CHK_veg CHECK (vegetarian IN (0, 1)),
                                 FOREIGN KEY (mealType) REFERENCES RecipeMatches_2(mealType)
                                     ON DELETE CASCADE,
                                 FOREIGN KEY (mealType, dietaryGuideline) REFERENCES RequestSaves
                                     ON DELETE SET NULL
);

CREATE TABLE RecipeIngredient (
                                  ingredientName    	    VARCHAR(50)    PRIMARY KEY,
                                  foodGroup         		VARCHAR(50),
                                  allergen          		INTEGER,
                                  substitution      		VARCHAR(50),
                                  CONSTRAINT CHK_allergen CHECK (allergen IN (0, 1))
);

CREATE TABLE RecipeContains (
                                ingredientName    	VARCHAR(50),
                                recipeName       		VARCHAR(50),
                                unit              		VARCHAR(20)     NOT NULL,
                                quantity          		INTEGER         NOT NULL,
                                PRIMARY KEY (ingredientName, recipeName),
                                FOREIGN KEY (ingredientName) REFERENCES RecipeIngredient
                                    ON DELETE CASCADE,
                                FOREIGN KEY (recipeName) REFERENCES RecipeMatches_1
                                    ON DELETE CASCADE
);

CREATE TABLE User_2 (
                        phoneNum          VARCHAR(50)    PRIMARY KEY,
                        country           VARCHAR(50)
);

CREATE TABLE User_4 (
                        postalCode       	VARCHAR(50)    PRIMARY KEY,
                        city              	VARCHAR(50)
);

CREATE TABLE User_6 (
                        address             	VARCHAR(50)		PRIMARY KEY,
                        postalCode          	VARCHAR(50),
                        FOREIGN KEY (postalCode) REFERENCES User_4
                            ON DELETE CASCADE
);

CREATE TABLE User_5 (
                        userId            	VARCHAR(50)    PRIMARY KEY,
                        email             	VARCHAR(50)    UNIQUE,
                        name             	VARCHAR(50),
                        address             VARCHAR(50),
                        phoneNum	        VARCHAR(50),
                        FOREIGN KEY (phoneNum) REFERENCES User_2
                            ON DELETE SET NULL,
                        FOREIGN KEY (address) REFERENCES User_6
                            ON DELETE SET NULL
);

CREATE TABLE ReviewMakesHas (
                                reviewDate          VARCHAR(50),
                                rating            	INTEGER,
                                recipeName        	VARCHAR(50),
                                userId            	VARCHAR(50),
                                favorite         	INTEGER,
                                CONSTRAINT CHK_favorite CHECK (favorite IN (0, 1)),
                                PRIMARY KEY (reviewDate, rating, recipeName),
                                FOREIGN KEY (recipeName) REFERENCES RecipeMatches_1
                                    ON DELETE CASCADE,
                                FOREIGN KEY (userId) REFERENCES User_5
                                    ON DELETE CASCADE
);

CREATE TABLE Author (
                        userId            		VARCHAR(50)    PRIMARY KEY,
                        verificationStatus 		INTEGER,
                        CONSTRAINT CHK_vStatus CHECK (verificationStatus IN (0, 1)),
                        FOREIGN KEY (userId) REFERENCES User_5
                            ON DELETE CASCADE
);

CREATE TABLE Student (
                         userId            	VARCHAR(50)    PRIMARY KEY,
                         major             	VARCHAR(50),
                         FOREIGN KEY (userId) REFERENCES User_5
                             ON DELETE CASCADE
);

CREATE TABLE Ingredient (
                            ingName           	VARCHAR(50)     PRIMARY KEY,
                            foodGroup         	VARCHAR(50)
);

CREATE TABLE Allergy (
                         allergyName       	VARCHAR(50)     PRIMARY KEY,
                         severe          	INTEGER,
                         CONSTRAINT CHK_severe CHECK (severe IN (0, 1))
);

CREATE TABLE Publishes (
                           userId            	VARCHAR(50),
                           recipeName  			VARCHAR(50),
                           publishingDate       VARCHAR(50),
                           PRIMARY KEY (userId, recipeName),
                           FOREIGN KEY (userId) REFERENCES Author
                               ON DELETE CASCADE,
                           FOREIGN KEY (recipeName) REFERENCES RecipeMatches_1
                               ON DELETE CASCADE
);

CREATE TABLE Creates (
                         userId            		VARCHAR(50),
                         ingName           		VARCHAR(50),
                         allergyName       		VARCHAR(50),
                         mealType         	 	VARCHAR(50),
                         dietaryGuideline  		VARCHAR(50),
                         PRIMARY KEY (userId, mealType, dietaryGuideline, ingName, allergyName),
                         FOREIGN KEY (userId) REFERENCES Student
                             ON DELETE CASCADE,
                         FOREIGN KEY (mealType, dietaryGuideline) REFERENCES RequestSaves
                             ON DELETE CASCADE,
                         FOREIGN KEY (ingName) REFERENCES Ingredient
                             ON DELETE CASCADE,
                         FOREIGN KEY (allergyName) REFERENCES Allergy(allergyName)
                             ON DELETE CASCADE
);

CREATE TABLE Has (
                     userId            		VARCHAR(50),
                     ingName           		VARCHAR(50),
                     PRIMARY KEY (ingName, userId),
                     FOREIGN KEY (ingName) REFERENCES Ingredient
                         ON DELETE CASCADE,
                     FOREIGN KEY (userId) REFERENCES Student
                         ON DELETE CASCADE
);

CREATE TABLE AllergicTo (
                            userId            		VARCHAR(50),
                            allergyName       		VARCHAR(50),
                            PRIMARY KEY (allergyName, userId),
                            FOREIGN KEY (allergyName) REFERENCES Allergy
                                ON DELETE CASCADE,
                            FOREIGN KEY (userId) REFERENCES Student
                                ON DELETE CASCADE
);