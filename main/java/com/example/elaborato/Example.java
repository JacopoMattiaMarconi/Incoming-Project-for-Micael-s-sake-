package com.example.elaborato;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.stage.Stage;

import java.io.IOException;

public class Example extends Application {
    static Scene scene;
    public static Scene getScene() {
        return scene;
    }

    @Override
    public void start(Stage stage) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(Example.class.getResource("home.fxml"));
        scene = new Scene(fxmlLoader.load(), 1280, 720);
        stage.setTitle("Portale Passaporto Repubblica Italiana");

        stage.setScene(scene);
        stage.show();
    }

    public static void main(String[] args) {
        launch();
    }
}