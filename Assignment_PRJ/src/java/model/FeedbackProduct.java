package model;

public class FeedbackProduct {
    private int id, score;
    private String userName, text;

    public FeedbackProduct() {
    }

    public FeedbackProduct(int id, int score, String userName, String text) {
        this.id = id;
        this.score = score;
        this.userName = userName;
        this.text = text;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
    
    
}
