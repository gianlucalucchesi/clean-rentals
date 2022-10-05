package com.cleanrentals.api.models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

@Entity(name = "car_option")
@Table(name = "car_option")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
// This prevents an issue with lazy loading (serialization issue)
public class CarOption {
    @Id
    @Column(name = "id", nullable = false)
    private UUID id;

    @Column(name = "name", nullable = false)
    private String name;

    @ManyToMany(mappedBy = "carOptions")
    @JsonIgnore // This fixes infinite recursion in JSON
    private Set<Car> car = new HashSet<>();

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

}
