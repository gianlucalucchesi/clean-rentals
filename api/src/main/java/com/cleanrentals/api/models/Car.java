package com.cleanrentals.api.models;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

@Entity(name = "car")
@Table(name = "car")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"}) // This prevents an issue with lazy loading (serialization issue)
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

    @Column(name = "image_url", nullable = false)
    private String image_url;

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    @OneToMany(cascade = CascadeType.ALL)
    @JoinColumn(name = "brand_id")
    public Brand getBrand() {
        return brand;
    }

    @Column(name = "start_day_price_euro_excl_vat", nullable = false)
    private float start_day_price_euro_excl_vat;

    @Column(name = "seats", nullable = false)
    private int seats;

    @Column(name = "doors", nullable = false)
    private int doors;

    @Column(name = "year", nullable = false)
    private int year;

    @Column(name = "horsepower", nullable = false)
    private int horsepower;

    @Column(name = "wltp_range_km", nullable = false)
    private int wltp_range_km;

    @Column(name = "battery_capacity_kwh", nullable = false)
    private int battery_capacity_kwh;

    @ManyToMany(cascade = { CascadeType.ALL })
    @JoinTable(
            name = "car_car_option",
            joinColumns = { @JoinColumn(name = "car_id") },
            inverseJoinColumns = { @JoinColumn(name = "car_option_id") }
    )
    Set<CarOption> carOptions = new HashSet<>();

    public void setBrand(Brand brand) {
        this.brand = brand;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getImage_url() {
        return image_url;
    }

    public void setImage_url(String image_url) {
        this.image_url = image_url;
    }

    public float getStart_day_price_euro_excl_vat() {
        return start_day_price_euro_excl_vat;
    }

    public void setStart_day_price_euro_excl_vat(float start_day_price_euro_excl_vat) {
        this.start_day_price_euro_excl_vat = start_day_price_euro_excl_vat;
    }

    public int getSeats() {
        return seats;
    }

    public void setSeats(int seats) {
        this.seats = seats;
    }

    public int getDoors() {
        return doors;
    }

    public void setDoors(int doors) {
        this.doors = doors;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getHorsepower() {
        return horsepower;
    }

    public void setHorsepower(int horsepower) {
        this.horsepower = horsepower;
    }

    public int getWltp_range_km() {
        return wltp_range_km;
    }

    public void setWltp_range_km(int wltp_range_km) {
        this.wltp_range_km = wltp_range_km;
    }

    public int getBattery_capacity_kwh() {
        return battery_capacity_kwh;
    }

    public void setBattery_capacity_kwh(int battery_capacity_kwh) {
        this.battery_capacity_kwh = battery_capacity_kwh;
    }

    public Set<CarOption> getCarOptions() {
        return carOptions;
    }

    public void setCarOptions(Set<CarOption> carOptions) {
        this.carOptions = carOptions;
    }
}
