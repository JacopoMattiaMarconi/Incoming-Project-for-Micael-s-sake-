package com.example.elaborato;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.stage.Stage;
import javafx.stage.Window;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;

public class LoginController {
    private Connection conn = null;

    @FXML
    private TextField cfField;

    @FXML
    private PasswordField passwordField;

    @FXML
    private Button loginButton;

    @FXML
    protected void onBackButtonClick() throws IOException {
        Stage primaryStage = (Stage) Example.getScene().getWindow();
        Parent newRoot = FXMLLoader.load(getClass().getResource("home.fxml"));
        primaryStage.getScene().setRoot(newRoot);
    }

    @FXML
    protected void login() throws IOException {
        Window owner = loginButton.getScene().getWindow();

        if (conn == null) {
            try {
                conn = DriverManager.getConnection("jdbc:dbPassaporti.sqlite3");
            }catch(SQLException e){}
        }
        String login = "SELECT salt FROM Cittadini where cf = ?";
        try (PreparedStatement stmt = conn.prepareStatement(login)){
            stmt.setString(1, cfField.getText());
            ResultSet rs = stmt.executeQuery(login);
            String salt = rs.getString("salt");
            if(salt.isEmpty()) {
                showAlert(Alert.AlertType.ERROR, owner, "Errore!", "Codice fiscale e/o password errati");
                return;
            }
            String psw = encrypt(salt);
            login = "SELECT nome, cognome FROM Cittadini WHERE cf = ? AND password = ?";
            stmt.executeQuery();
        }catch (SQLException | NoSuchAlgorithmException e){}

    }

    @FXML
    protected void checkFields() {
        if(cfField.getText().length() == 16 && !(passwordField.getText().isEmpty())){
            loginButton.setDisable(false);
        }else{
            loginButton.setDisable(true);
        }
    }

    @FXML
    protected void onRegistrationLinkClick() throws IOException {
        Stage primaryStage = (Stage) Example.getScene().getWindow();
        Parent newRoot = FXMLLoader.load(getClass().getResource("registration.fxml"));
        primaryStage.getScene().setRoot(newRoot);
    }


    private static void showAlert(Alert.AlertType alertType, Window owner, String title, String message) {
        Alert alert = new Alert(alertType);
        alert.setTitle(title);
        alert.setHeaderText(null);
        alert.setContentText(message);
        alert.initOwner(owner);
        alert.show();
    }

    private String encrypt(String salt) throws NoSuchAlgorithmException {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hash = digest.digest(passwordField.getText().getBytes(StandardCharsets.UTF_8));
        String psw = new String(hash);
        psw += salt;
        return new String(digest.digest(psw.getBytes(StandardCharsets.UTF_8)));
    }
}
