module com.example.elaborato {
    requires javafx.controls;
    requires javafx.fxml;
    requires java.sql;


    opens com.example.elaborato to javafx.fxml;
    exports com.example.elaborato;
}