package com.cleanrentals.api.repositories;

import com.cleanrentals.api.models.ReservationOption;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface ReservationOptionRepository extends JpaRepository<ReservationOption, UUID> {
}
