package main;

import interfaces.LoginInterface;
import javax.swing.SwingUtilities;

public class Main {
    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            new LoginInterface().setVisible(true);
        });
    }
}
