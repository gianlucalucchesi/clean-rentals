package com.cleanrentals.api.models;

public class ReservationFinalizationDTO {
    private String review;
    private String imagePath;

    public String getReview() {
        return this.review;
    }

    public void setReview(String review) {
        this.review = review;
    }

    public String getImagePath() {
        return this.imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

}
