<!-- This file is based off of the files from the CPSC 304 sample project.

  The script assumes you already have a server set up All OCI commands are
  commands to the Oracle libraries. To get the file to work, you must place it
  somewhere where your Apache server can run it, and you must rename it to have
  a ".php" extension. You must also change the username and password on the
  oci_connect below to be your ORACLE username and password
-->

<?php
// The preceding tag tells the web server to parse the following text as PHP
// rather than HTML (the default)

// The following 3 lines allow PHP errors to be displayed along with the page
// content. Delete or comment out this block when it's no longer needed.
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Set some parameters

// Database access configuration
$config["dbuser"] = "ora_erica4";		// change "cwl" to your own CWL
$config["dbpassword"] = "a55077747";	// change to 'a' + your student number
$config["dbserver"] = "dbhost.students.cs.ubc.ca:1522/stu";
$db_conn = NULL;	// login credentials are used in connectToDB()
$userId = 'stu2666653a45ae23';
$success = true;	// keep track of errors so page redirects only if there are no errors

$show_debug_alert_messages = False; // show which methods are being triggered (see debugAlertMessage())

// The next tag tells the web server to stop parsing the text as PHP. Use the
// pair of tags wherever the content switches to PHP
?>

<html>

<head>
	<title>CPSC 304 Project Group 21</title>
</head>

<body>
    <h1>Welcome to your Recipe Database, Alan Wake! (stu2666653a45ae23)</h1>
	<h2>Reset</h2>
	<p>If you wish to reset the tables press on the reset button.
        If this is the first time you're running this page, you MUST use reset</p>

	<form method="POST" action="oracle-test.php">
		<!-- "action" specifies the file or page that will receive the form data for processing. As with this example, it can be this same file. -->
		<input type="hidden" id="resetTablesRequest" name="resetTablesRequest">
		<p><input type="submit" value="Reset" name="reset"></p>
	</form>

	<hr />

	<h2>Insert your ingredients and allergies!</h2>

    <form method="GET" action="oracle-test.php">
        <input type="hidden" id="showAIFieldsRequest" name="showAIFieldsRequest">
        <p><input type="submit" value="See Current Values" name="showAllergyAndIngredientFields"></p>
    </form>

    <h3>Ingredients:</h3>
	<form method="POST" action="oracle-test.php">
		<input type="hidden" id="insertIngredientQueryRequest" name="insertIngredientQueryRequest">
		Name: <input type="text" name="ingName"> <br /><br />
		Food Group: <input type="text" name="foodGroup"> <br /><br />

		<input type="submit" value="Insert" name="insertSubmit"></p>
	</form>
    <h3>Allergies:</h3>
    <form method="POST" action="oracle-test.php">
        <input type="hidden" id="insertAllergyQueryRequest" name="insertAllergyQueryRequest">
        Allergy Name: <input type="text" name="allergyName"> <br /><br />
        Severity (1 or 0): <input type="text" name="severe"> <br /><br />

        <input type="submit" value="Insert" name="insertSubmit"></p>
    </form>
	<hr />

	<h2>Update Your User Information</h2>
	<p>The values are case sensitive and if you enter in the wrong case, the update statement will not do anything.</p>
    <p>Please note that changes to phone num and address must be made to other values already in the database.
        If you encounter issues please contact system administrators to change your phone num or address.</p>

    <form method="GET" action="oracle-test.php">
        <input type="hidden" id="showUserFieldsRequest" name="showUserFieldsRequest">
        <p><input type="submit" value="See Current Fields" name="showUserFields"></p>
    </form>

	<form method="POST" action="oracle-test.php">
        <label for="attribute">Select attribute:</label>
        <select name="attribute" id="attribute" multiple>
            <option value="email">Email</option>
            <option value="name">Name</option>
            <option value="address">Address</option>
            <option value="phoneNum">Phone Num</option>
        </select>
		<input type="hidden" id="updateQueryRequest" name="updateQueryRequest">
		Old Value: <input type="text" name="oldValue"> <br /><br />
		New Value: <input type="text" name="newValue"> <br /><br />

		<input type="submit" value="Update" name="updateSubmit"></p>
	</form>

    <hr />

    <h2>Remove your user information</h2>
    <p>Enter your current phoneNum or address to delete it from the DB.</p>

    <form method="GET" action="oracle-test.php">
        <input type="hidden" id="showUserFieldsRequest" name="showUserFieldsRequest">
        <p><input type="submit" value="See Current Fields" name="showUserFields"></p>
    </form>

    <form method="POST" action="oracle-test.php">
        <label for="attribute">Select attribute:</label>
        <select name="attribute" id="attribute" multiple>
            <option value="address">Address</option>
            <option value="phoneNum">Phone Num</option>
        </select>
        <input type="hidden" id="deleteQueryRequest" name="deleteQueryRequest">
        Value to Delete: <input type="text" name="value"> <br /><br />

        <input type="submit" value="Update" name="updateSubmit"></p>
    </form>

	<hr />

    <h2>Get Insights into our Recipes</h2>
    <h4>See the number of recipes each ingredient is in</h4>
    <form method="GET" action="oracle-test.php">
        <input type="hidden" id="groupByRequest" name="groupByRequest">
        <p><input type="submit" value="Get Recipes" name="premadeQueries"></p>
    </form>
    <h4>See the recipe names for the recipes with fewer than 5 ingredients</h4>
    <form method="GET" action="oracle-test.php">
        <input type="hidden" id="havingRequest" name="havingRequest">
        <p><input type="submit" value="Get Recipes" name="premadeQueries"></p>
    </form>
    <h4>See the ingredient that appears in the most recipes</h4>
    <form method="GET" action="oracle-test.php">
        <input type="hidden" id="nestedRequest" name="nestedRequest">
        <p><input type="submit" value="Get Ingredient" name="premadeQueries"></p>
    </form>
    <h4>See which recipes you have all the ingredients for!</h4>
    <form method="GET" action="oracle-test.php">
        <input type="hidden" id="divisionRequest" name="divisionRequest">
        <p><input type="submit" value="Get Recipes" name="premadeQueries"></p>
    </form>

    <hr />

    <h2>Make Your own Query for our Recipes</h2>
    <form method="GET" action="oracle-test.php">
        <input type="hidden" id="displayRecipeMatches" name="displayRecipeMatches">
        <input type="submit" value="Show me what fields I can include!" name="selection"></p>
    </form>
    <h4>Please put enter your clause in the text box below. Please only use equalities to have the highest chance of your query working.
        Note that strings should have single quotes around them, and separate clauses can be joined using AND or OR</h4>
    <form method="POST" action="oracle-test.php">
        <input type="hidden" id="performSelection" name="performSelection">
        Query Clause: <input type="text" name="whereClause"> <br /><br />
        <input type="submit" value="Perform Query" name="selectionFinal"></p>
    </form>

	<hr />

	<h2>Look at our DB</h2>
    <h3>First, select a table (press button below to see all options)</h3>
    <form method="GET" action="oracle-test.php">
		<input type="hidden" id="displayTables" name="displayTables">
		<input type="submit" value="Show me all tables!" name="projection"></p>
	</form>

    <h3>Now, select the attributes you want to see:</h3>
    <form method="POST" action="oracle-test.php">
        <input type="hidden" id="displayTableAttributes" name="displayTableAttributes">
        TableName (in CAPS): <input type="text" name="tableName"> <br /><br />
        <input type="submit" value="Show me my attribute options" name="projectionAttributes"></p>
    </form>

    <h5>If you would like to enter multiple attributes, they must be a comma separated list.</h5>
    <form method="POST" action="oracle-test.php">
        <input type="hidden" id="executeProjectionQuery" name="executeProjectionQuery">
        Table Name: <input type="text" name="tableName"> <br /><br />
        Attribute(s): <input type="text" name="attribute"> <br /><br />

        <input type="submit" value="Make my projection" name="projectionFinal"></p>
    </form>
    <hr />

    <h4>Results:</h4>

    <?php
	// The following code will be parsed as PHP

	function debugAlertMessage($message)
	{
		global $show_debug_alert_messages;

		if ($show_debug_alert_messages) {
			echo "<script type='text/javascript'>alert('" . $message . "');</script>";
		}
	}

	function executePlainSQL($cmdstr)
	{ //takes a plain (no bound variables) SQL command and executes it
		//echo "<br>running ".$cmdstr."<br>";
		global $db_conn, $success;

		$statement = oci_parse($db_conn, $cmdstr);
		//There are a set of comments at the end of the file that describe some of the OCI specific functions and how they work

		if (!$statement) {
			echo "<br>Cannot parse the following command: " . $cmdstr . "<br>";
			$e = OCI_Error($db_conn); // For oci_parse errors pass the connection handle
			echo htmlentities($e['message']);
			$success = False;
		}

		$r = oci_execute($statement, OCI_DEFAULT);
		if (!$r) {
			echo "<br>Cannot execute the following command: " . $cmdstr . "<br>";
			$e = oci_error($statement); // For oci_execute errors pass the statementhandle
			echo htmlentities($e['message']);
			$success = False;
		}

		return $statement;
	}
    function executeSQLDisplayNoErrors($cmdstr, $list) {
        global $db_conn, $success;
        $success = True;
        $statement = oci_parse($db_conn, $cmdstr);

        if (!$statement) {
//            echo "<br>Cannot parse the following command: " . $cmdstr . "<br>";
//            $e = OCI_Error($db_conn);
//            echo htmlentities($e['message']);
            $success = False;
        }

        foreach ($list as $tuple) {
            foreach ($tuple as $bind => $val) {
                //echo $val;
                //echo "<br>".$bind."<br>";
                oci_bind_by_name($statement, $bind, $val);
                unset($val); //make sure you do not remove this. Otherwise $val will remain in an array object wrapper which will not be recognized by Oracle as a proper datatype
            }

            $r = oci_execute($statement, OCI_DEFAULT);
            if (!$r) {
                // in this case it's an FK issue
                $success = False;
            }
        }
        return $success;
    }

	function executeBoundSQL($cmdstr, $list)
	{
		/* Sometimes the same statement will be executed several times with different values for the variables involved in the query.
		In this case you don't need to create the statement several times. Bound variables cause a statement to only be
		parsed once and you can reuse the statement. This is also very useful in protecting against SQL injection.
		See the sample code below for how this function is used */

		global $db_conn, $success;
		$statement = oci_parse($db_conn, $cmdstr);

		if (!$statement) {
			echo "<br>Cannot parse the following command: " . $cmdstr . "<br>";
			$e = OCI_Error($db_conn);
			echo htmlentities($e['message']);
			$success = False;
		}

		foreach ($list as $tuple) {
			foreach ($tuple as $bind => $val) {
				//echo $val;
				//echo "<br>".$bind."<br>";
				oci_bind_by_name($statement, $bind, $val);
				unset($val); //make sure you do not remove this. Otherwise $val will remain in an array object wrapper which will not be recognized by Oracle as a proper datatype
			}

			$r = oci_execute($statement, OCI_DEFAULT);
			if (!$r) {
				echo "<br>Cannot execute the following command: " . $cmdstr . "<br>";
				$e = OCI_Error($statement); // For oci_execute errors, pass the statementhandle
				echo htmlentities($e['message']);
				echo "<br>";
				$success = False;
			}
		}
	}

    function executeShowAIFields()
    {
        $result = executePlainSQL("SELECT * FROM allergicTo");
        printAllergicToResult($result);
        $result = executePlainSQL("SELECT * FROM has");
        printHasResult($result);
    }

	function printAllergyResult($result)
	{ //prints results from a select statement
		echo "<br>Retrieved data from table Allergy:<br>";
		echo "<table>";
		echo "<tr><th>AllergyName</th><th>Severity</th></tr>";

        $counter = 0;
		while ($row = OCI_Fetch_Array($result, OCI_ASSOC)) {
            $counter = $counter + 1;
            echo "<tr>" . $row[$counter] . "</tr>";
			echo "<tr><td>" . $row["ALLERGYNAME"] . "</td><td>" . $row["SEVERE"] . "</td></tr>"; //or just use "echo $row[$counter]"
		}

		echo "</table>";
	}

    function printAllergicToResult($result)
    { //prints results from a select statement
        echo "<br>Retrieved data from table allergicTo:<br>";
        echo "<table>";
        echo "<tr><th>User ID</th><th>Allergy Name</th></tr>";

        while ($row = OCI_Fetch_Array($result, OCI_ASSOC)) {
            echo "<tr><td>" . $row["USERID"] . "</td><td>" . $row["ALLERGYNAME"] . "</td></tr>"; //or just use "echo $row[0]"
        }

        echo "</table>";
    }

    function displayUserFields()
    {
        global $userId;
        $result = executePlainSQL("SELECT * FROM user_5");

        echo "<br>Retrieved data from table user:<br>";
        echo "<table>";
        echo "<tr><th>UserID</th><th>Email</th><th>Name</th><th>Address</th><th>PhoneNum</th></tr>";

        while ($row = OCI_Fetch_Array($result, OCI_ASSOC)) {
            echo "<tr><td>" . $row["USERID"] . "</td><td>" . $row["EMAIL"] . "</td><td>" . $row["NAME"] . "</td><td>" . $row["ADDRESS"] . "</td><td>" . $row["PHONENUM"] . "</td></tr>"; //or just use "echo $row[0]"
        }

        echo "</table>";
    }

    function printHasResult($result)
    { //prints results from a select statement
        echo "<br>Updated data from Has ingredient table:<br>";
        echo "<table>";
        echo "<tr><th>User Id</th><th>Ingredient Name</th></tr>";

        while ($row = OCI_Fetch_Array($result, OCI_ASSOC)) {
            echo "<tr><td>" . $row["USERID"] . "</td><td>" . $row["INGNAME"] . "</td></tr>"; //or just use "echo $row[0]"
        }

        echo "</table>";
    }

    function printIngredientResult($result)
    { //prints results from a select statement
        echo "<br>Updated data from Ingredient table:<br>";
        echo "<table>";
        echo "<tr><th>Ing Name</th><th>Food Group</th></tr>";

        while ($row = OCI_Fetch_Array($result, OCI_ASSOC)) {
            echo "<tr><td>" . $row["INGNAME"] . "</td><td>" . $row["FOODGROUP"] . "</td></tr>"; //or just use "echo $row[0]"
        }

        echo "</table>";
    }

	function connectToDB()
	{
		global $db_conn;
		global $config;

		// Your username is ora_(CWL_ID) and the password is a(student number). For example,
		// ora_platypus is the username and a12345678 is the password.
		// $db_conn = oci_connect("ora_cwl", "a12345678", "dbhost.students.cs.ubc.ca:1522/stu");
		$db_conn = oci_connect($config["dbuser"], $config["dbpassword"], $config["dbserver"]);

		if ($db_conn) {
			debugAlertMessage("Database is Connected");
			return true;
		} else {
			debugAlertMessage("Cannot connect to Database");
			$e = OCI_Error(); // For oci_connect errors pass no handle
			echo htmlentities($e['message']);
			return false;
		}
	}

	function disconnectFromDB()
	{
		global $db_conn;

		debugAlertMessage("Disconnect from Database");
		oci_close($db_conn);
	}

    function executeDivision()
    {
        global $userId;

        $result = executePlainSQL("SELECT DISTINCT C1.recipeName FROM RecipeContains C1 WHERE NOT EXISTS (SELECT ingName FROM Has WHERE userId = '" . $userId . "' MINUS SELECT C2.ingredientName FROM RecipeContains C2 WHERE C1.recipeName = C2.recipeName)");
        echo "<br>These are the recipes for which you have all ingredients:<br>";
        echo "<table>";
        echo "<tr><th>Recipe Name</th></tr>";

        while ($row = OCI_Fetch_Array($result, OCI_ASSOC)) {
            echo "<tr><td>" . $row["RECIPENAME"] . "</td></tr>";
//            echo "<tr><td>" . $row[0] . "</td></tr>"; //or just use "echo $row[0]"
        }

        echo "</table>";
    }

    function executeNested()
    {
        $result = executePlainSQL("SELECT r.INGREDIENTNAME, COUNT(Distinct r.RECIPENAME) AS numRecipes
                                            FROM RECIPECONTAINS r
                                            GROUP BY r.INGREDIENTNAME
                                            HAVING COUNT(Distinct r.RECIPENAME) >= ALL (SELECT COUNT(Distinct RECIPENAME)
                                                                                        FROM RECIPECONTAINS
                                                                                        GROUP BY INGREDIENTNAME)");
        echo "<br>Ingredient in the most recipes:<br>";
        echo "<table>";
        echo "<tr><th>Ingredient</th><th>Number of Recipes</th></tr>";

        while ($row = OCI_Fetch_Array($result, OCI_ASSOC)) {
            echo "<tr><td>" . $row["INGREDIENTNAME"] . "</td><td>" . $row["NUMRECIPES"] . "</td></tr>";
//            echo "<tr><td>" . $row[0] . "</td></tr>"; //or just use "echo $row[0]"
        }

        echo "</table>";
    }

    function executeHaving()
    {
        $result = executePlainSQL("SELECT r.RECIPENAME, COUNT(r.INGREDIENTNAME) AS numIngredients
                                            FROM RECIPECONTAINS r
                                            GROUP BY r.RECIPENAME
                                            HAVING COUNT(r.INGREDIENTNAME) < 5");
        echo "<br>Recipes with fewer than 5 ingredients:<br>";
        echo "<table>";
        echo "<tr><th>Recipe Name</th><th>Number of Ingredients</th></tr>";

        while ($row = OCI_Fetch_Array($result, OCI_ASSOC)) {
            echo "<tr><td>" . $row["RECIPENAME"] . "</td><td>" . $row["NUMINGREDIENTS"] . "</td></tr>";

//            echo "<tr><td>" . $row[0] . "</td></tr>"; //or just use "echo $row[0]"
        }

        echo "</table>";
    }

    function executeGroupBy()
    {
        $result = executePlainSQL("SELECT r.INGREDIENTNAME, COUNT(r.RECIPENAME) AS numRecipes
                                            FROM RECIPECONTAINS r
                                            GROUP BY r.INGREDIENTNAME");
        echo "<br>Number of recipes each ingredient is in:<br>";
        echo "<table>";
        echo "<tr><th>Ingredient Name</th><th>Number of Recipes</th></tr>";

        while ($row = OCI_Fetch_Array($result, OCI_ASSOC)) {
            echo "<tr><td>" . $row["INGREDIENTNAME"] . "</td><td>" . $row["NUMRECIPES"] . "</td></tr>";
//            echo "<tr><td>" . $row[0] . "</td></tr>"; //or just use "echo $row[0]"
        }

        echo "</table>";
    }

	function handleUpdateRequest()
	{
		global $db_conn;
        global $userId;

		$oldValue = $_POST['oldValue'];
		$newValue = $_POST['newValue'];
        $attribute = $_POST['attribute'];

		// you need the wrap the old name and new name values with single quotations
        // NOTE: FK would be an issue - currently will just reject (can update email if UNIQUE, just phone num and address are harder)
		executePlainSQL("UPDATE user_5 SET  " . $attribute . " = '" . $newValue . "' WHERE " . $attribute . "='" . $oldValue . "'");
        oci_commit($db_conn);

        displayUserFields();
	}

    function handleDeleteRequest()
    {
        global $db_conn;

        $valueToDelete = $_POST['value'];
        $attribute = $_POST['attribute'];
        if ($attribute == 'phoneNum') {
            displayUser2Fields();
            executePlainSQL("DELETE FROM user_2 WHERE  " . $attribute . " = '" . $valueToDelete. "'");
            oci_commit($db_conn);
            displayUser2Fields();
        } else {
            displayUser6Fields();
            executePlainSQL("DELETE FROM user_6 WHERE  " . $attribute . " = '" . $valueToDelete. "'");
            oci_commit($db_conn);
            displayUser6Fields();
        }
        displayUserFields();
    }

    function displayUser6Fields()
    {
        $result = executePlainSQL("SELECT * FROM user_6");

        echo "<br>Retrieved data from table user:<br>";
        echo "<table>";
        echo "<tr><th>Address</th><th>Postal Code</th></tr>";

        while ($row = OCI_Fetch_Array($result, OCI_ASSOC)) {
            echo "<tr><td>" . $row["ADDRESS"] . "</td><td>" . $row["POSTALCODE"] . "</td></tr>"; //or just use "echo $row[0]"
        }

        echo "</table>";
    }

    function displayUser2Fields()
    {
        $result = executePlainSQL("SELECT * FROM user_2");

        echo "<br>Retrieved data from table user:<br>";
        echo "<table>";
        echo "<tr><th>Phone Num</th><th>Country</th></tr>";

        while ($row = OCI_Fetch_Array($result, OCI_ASSOC)) {
            echo "<tr><td>" . $row["PHONENUM"] . "</td><td>" . $row["COUNTRY"] . "</td></tr>"; //or just use "echo $row[0]"
        }

        echo "</table>";
    }

    function handleResetRequest()
	{
		global $db_conn;

		// Drop all old tables
        $txt_file    = file_get_contents('dropTables.sql');
        $rows        = explode(";", $txt_file);

        foreach($rows as $row => $data)
        {
            executePlainSQL($data);
        }

		// Create new table
		echo "<br> creating new tables <br>";
        $txt_file    = file_get_contents('addTables.sql');
        $rows        = explode(";", $txt_file);

        foreach($rows as $row => $data)
        {
            executePlainSQL($data);
        }

        // populate tables
        echo "<br> inserting basic values into tables <br>";
        $txt_file    = file_get_contents('insertBasicValues.sql');
        $rows        = explode(";", $txt_file);

        foreach($rows as $row => $data)
        {
            if (!empty(trim($data))) {
                executePlainSQL($data);
            }
        }
		oci_commit($db_conn);
	}

    function handleIngredientInsertRequest()
    {
        global $db_conn;
        global $userId;

        $tuple1 = array(
            ":bind1" => $userId,
            ":bind2" => $_POST['ingName']
        );

        $tuple2 = array(
            ":bind1" => $_POST['ingName'],
            ":bind2" => $_POST['foodGroup']
        );

        $hasTuples = array(
            $tuple1
        );

        $ingTuples = array(
            $tuple2
        );
        if (!executeSQLDisplayNoErrors("insert into has values (:bind1, :bind2)", $hasTuples)) {
            echo "<br> inserting ingredient into ingredient list<br>";
            // this takes care of FK issue
            executeBoundSQL("insert into ingredient values (:bind1, :bind2)", $ingTuples);
            oci_commit($db_conn);

            $result = executePlainSQL("SELECT * FROM ingredient");
            printIngredientResult($result);

            executeBoundSQL("insert into has values (:bind1, :bind2)", $hasTuples);
        }

        oci_commit($db_conn);
        $result = executePlainSQL("SELECT * FROM has");
        printHasResult($result);
    }

    function handleAllergyInsertRequest()
    {
        global $db_conn;
        global $userId;

        $tuple1 = array(
            ":bind1" => $userId,
            ":bind2" => $_POST['allergyName']
        );

        $tuple2 = array(
            ":bind1" => $_POST['allergyName'],
            ":bind2" => $_POST['severe']
        );

        $allergicToTuples = array(
            $tuple1
        );

        $allergyTuples = array(
            $tuple2
        );
        if (!executeSQLDisplayNoErrors("insert into allergicTo values (:bind1, :bind2)", $allergicToTuples)) {
            echo "<br> inserting allergy into allergy list<br>";
            // this takes care of FK issue
            executeBoundSQL("insert into allergy values (:bind1, :bind2)", $allergyTuples);
            oci_commit($db_conn);

            $result = executePlainSQL("SELECT * FROM allergy");
            printAllergyResult($result);

            executeBoundSQL("insert into allergicTo values (:bind1, :bind2)", $allergicToTuples);
        }
        oci_commit($db_conn);
        $result = executePlainSQL("SELECT * FROM allergicTo");
        printAllergicToResult($result);
    }

	function handleCountRequest()
	{
		global $db_conn;

		$result = executePlainSQL("SELECT Count(*) FROM allergy");

		if (($row = oci_fetch_row($result)) != false) {
			echo "<br> The number of tuples in demoTable: " . $row[0] . "<br>";
		}
	}

    function showSelection()
    {
        $result = executePlainSQL("SELECT * FROM recipematches_1 WHERE " . $_POST['whereClause']);

        echo "<br>Result of selection:<br>";
        echo "<table>";
//        echo "<tr><th>" . $_POST['attribute'] . "</th></tr>";

//        $counter = 0;
        while ($row = OCI_Fetch_Array($result, OCI_ASSOC)) {
            echo "<tr>";
            // Loop through each column in the row
            foreach ($row as $column => $value) {
                echo "<td>" . $value . "</td>";
            }
            echo "<tr>";
        }
//        while ($row = OCI_Fetch_Array($result, OCI_ASSOC)) {
//            echo "<tr><td>" . $row[$counter] . "</td></tr>"; //or just use "echo $row[0]"
//            $counter = $counter + 1;
//        }

        echo "</table>";
    }

    function showRecipeMatches()
    {
        $result = executePlainSQL("select column_name, data_type from user_tab_columns where table_name = 'RECIPEMATCHES_1'");

        echo "<br>All attributes:<br>";
        echo "<table>";
        echo "<tr><th>Attribute</th><th>Type</th></tr>";

        while ($row = OCI_Fetch_Array($result, OCI_ASSOC)) {
            echo "<tr><td>" . $row["COLUMN_NAME"] . "</td><td>" . $row["DATA_TYPE"] . "</td></tr>"; //or just use "echo $row[0]"
        }

        echo "</table>";
    }

    function showProjection()
    {
        $result = executePlainSQL("SELECT " . $_POST['attribute'] . " FROM " . $_POST['tableName']);

        echo "<br>Result of projection:<br>";
        echo "<table>";
        echo "<tr><th>" . $_POST['attribute'] . "</th></tr>";

//        $counter = 0;
        while ($row = OCI_Fetch_Array($result, OCI_ASSOC)) {
            echo "<tr>";
            // Loop through each column in the row
            foreach ($row as $column => $value) {
                echo "<td>" . $value . "</td>";
            }
            echo "<tr>";
        }
//        while ($row = OCI_Fetch_Array($result, OCI_ASSOC)) {
//            echo "<tr><td>" . $row[$counter] . "</td></tr>"; //or just use "echo $row[0]"
//            $counter = $counter + 1;
//        }

        echo "</table>";
    }

    function showTableAttributes()
    {
        $result = executePlainSQL("select column_name from user_tab_columns where table_name = '" . $_POST['tableName'] . "'");

        echo "<br>All attributes:<br>";
        echo "<table>";
        echo "<tr><th>Attribute</th></tr>";

        while ($row = OCI_Fetch_Array($result, OCI_ASSOC)) {
            echo "<tr><td>" . $row["COLUMN_NAME"] . "</td></tr>"; //or just use "echo $row[0]"
        }

        echo "</table>";
    }

    function showTables()
    {
        $result = executePlainSQL("select table_name from user_tables");

        echo "<br>All Tables:<br>";
        echo "<table>";
        echo "<tr><th>Table Name</th></tr>";

        while ($row = OCI_Fetch_Array($result, OCI_ASSOC)) {
            echo "<tr><td>" . $row["TABLE_NAME"] . "</td></tr>"; //or just use "echo $row[0]"
        }

        echo "</table>";
    }

	function handleDisplayRequest()
	{
		global $db_conn;
		$result = executePlainSQL("SELECT * FROM allergy");
		printAllergyResult($result);
	}

	// HANDLE ALL POST ROUTES
	// A better coding practice is to have one method that reroutes your requests accordingly. It will make it easier to add/remove functionality.
	function handlePOSTRequest()
	{
		if (connectToDB()) {
			if (array_key_exists('resetTablesRequest', $_POST)) {
				handleResetRequest();
			} else if (array_key_exists('updateQueryRequest', $_POST)) {
				handleUpdateRequest();
			} else if (array_key_exists('deleteQueryRequest', $_POST)) {
                handleDeleteRequest();
            } else if (array_key_exists('insertAllergyQueryRequest', $_POST)) {
                handleALlergyInsertRequest();
			} else if (array_key_exists('insertIngredientQueryRequest', $_POST)) {
                handleIngredientInsertRequest();
			} elseif (array_key_exists('displayTableAttributes', $_POST)) {
                showTableAttributes();
            } elseif (array_key_exists('executeProjectionQuery', $_POST)) {
                showProjection();
            } elseif (array_key_exists('performSelection', $_POST)) {
                showSelection();
            }

			disconnectFromDB();
		}
	}

    // HANDLE ALL GET ROUTES
	// A better coding practice is to have one method that reroutes your requests accordingly. It will make it easier to add/remove functionality.
	function handleGETRequest()
	{
		if (connectToDB()) {
			if (array_key_exists('countTuples', $_GET)) {
				handleCountRequest();
			} elseif (array_key_exists('displayTuples', $_GET)) {
				handleDisplayRequest();
			} elseif (array_key_exists('showUserFieldsRequest', $_GET)) {
                displayUserFields();
            } elseif (array_key_exists('groupByRequest', $_GET)) {
                executeGroupBy();
            } elseif (array_key_exists('havingRequest', $_GET)) {
                executeHaving();
            } elseif (array_key_exists('nestedRequest', $_GET)) {
                executeNested();
            } elseif (array_key_exists('divisionRequest', $_GET)) {
                executeDivision();
            } elseif (array_key_exists('showAIFieldsRequest', $_GET)) {
                executeShowAIFields();
            } elseif (array_key_exists('displayTables', $_GET)) {
                showTables();
            }  elseif (array_key_exists('displayRecipeMatches', $_GET)) {
                showRecipeMatches();
            }

			disconnectFromDB();
		}
	}

    if (isset($_POST['reset']) || isset($_POST['updateSubmit']) || isset($_POST['insertSubmit'])
        || isset($_POST['projectionAttributes']) || isset($_POST['projectionFinal']) || isset($_POST['selectionFinal'])) {
		handlePOSTRequest();
	} else if (isset($_GET['countTupleRequest']) || isset($_GET['displayTuplesRequest']) || isset($_GET['showUserFields'])
        || isset($_GET['premadeQueries']) || isset($_GET['showAllergyAndIngredientFields']) || isset($_GET['projection']) || isset($_GET['selection'])) {
		handleGETRequest();
	}

	// End PHP parsing and send the rest of the HTML content
	?>
</body>

</html>
