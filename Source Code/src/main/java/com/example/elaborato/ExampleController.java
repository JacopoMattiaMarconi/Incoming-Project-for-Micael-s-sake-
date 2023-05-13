package com.example.elaborato;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.control.Label;
import javafx.stage.Stage;
import java.sql.*;

import java.io.IOException;

public class ExampleController {
    @FXML
    protected void onCitizensButtonClick() throws IOException {
        Stage primaryStage = (Stage) Example.getScene().getWindow();
        Parent newRoot = FXMLLoader.load(getClass().getResource("loginCitizens.fxml"));
        primaryStage.getScene().setRoot(newRoot);
    }

    @FXML
    protected void onAdministrationButtonClick() throws IOException {
        Stage primaryStage = (Stage) Example.getScene().getWindow();
        Parent newRoot = FXMLLoader.load(getClass().getResource("loginAdministration.fxml"));
        primaryStage.getScene().setRoot(newRoot);
    }

    @FXML
    protected void onBackButtonClick() throws IOException {
        Stage primaryStage = (Stage) Example.getScene().getWindow();
        Parent newRoot = FXMLLoader.load(getClass().getResource("home.fxml"));
        primaryStage.getScene().setRoot(newRoot);
    }
}