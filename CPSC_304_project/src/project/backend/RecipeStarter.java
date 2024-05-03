package project.backend;

import project.config;
import project.connection.DatabaseConnectionHandler;

// CREDIT: constructor, main and start functions based off of sample project
public class RecipeStarter {
    private DatabaseConnectionHandler dbHandler = null;

    public RecipeStarter() {
        dbHandler = new DatabaseConnectionHandler();
    }

    private void start() {
        // TODO start the UI login page, placeholder for now (called with username and password):
        if (!dbHandler.login(config.username, config.password)) {
            System.out.println("issue logging in");
        }
        dbHandler.databaseSetup();
        System.out.println("end of database setup");
    }

    public static void main(String[] args) {
        RecipeStarter starter = new RecipeStarter();
        starter.start();
    }
}
