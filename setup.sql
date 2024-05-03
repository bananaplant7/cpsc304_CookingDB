--
--      Database Creation Script (cleanup, create and insert)
--
--  Drop existing tables first. Errors are ignored.

DROP TABLE RecipeMatches_2 CASCADE CONSTRAINTS;
DROP TABLE RecipeMatches_1 CASCADE CONSTRAINTS;
DROP TABLE RecipeIngredient CASCADE CONSTRAINTS;
DROP TABLE RecipeContains CASCADE CONSTRAINTS;
DROP TABLE ReviewMakesHas CASCADE CONSTRAINTS;
DROP TABLE RequestSaves CASCADE CONSTRAINTS;
DROP TABLE User_5 CASCADE CONSTRAINTS;
DROP TABLE User_6 CASCADE CONSTRAINTS;
DROP TABLE User_2 CASCADE CONSTRAINTS;
DROP TABLE User_4 CASCADE CONSTRAINTS;
DROP TABLE Author CASCADE CONSTRAINTS;
DROP TABLE Student CASCADE CONSTRAINTS;
DROP TABLE Ingredient CASCADE CONSTRAINTS;
DROP TABLE Allergy CASCADE CONSTRAINTS;
DROP TABLE Publishes CASCADE CONSTRAINTS;
DROP TABLE Has CASCADE CONSTRAINTS;
DROP TABLE AllergicTo CASCADE CONSTRAINTS;
DROP TABLE Creates CASCADE CONSTRAINTS;

-- Create each table

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

-- Vegetarian only 1 or 0 TODO add check
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

-- Allergen is only 1 or 0 TODO add check

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
                        email             	VARCHAR(50)     UNIQUE,
                        name             	VARCHAR(50),
                        address             VARCHAR(50),
                        phoneNum	        VARCHAR(50),
                        FOREIGN KEY (phoneNum) REFERENCES User_2
                            ON DELETE SET NULL,
                        FOREIGN KEY (address) REFERENCES User_6
                            ON DELETE SET NULL
);

-- Favorite only 1 or 0 TODO add check
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

-- verification status only 1 or 0 TODO add check
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

-- severe only 1 or 0 TODO add check
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

-- Insert values into each table

-- First set of values

INSERT INTO RequestSaves VALUES ('Dessert', 'Vegetarian', '24df23sdaf4565fds3', '2024/02/29');

INSERT INTO RecipeMatches_2 VALUES ('Dessert', 'Dessert');

INSERT INTO RecipeMatches_1 VALUES ('Cheesecake', 1, 'Dessert', 'Vegetarian');

INSERT INTO RecipeIngredient VALUES ('Philadelphia Original Brick Cream Cheese', 'Dairy', 1, '(Vegan) Nut-based Cream Cheese');

INSERT INTO RecipeContains VALUES ('Philadelphia Original Brick Cream Cheese', 'Cheesecake', 'Grams', 910);

INSERT INTO User_2 VALUES ('+1 (123) 456-7890', 'Canada');

INSERT INTO User_4 VALUES ('V8A6E5', 'Powell River');

INSERT INTO User_6 VALUES ('169 Smoky Hollow Ave', 'V8A6E5');

INSERT INTO User_5 VALUES ('auth15sad1fa415df1', 'john-doe@gmail.com', 'John Doe', '169 Smoky Hollow Ave', '+1 (123) 456-7890');

INSERT INTO User_2 VALUES ('+1 (555) 123-4567', 'USA');

INSERT INTO User_4 VALUES ('12345', 'Springfield');

INSERT INTO User_6 VALUES ('170 Smoky Hollow Ave', '12345');

INSERT INTO User_5 VALUES ('stuas4df656a4f6as4f', 'john@example.com', 'John Smith', '170 Smoky Hollow Ave', '+1 (555) 123-4567');

INSERT INTO Author VALUES ('auth15sad1fa415df1', 1);

INSERT INTO Student VALUES ('stuas4df656a4f6as4f', 'Computer Science');

INSERT INTO Ingredient VALUES ('Lactose-free Milk', 'Dairy');

INSERT INTO Allergy VALUES ('Lactose-Intolerance', 0);

INSERT INTO Publishes VALUES ('auth15sad1fa415df1', 'Cheesecake', '2024/02/29');

INSERT INTO Has VALUES ('stuas4df656a4f6as4f', 'Lactose-free Milk');

INSERT INTO AllergicTo VALUES ('stuas4df656a4f6as4f', 'Lactose-Intolerance');

INSERT INTO ReviewMakesHas VALUES ('2024/02/29', 8, 'Cheesecake', 'stuas4df656a4f6as4f', 1);

INSERT INTO Creates VALUES ('stuas4df656a4f6as4f', 'Lactose-free Milk', 'Lactose-Intolerance', 'Dessert', 'Vegetarian');

-- Second value insert

INSERT INTO RequestSaves VALUES ('Dinner', 'Meat', '25d563sdaf4565fds3', '2024/02/29');

INSERT INTO RecipeMatches_2 VALUES ('Dinner', 'Dinner');

INSERT INTO RecipeMatches_1 VALUES ('Pizza', 0, 'Dinner', 'Meat');

INSERT INTO RecipeIngredient VALUES ('Pepperoni', 'Meat', 0, NULL);

INSERT INTO RecipeContains VALUES ('Pepperoni', 'Pizza', 'Ounce', 6);

INSERT INTO User_2 VALUES ('+1 (123) 845-7890', 'United States');

INSERT INTO User_4 VALUES ('75115', 'Everett');

INSERT INTO User_6 VALUES ('249 W. Hawthorne Court Desoto', '75115');

INSERT INTO User_5 VALUES ('stu2666653a45ec23', 'jane-doe@gmail.com', 'Jane Doe', '249 W. Hawthorne Court Desoto', '+1 (123) 845-7890');

INSERT INTO User_2 VALUES ('+1 (123) 845-8890', 'United States');

INSERT INTO User_4 VALUES ('75136', 'Everett');

INSERT INTO User_6 VALUES ('250 W. Hawthorne Court Desoto', '75136');

INSERT INTO User_5 VALUES ('auth2666653a45ec23', 'jane-doe_2@gmail.com', 'Jane Doe', '250 W. Hawthorne Court Desoto', '+1 (123) 845-8890');

INSERT INTO Author VALUES ('auth2666653a45ec23', 0);

INSERT INTO Student VALUES ('stu2666653a45ec23', 'Statistics');

INSERT INTO Ingredient VALUES ('Cheese', 'Dairy');

INSERT INTO Allergy VALUES ('Milk', 1);

INSERT INTO Publishes VALUES ('auth2666653a45ec23', 'Pizza', '2024/03/01');

INSERT INTO Has VALUES ('stu2666653a45ec23', 'Cheese');

INSERT INTO AllergicTo VALUES ('stu2666653a45ec23', 'Milk');

INSERT INTO ReviewMakesHas VALUES ('2024/03/01', 7, 'Pizza', 'stu2666653a45ec23', 0);

INSERT INTO Creates VALUES ('stu2666653a45ec23', 'Cheese', 'Milk', 'Dinner', 'Meat');

-- Third value insert

INSERT INTO RequestSaves VALUES ('Lunch', 'Meat', '25d589sdaf4565fds3', '2023/12/15');

INSERT INTO RecipeMatches_2 VALUES ('Lunch', 'Lunch');

INSERT INTO RecipeMatches_1 VALUES ('Ham Sandwich', 0, 'Lunch', 'Meat');

INSERT INTO RecipeIngredient VALUES ('Ham', 'Meat', 1, 'Veggie ham');

INSERT INTO RecipeContains VALUES ('Ham', 'Ham Sandwich', 'Slices', 12);

INSERT INTO User_2 VALUES ('+1 (123) 845-7660', 'United States');

INSERT INTO User_4 VALUES ('98105', 'Seattle');

INSERT INTO User_6 VALUES ('4264 Union Street', '98105');

INSERT INTO User_5 VALUES ('stu2666653a45ae23', 'alan-wake@gmail.com', 'Alan Wake', '4264 Union Street', '+1 (123) 845-7660');

INSERT INTO User_2 VALUES ('+1 (123) 844-7660', 'United States');

INSERT INTO User_4 VALUES ('98505', 'Seattle');

INSERT INTO User_6 VALUES ('4364 Union Street', '98505');

INSERT INTO User_5 VALUES ('auth2666653a45ae23', 'alan-wake_2@gmail.com', 'Alan Wake', '4364 Union Street', '+1 (123) 844-7660');

INSERT INTO Author VALUES ('auth2666653a45ae23', 1);

INSERT INTO Student VALUES ('stu2666653a45ae23', 'Creative Writing');

INSERT INTO Ingredient VALUES ('Bread', 'Grains');

INSERT INTO Allergy VALUES ('Eggs', 1);

INSERT INTO Publishes VALUES ('auth2666653a45ae23', 'Ham Sandwich', '2024/12/15');

INSERT INTO Has VALUES ('stu2666653a45ae23', 'Bread');

INSERT INTO AllergicTo VALUES ('stu2666653a45ae23', 'Eggs');

INSERT INTO ReviewMakesHas VALUES ('2023/12/15', 6, 'Ham Sandwich', 'stu2666653a45ae23', 0);

INSERT INTO Creates VALUES ('stu2666653a45ae23', 'Bread', 'Eggs', 'Lunch', 'Meat');

-- Fourth insert values

INSERT INTO RequestSaves VALUES ('Snack', 'Vegetarian', '25d579sdaf4565fds3', '2023/11/14');

INSERT INTO RecipeMatches_2 VALUES ('Snack', 'Snack');

INSERT INTO RecipeMatches_1 VALUES ('Taiyaki', 1, 'Snack', 'Vegetarian');

INSERT INTO RecipeIngredient VALUES ('Red beans', 'Legumes', 1, NULL);

INSERT INTO RecipeContains VALUES ('Red beans', 'Taiyaki', 'Grams', 250);

INSERT INTO User_2 VALUES ('+1 (123) 845-7930', 'United States');

INSERT INTO User_4 VALUES ('20019', 'Washington');

INSERT INTO User_6 VALUES ('427 Chaplin Street Southeast', '20019');

INSERT INTO User_5 VALUES ('stu2666863a45ec52', 'leon-s-kennedy@gmail.com', 'Leon Scott Kennedy', '427 Chaplin Street Southeast', '+1 (123) 845-7930');

INSERT INTO User_2 VALUES ('+1 (123) 849-7930', 'United States');

INSERT INTO User_4 VALUES ('20119', 'Washington');

INSERT INTO User_6 VALUES ('428 Chaplin Street Southeast', '20119');

INSERT INTO User_5 VALUES ('auth2666863a45ec52', 'leon-s-kennedy-auth@gmail.com', 'Leon Scott Kennedy', '428 Chaplin Street Southeast', '+1 (123) 849-7930');

INSERT INTO Author VALUES ('auth2666863a45ec52', 1);

INSERT INTO Student VALUES ('stu2666863a45ec52', 'Criminology');

INSERT INTO Ingredient VALUES ('Sugar', 'Carbohydrate');

INSERT INTO Allergy VALUES ('Shellfish', 1);

INSERT INTO Publishes VALUES ('auth2666863a45ec52', 'Taiyaki', '2024/11/14');

INSERT INTO Has VALUES ('stu2666863a45ec52', 'Sugar');

INSERT INTO AllergicTo VALUES ('stu2666863a45ec52', 'Shellfish');

INSERT INTO ReviewMakesHas VALUES ('2023/11/14', 9, 'Taiyaki', 'stu2666653a45ae23', 1);

INSERT INTO Creates VALUES ('stu2666863a45ec52', 'Sugar', 'Shellfish', 'Snack', 'Vegetarian');

-- Fifth set of values

INSERT INTO RequestSaves VALUES ('Lunch', 'Vegetarian', '32d579sdaf4565fds3', '2023/10/14');

-- no recipeMatches_2 needed (lunch already in table)

INSERT INTO RecipeMatches_1 VALUES ('Gimbap', 1, 'Lunch', 'Vegetarian');

INSERT INTO RecipeIngredient VALUES ('Rice', 'Grains', 0, NULL);

INSERT INTO RecipeContains VALUES ('Rice', 'Gimbap', 'Cups', 4);

INSERT INTO User_2 VALUES ('+1 (123) 845-7030', 'Canada');

INSERT INTO User_4 VALUES ('V6B 3K9', 'Vancouver');

INSERT INTO User_6 VALUES ('2102 Robson St', 'V6B 3K9');

INSERT INTO User_5 VALUES ('auth18sad1fa4056d2', 'cloud-strife@gmail.com', 'Cloud Strife', '2102 Robson St', '+1 (123) 845-7030');

INSERT INTO User_2 VALUES ('+1 (321) 846-7030', 'Canada');

INSERT INTO User_4 VALUES ('V6B 4K9', 'Vancouver');

INSERT INTO User_6 VALUES ('2103 Robson St', 'V6B 4K9');

INSERT INTO User_5 VALUES ('stuas4df677a4f6ba7f', 'cloud-strife2@gmail.com', 'Cloud Strife', '2103 Robson St', '+1 (321) 846-7030');

INSERT INTO Author VALUES ('auth18sad1fa4056d2', 1);

INSERT INTO Student VALUES ('stuas4df677a4f6ba7f', 'Astronomy');

INSERT INTO Ingredient VALUES ('Gim', 'Sea Vegetable');

INSERT INTO Allergy VALUES ('Peanut', 1);

INSERT INTO Publishes VALUES ('auth18sad1fa4056d2', 'Gimbap', '2024/11/19');

INSERT INTO Has VALUES ('stuas4df677a4f6ba7f', 'Gim');

INSERT INTO AllergicTo VALUES ('stuas4df677a4f6ba7f', 'Peanut');

INSERT INTO ReviewMakesHas VALUES ('2023/10/14', 7, 'Taiyaki', 'stu2666863a45ec52', 1);

INSERT INTO Creates VALUES ('stuas4df677a4f6ba7f', 'Gim', 'Peanut', 'Lunch', 'Vegetarian');


INSERT INTO RecipeIngredient VALUES ('Butter', 'Dairy', 1, 'Margarine');
INSERT INTO RecipeContains VALUES ('Butter', 'Taiyaki', 'Grams', 170);
INSERT INTO RecipeIngredient VALUES ('Milk', 'Dairy', 1, 'Lactose-Free Milk');
INSERT INTO RecipeContains VALUES ('Milk', 'Taiyaki', 'Grams', 155);
INSERT INTO RecipeIngredient VALUES ('Egg', 'Dairy', 1, 'Flax Egg');
INSERT INTO RecipeContains VALUES ('Egg', 'Taiyaki', 'Grams', 100);
INSERT INTO RecipeIngredient VALUES ('Sugar', 'Carbs', 0, NULL);
INSERT INTO RecipeContains VALUES ('Sugar', 'Taiyaki', 'Grams', 65);
INSERT INTO RecipeIngredient VALUES ('Flour', 'Carbs', 0, NULL);
INSERT INTO RecipeContains VALUES ('Flour', 'Taiyaki', 'Grams', 240);
INSERT INTO RecipeIngredient VALUES ('Soy Sauce', 'Carbs', 0, NULL);
INSERT INTO RecipeContains VALUES ('Soy Sauce', 'Taiyaki', 'Grams', 6);
INSERT INTO RecipeIngredient VALUES ('Vanilla Extract', 'Carbs', 0, NULL);
INSERT INTO RecipeContains VALUES ('Vanilla Extract', 'Taiyaki', 'Grams', 4);

INSERT INTO RecipeContains VALUES ('Vanilla Extract', 'Cheesecake', 'Grams', 4);
INSERT INTO RecipeContains VALUES ('Sugar', 'Cheesecake', 'Grams', 65);
INSERT INTO RecipeContains VALUES ('Egg', 'Cheesecake', 'Whole', 4);
INSERT INTO RecipeIngredient VALUES ('Sour Cream', 'Dairy', 1, NULL);
INSERT INTO RecipeContains VALUES ('Sour Cream', 'Cheesecake', 'Grams', 160);

INSERT INTO RecipeIngredient VALUES ('Cheese', 'Dairy', 1, 'Lactose-Free Cheese');
INSERT INTO RecipeContains VALUES ('Cheese', 'Pizza', 'Cups', 3);
INSERT INTO RecipeIngredient VALUES ('Dough', 'Carbs', 0, NULL);
INSERT INTO RecipeContains VALUES ('Dough', 'Pizza', 'Rolls', 1);

INSERT INTO RecipeIngredient VALUES ('Bread', 'Carbs', 0, NULL);
INSERT INTO RecipeContains VALUES ('Bread', 'Ham Sandwich', 'Slices', 2);

INSERT INTO RecipeIngredient VALUES ('Seaweed', 'Vegetable', 0, NULL);
INSERT INTO RecipeContains VALUES ('Seaweed', 'Gimbap', 'Sheets', 5);
INSERT INTO RecipeContains VALUES ('Soy Sauce', 'Gimbap', 'Grams', 6);
INSERT INTO RecipeIngredient VALUES ('Steak', 'Meat', 1, 'Tofu');
INSERT INTO RecipeContains VALUES ('Steak', 'Gimbap', 'Oz', 5);
INSERT INTO RecipeIngredient VALUES ('Spinach', 'Vegetable', 0, NULL);
INSERT INTO RecipeContains VALUES ('Spinach', 'Gimbap', 'Oz', 9);
INSERT INTO RecipeContains VALUES ('Egg', 'Gimbap', 'Whole', 3);

INSERT INTO Ingredient VALUES ('Ham', 'Meat');
INSERT INTO Has VALUES ('stu2666653a45ae23', 'Ham');