package com.example.elaborato;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.stage.Stage;
import java.sql.*;

import java.io.IOException;

public class HomeController {
    @FXML
    private Button richiestaButton;

    @FXML
    private Button ritiroButton;

    @FXML
    protected void onLogoutClick() throws IOException {
        Stage primaryStage = (Stage) Example.getScene().getWindow();
        Parent newRoot = FXMLLoader.load(getClass().getResource("home.fxml"));
        primaryStage.getScene().setRoot(newRoot);
    }

    @FXML
    protected void onRichiestaButtonClick() throws IOException{
        Stage primaryStage = (Stage) Example.getScene().getWindow();
        Parent newRoot = FXMLLoader.load(getClass().getResource("home.fxml"));
        primaryStage.getScene().setRoot(newRoot);
    }

    @FXML
    protected void onRitiroButtonClick() throws IOException{
        Stage primaryStage = (Stage) Example.getScene().getWindow();
        Parent newRoot = FXMLLoader.load(getClass().getResource("home.fxml"));
        primaryStage.getScene().setRoot(newRoot);
    }
}