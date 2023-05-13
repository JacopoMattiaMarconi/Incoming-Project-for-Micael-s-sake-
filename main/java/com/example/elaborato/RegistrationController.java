package com.example.elaborato;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.control.*;
import javafx.scene.layout.Background;
import javafx.scene.layout.BackgroundFill;
import javafx.scene.paint.Color;
import javafx.stage.Stage;
import javafx.stage.Window;

import java.io.IOException;

public class RegistrationController {

    @FXML
    private TextField nameField;

    @FXML
    private TextField surnameField;

    @FXML
    private TextField cfField;

    @FXML
    private DatePicker dateField;

    @FXML
    private TextField placeField;

    @FXML
    private PasswordField password;

    @FXML
    private PasswordField passwordConfirm;

    @FXML
    private Button registrationButton;

    @FXML
    protected void onBackButtonClick() throws IOException {
        Stage primaryStage = (Stage) Example.getScene().getWindow();
        Parent newRoot = FXMLLoader.load(getClass().getResource("home.fxml"));
        primaryStage.getScene().setRoot(newRoot);
    }

    @FXML
    protected void registration() throws IOException {
        Window owner = registrationButton.getScene().getWindow();

        if (nameField.getText().isEmpty()) {
            nameField.setStyle("-fx-background-color: red;");
            showAlert(Alert.AlertType.WARNING, owner, "Errore!", "Inserisci il codice fiscale");
            return;
        }
        if (cfField.getText().isEmpty()) {
            showAlert(Alert.AlertType.WARNING, owner, "Errore!", "Inserisci il codice fiscale");
            return;
        }
        if (password.getText().isEmpty()) {
            showAlert(Alert.AlertType.WARNING, owner, "Errore!", "Inserisci la Password");
            return;
        }
    }

    private static void showAlert(Alert.AlertType alertType, Window owner, String title, String message) {
        Alert alert = new Alert(alertType);
        alert.setTitle(title);
        alert.setHeaderText(null);
        alert.setContentText(message);
        alert.initOwner(owner);
        alert.show();
    }
}
