package com.cleanrentals.api.models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;
import java.util.UUID;

@Entity(name = "car")
@Table(name = "car")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})  // This prevents an issue with lazy loading (serialization issue)
public class Car {
    @Id
    @Column(name = "id", nullable = false)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "brand_id", nullable = false)
//    @JsonIgnore
    private Brand brand;

    @Column(name = "model", nullable = false)
    private String model;

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    @OneToMany(cascade=CascadeType.ALL)
    @JoinColumn(name="brand_id")
    public Brand getBrand() {
        return brand;
    }

    public void setBrand(Brand brand) {
        this.brand = brand;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }
}
