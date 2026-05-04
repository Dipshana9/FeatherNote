package com.feather.model;

public class Reservation {
	private int id;
    private String date;
    private String time;
    private String tableNumber;
    private String paymentMethod;
    private String userEmail;
    private String status;

    // Constructors
    public Reservation() {}

    public Reservation(String date, String time, String tableNumber, String paymentMethod, String userEmail) {
        this.date = date;
        this.time = time;
        this.tableNumber = tableNumber;
        this.paymentMethod = paymentMethod;
        this.userEmail = userEmail;
    }

    // Getters and Setters (Standard for your MVC setup)
    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }
    public String getTime() { return time; }
    public void setTime(String time) { this.time = time; }
    public String getTableNumber() { return tableNumber; }
    public void setTableNumber(String tableNumber) { this.tableNumber = tableNumber; }
    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
    public String getUserEmail() { return userEmail; }
    public void setUserEmail(String userEmail) { this.userEmail = userEmail; }

}
