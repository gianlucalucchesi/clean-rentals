package com.cleanrentals.api.models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

@Entity(name = "reservation_option")
@Table(name = "reservation_option")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
// This prevents an issue with lazy loading (serialization issue)
public class ReservationOption {
    @Id
    @Column(name = "id", nullable = false)
    private UUID id;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "description", nullable = true)
    private String description;

    @Column(name = "day_price_euro_excl_vat", nullable = false)
    private float day_price_euro_excl_vat;

    @ManyToMany(mappedBy = "reservationOptions")
    @JsonIgnore // This fixes infinite recursion in JSON
    private Set<Reservation> reservation = new HashSet<>();

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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public float getDay_price_euro_excl_vat() {
        return day_price_euro_excl_vat;
    }

    public void setDay_price_euro_excl_vat(float day_price_euro_excl_vat) {
        this.day_price_euro_excl_vat = day_price_euro_excl_vat;
    }

    public Set<Reservation> getReservation() {
        return reservation;
    }

    public void setReservation(Set<Reservation> reservation) {
        this.reservation = reservation;
    }
}
