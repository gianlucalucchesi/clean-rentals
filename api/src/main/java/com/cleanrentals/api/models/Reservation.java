package com.cleanrentals.api.models;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

@Entity(name = "reservation")
@Table(name = "reservation")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
// This prevents an issue with lazy loading (serialization issue)
public class Reservation {
    @ManyToMany(cascade = {CascadeType.ALL})
    @JoinTable(name = "reservation_reservation_option", joinColumns = {@JoinColumn(name = "reservation_id")}, inverseJoinColumns = {@JoinColumn(name = "reservation_option_id")})
    Set<ReservationOption> reservationOptions = new HashSet<>();
    @Id
    @Column(name = "id", nullable = false)
    private UUID id;
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "client_id", nullable = false)
    private Client client;
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "car_id", nullable = false)
    private Car car;
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "location_id", nullable = false)
    private Location location;
    @Column(name = "date_time_start", nullable = false)
    private Date dateTimeStart;
    @Column(name = "date_time_stop", nullable = false)
    private Date dateTimeStop;
    @Column(name = "total_price_euro_excl_vat", nullable = false)
    private float total_price_euro_excl_vat;
    @Column(name = "review_text", nullable = true)
    private String review_text;
    @Column(name = "paid", nullable = false)
    private boolean paid;
    @Column(name = "returned", nullable = false)
    private boolean returned;

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }

    public Car getCar() {
        return car;
    }

    public void setCar(Car car) {
        this.car = car;
    }

    public Location getLocation() {
        return location;
    }

    public void setLocation(Location location) {
        this.location = location;
    }

    public Date getDateTimeStart() {
        return dateTimeStart;
    }

    public void setDateTimeStart(Date dateTimeStart) {
        this.dateTimeStart = dateTimeStart;
    }

    public Date getDateTimeStop() {
        return dateTimeStop;
    }

    public void setDateTimeStop(Date dateTimeStop) {
        this.dateTimeStop = dateTimeStop;
    }

    public float getTotal_price_euro_excl_vat() {
        return this.total_price_euro_excl_vat;
    }

    public void setTotal_price_euro_excl_vat(float total_price_euro_excl_vat) {
        this.total_price_euro_excl_vat = total_price_euro_excl_vat;
    }

    public Set<ReservationOption> getReservationOptions() {
        return this.reservationOptions;
    }

    public void setReservationOptions(Set<ReservationOption> reservationOptions) {
        this.reservationOptions = reservationOptions;
    }

    public String getReview_text() {
        return this.review_text;
    }

    public void setReview_text(String review_text) {
        this.review_text = review_text;
    }

    public boolean getPaid() {
        return this.paid;
    }

    public void setPaid(boolean paid) {
        this.paid = paid;
    }

    public boolean getReturned() {
        return this.returned;
    }

    public void setReturned(boolean returned) {
        this.returned = returned;
    }
}
