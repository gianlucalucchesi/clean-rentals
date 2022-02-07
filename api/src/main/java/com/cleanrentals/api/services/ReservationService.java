package com.cleanrentals.api.services;

import com.cleanrentals.api.exceptions.ConflictException;
import com.cleanrentals.api.exceptions.NotFoundException;
import com.cleanrentals.api.models.Client;
import com.cleanrentals.api.models.Reservation;
import com.cleanrentals.api.repositories.ReservationRepository;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class ReservationService {
    @Autowired
    private ReservationRepository reservationRepository;
    @Autowired
    private ClientService clientService;

    public List<Reservation> findAll() {
        return this.reservationRepository.findAll();
    }

    public Reservation findById(UUID id) throws NotFoundException {
        Optional<Reservation> optionalReservation = reservationRepository.findById(id);

        if (optionalReservation.isEmpty()) {
            throw new NotFoundException(String.format("Reservation with id %s not found", id));
        }

        return optionalReservation.get();
    }

    public List<Reservation> findByClientId(UUID id) throws NotFoundException {
        Client client = this.clientService.findById(id);
        Optional<List<Reservation>> optionalReservationList = reservationRepository.findByClient(client);

        if (optionalReservationList.get().isEmpty()) {
            throw new NotFoundException(String.format("No reservations found for client with id %s", id));
        }

        return optionalReservationList.get();
    }

    /**
     * Rollback annotation: if ConflictException occurs
     * https://stackoverflow.com/a/62430809
     * @param reservation
     * @return
     * @throws ConflictException
     */
    @Transactional(rollbackFor = ConflictException.class)
    public Reservation create(Reservation reservation) throws ConflictException {
        if(reservation.getId() != null) {
            Optional<Reservation> optionalReservation = this.reservationRepository.findById(reservation.getId());

            if (optionalReservation.isPresent())
                throw new ConflictException(String.format("Reservation %s already exists", reservation.getId()));
        }

        if(reservation.getId() == null)
            reservation.setId(UUID.randomUUID());

        reservationRepository.saveAndFlush(reservation);

        List<Reservation> inDbReservations = reservationRepository.findReservationBetweenDates(
                reservation.getCar(), reservation.getDateTimeStart(), reservation.getDateTimeStop());

        if(inDbReservations.size() > 1) {
            throw new ConflictException(String.format("Double reservation for the same car"));
        }

        reservationRepository.flush();
        return reservation;
    }
}
