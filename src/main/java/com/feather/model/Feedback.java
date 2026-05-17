package com.feather.model;

public class Feedback {
    private int id;
    private String username;
    private String message;
    private String reply;
    private String createdAt;

    // Constructors
    public Feedback() {}

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    public String getReply() { return reply; }
    public void setReply(String reply) { this.reply = reply; }
    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
}