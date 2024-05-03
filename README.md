# CookingDB
### project_f7k7c_v1r5b_w0i9i

The final product was a recipe database, that allowed for a user to add their ingredients and allergies, update and remove their user information. We also allowed to user to query recipes in our database based on their ingredients and the recipe ingredients.

Our final schema included all of our original tables, but not all of them are being used in our UI. We also made a couple of changes to the schema, including updating FKs on normalized relations so they're properly referring to each other and adding in constraints for our boolean values (which we had to make type INTEGER).

Please note that our project is implemented using PHP, and the code for it is under the php directory. All code under other directories is from separate attempts and can be disregarded.

## Milestones

* [Milestone I](https://github.students.cs.ubc.ca/CPSC304-2023W-T2/project_f7k7c_v1r5b_w0i9i/blob/df336102f7a98fff5bb35201cabf3ae533ce9e93/milestones/Milestone%201%20-%20Project%20Proposal,%20Conceptual%20Design%20ER%20Diagram.pdf)
* [Milestone II](https://github.students.cs.ubc.ca/CPSC304-2023W-T2/project_f7k7c_v1r5b_w0i9i/blob/df336102f7a98fff5bb35201cabf3ae533ce9e93/milestones/Milestone%202%20-%20Logical%20Design,%20RS,%20SQL%20DDL,%20Normalization,%20Query%20Design.pdf)
* [Milestone III](https://github.students.cs.ubc.ca/CPSC304-2023W-T2/project_f7k7c_v1r5b_w0i9i/blob/df336102f7a98fff5bb35201cabf3ae533ce9e93/milestones/Milestone%203%20-%20Project%20Check%20In.pdf)

## Cover Page
[Link to Cover Page](https://github.students.cs.ubc.ca/CPSC304-2023W-T2/project_f7k7c_v1r5b_w0i9i/blob/main/Milestone%204%20Cover%20page.pdf)

## Setup script

* [Setup](https://github.students.cs.ubc.ca/CPSC304-2023W-T2/project_f7k7c_v1r5b_w0i9i/blob/main/setup.sql)
* [Data after setup script is run](https://github.students.cs.ubc.ca/CPSC304-2023W-T2/project_f7k7c_v1r5b_w0i9i/tree/main/setup.sql%20data)

## Rubric Items:
* INSERT: We allow for insertion into the Has or AllergicTo tables, and if the FK is missing we add that in as well. [Code link for ingredient](https://github.students.cs.ubc.ca/CPSC304-2023W-T2/project_f7k7c_v1r5b_w0i9i/blob/efff9e871d59dab745ce03c5e05a64a49b40bc38/php/oracle-test.php#L578)
![Screenshot 2024-04-05 at 11 16 49 PM](https://media.github.students.cs.ubc.ca/user/16224/files/b982421d-6a42-4f22-b63b-9a0ba13479e6)
![Screenshot 2024-04-05 at 11 17 21 PM](https://media.github.students.cs.ubc.ca/user/16224/files/fb3f163a-843c-4e57-8eb7-f0761dd1df37)

* DELETE: We allow for deletion of phone number and address, which deletes their respective tuples and creates a cascade on delete (set null) situation for the table we display. [Link to Code](https://github.students.cs.ubc.ca/CPSC304-2023W-T2/project_f7k7c_v1r5b_w0i9i/blob/efff9e871d59dab745ce03c5e05a64a49b40bc38/php/oracle-test.php#L491)
![Screenshot 2024-04-05 at 11 18 59 PM](https://media.github.students.cs.ubc.ca/user/16224/files/1cad8fc7-e015-4554-b838-82ec98baa368)
![Screenshot 2024-04-05 at 11 21 07 PM](https://media.github.students.cs.ubc.ca/user/16224/files/166f96dd-a86a-4585-b3ea-6b571b813e5b)

* UPDATE: User can update the non-primary keys related to its profile values. Email is unique, and phone number and address are FKs. They will be rejected if they do not adhere to their constraints. [Link to Code](https://github.students.cs.ubc.ca/CPSC304-2023W-T2/project_f7k7c_v1r5b_w0i9i/blob/efff9e871d59dab745ce03c5e05a64a49b40bc38/php/oracle-test.php#L474)
![Screenshot 2024-04-05 at 11 23 43 PM](https://media.github.students.cs.ubc.ca/user/16224/files/0ea2bf9e-89fd-4fca-b10e-f1bcb60187c0)
![Screenshot 2024-04-05 at 11 27 35 PM](https://media.github.students.cs.ubc.ca/user/16224/files/a28505be-4e90-4f56-a4e8-0dde5b1c578c)

* SELECTION: User can provide where clause to query recipe matches. Example is for vegetarian = 1. [Link to Code](https://github.students.cs.ubc.ca/CPSC304-2023W-T2/project_f7k7c_v1r5b_w0i9i/blob/9b352d9034ddd1eb6caed3f4e4391b19eed89c2c/php/oracle-test.php#L670)
![Screenshot 2024-04-05 at 11 56 53 PM](https://media.github.students.cs.ubc.ca/user/16224/files/cf9a320e-468f-4191-a27e-cee48b0b30fe)


* PROJECTION: User can project onto any table on the DB, using a comma separated list of values. Screenshots for the REQUESTSAVES relation. [Link to Code](https://github.students.cs.ubc.ca/CPSC304-2023W-T2/project_f7k7c_v1r5b_w0i9i/blob/efff9e871d59dab745ce03c5e05a64a49b40bc38/php/oracle-test.php#L666)
![Screenshot 2024-04-05 at 11 29 50 PM](https://media.github.students.cs.ubc.ca/user/16224/files/9a8286d4-f88d-4448-b03b-4dd6bbd5b040)
![Screenshot 2024-04-05 at 11 30 17 PM](https://media.github.students.cs.ubc.ca/user/16224/files/c89337ce-ccb5-43ab-8c40-a0ad17d9d9e3)
![Screenshot 2024-04-05 at 11 30 54 PM](https://media.github.students.cs.ubc.ca/user/16224/files/724efb1c-9119-41c6-a626-ca027bc4d83c)

* GROUP BY: User can see the number of recipes each ingredient is in. [Link to Code](https://github.students.cs.ubc.ca/CPSC304-2023W-T2/project_f7k7c_v1r5b_w0i9i/blob/efff9e871d59dab745ce03c5e05a64a49b40bc38/php/oracle-test.php#L457)
![Screenshot 2024-04-05 at 11 32 23 PM](https://media.github.students.cs.ubc.ca/user/16224/files/5fdc5b75-9043-4632-af01-a8e77b233f11)

* HAVING: User can see the recipes with fewer than 5 ingredients in them. [Link to Code](https://github.students.cs.ubc.ca/CPSC304-2023W-T2/project_f7k7c_v1r5b_w0i9i/blob/efff9e871d59dab745ce03c5e05a64a49b40bc38/php/oracle-test.php#L438)
![Screenshot 2024-04-05 at 11 34 06 PM](https://media.github.students.cs.ubc.ca/user/16224/files/2c1272e3-5b0f-4bc8-ba4c-adb69b26a5bc)

* NESTED: User can see which ingredient is in the most recipes. [Link to Code](https://github.students.cs.ubc.ca/CPSC304-2023W-T2/project_f7k7c_v1r5b_w0i9i/blob/efff9e871d59dab745ce03c5e05a64a49b40bc38/php/oracle-test.php#L418)
![Screenshot 2024-04-05 at 11 35 15 PM](https://media.github.students.cs.ubc.ca/user/16224/files/c3a3fdad-2096-4215-ad89-66072c1a39e7)

* DIVISION: User can see which recipe they have all ingredients for. [Link to Code](https://github.students.cs.ubc.ca/CPSC304-2023W-T2/project_f7k7c_v1r5b_w0i9i/blob/efff9e871d59dab745ce03c5e05a64a49b40bc38/php/oracle-test.php#L401)
![Screenshot 2024-04-05 at 11 36 14 PM](https://media.github.students.cs.ubc.ca/user/16224/files/69d03a62-e073-4042-a94d-75c338dfc5e4)

* Sanitization: executePlainSQL() and executeBoundSQL() functions only execute SQL commands that do not include ";".

* User Response and Error Handling: all results (including errors) are outputting at the bottom of the UI page.
